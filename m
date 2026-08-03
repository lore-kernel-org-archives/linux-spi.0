Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991DE4137BC;
	Mon,  3 Aug 2026 14:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767191; cv=none; b=G7DWiAaQpZwzriECoBtxApoC+lfMErVQMpKEAUuFbWnx/YBPpGOdBq1HBogRs1Buh+EuyFJU1Ig1yvSeirlPx9NivoPeGs1qdW2eGXt5ggqKVhETujzOc+RdpbW9skCyxvWMog/mPypZuq3gjg3oIbmmPn+0ApQ85MhVv89tdmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767191; c=relaxed/simple;
	bh=ePOEQ0J9N+kUqGgYqSK/NsqJBMLJ9w65t/aYJGm58OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlOd2xirKLXNWWr0CXfK3oIWzJa8HZSzzgt1yV42S4C7b9n30VSQtpQ8LwwbtDjL4qxdTT+Z/9i0uP5rGrAHOr/Py87bofFt/1hupWd3IlmEnhwLQDVB6W1vlqnwbpF6dzTLHgVfblQMnOOFe7MGR9q/im8Wpspps2KpiPJmfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llFnuryA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llFnuryA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987071F00A3A;
	Mon,  3 Aug 2026 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785767190;
	bh=9AW5+unKAvpVhjnUAoalVNN2z6ryvFQkPo5pHGL5yy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=llFnuryAS7cphq2r1ngS2a8xNxN0jY6v/7/ycmqorjyb08Atd/HtkmZ2PZ5Nw2nNZ
	 u2qqkecwoM3zZF1y2rO+Cj8pk6VkvF64S9XWzYTBiAJDTZIW6znaZRBGPuwXLrCXUK
	 toSmOdbCJueYGkKm/uYGDNQJz5Qq69OUe1pa7mkGK7f2Niw3TOLvWwWLCLe4nvFxcS
	 RweyBoau1B8ki49sfMtbzszMlmBuosJztYQ6f9llg0G0Ijq6jDsJHXd2OqfglWQIqk
	 x8bm4AX4n6darDtKEiPIrYG8+YTwqa0csw/V98BL0HCbUjAMv0Ls7943BvLHSIj43z
	 VKqa6ko7dUKug==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] spi: dw: use threaded interrupt and optimize the threaded ISR
Date: Mon,  3 Aug 2026 22:06:49 +0800
Message-ID: <20260803140649.12718-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260803140649.12718-1-jszhang@kernel.org>
References: <20260803140649.12718-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid blocking for an excessive amount of time, eventually impacting
on system responsiveness, hard interrupt handlers should finish
executing in as little time as possible.

Use threaded interrupt and move the SPI transfer handling to an
interrupt thread.

After that, since the dw_reader() and dw_writer() are called in
threaded ISR now, so we can delay the unmasking interrupts until no
rx and tx action is taken, thus reduce the interrupt numbers further.

Tested with below two cmds
./spidev_test -D /dev/spidev1.3 -s 30000000 -S 327680 -I 1

./spidev_test -D /dev/spidev1.3 -s 30000000 -S 327680 -I 1000
./rtla timerlat top -q -k -P f:95

The first cmd is to check the interrupt numbers optmizaion result, the
2nd cmd group is to check the threaded interrupt improvement.

Before the patch:
each 320KB spi spidev_test transfer triggers 33118 interrupts

spidev_test reports ~22090 kbps
and rtla reports:
                                     Timer Latency
  0 00:00:37   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
  0 #9958      |        1         0        67    103394 |        6         4      2198    105031
  1 #36902     |        1         0         1        18 |        5         4         5        29

After the patch:
each 320KB spi spidev_test transfer only triggers 1 interrupts
spidev_test reports ~23520 kbps
and now rtla reports:
                                    Timer Latency
  0 00:00:58   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
  0 #58362     |        1         0         0        29 |        6         3         4        56
  1 #58363     |        1         0         1        23 |        6         4         5        68

In summary:
before the patch	after the patch
33118 interrutps	1 interrupts		reduced by 33117 times!
103394 us max latency	29 us max latency	reduced by 3564 times!
22090 kbps rate		23520 kbps rate		improved by 6.5%

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 88 +++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 460e77b34ed9..a5ca893bd118 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -132,10 +132,11 @@ static inline u32 dw_spi_rx_max(struct dw_spi *dws)
 	return min_t(u32, dws->rx_len, dw_readl(dws, DW_SPI_RXFLR));
 }
 
-static void dw_writer(struct dw_spi *dws)
+static u32 dw_writer(struct dw_spi *dws)
 {
 	u32 max = dw_spi_tx_max(dws);
 	u32 txw = 0;
+	u32 tx = 0;
 
 	while (max--) {
 		if (dws->tx) {
@@ -150,13 +151,16 @@ static void dw_writer(struct dw_spi *dws)
 		}
 		dw_write_io_reg(dws, DW_SPI_DR, txw);
 		--dws->tx_len;
+		++tx;
 	}
+	return tx;
 }
 
-static void dw_reader(struct dw_spi *dws)
+static u32 dw_reader(struct dw_spi *dws)
 {
 	u32 max = dw_spi_rx_max(dws);
 	u32 rxw;
+	u32 rx = 0;
 
 	while (max--) {
 		rxw = dw_read_io_reg(dws, DW_SPI_DR);
@@ -171,7 +175,9 @@ static void dw_reader(struct dw_spi *dws)
 			dws->rx += dws->n_bytes;
 		}
 		--dws->rx_len;
+		++rx;
 	}
+	return rx;
 }
 
 int dw_spi_check_status(struct dw_spi *dws, bool raw)
@@ -210,42 +216,60 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
 }
 EXPORT_SYMBOL_NS_GPL(dw_spi_check_status, "SPI_DW_CORE");
 
-static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
+static irqreturn_t dw_spi_irq_thread_fn(int irq, void *dev_id)
 {
-	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
+	struct spi_controller *ctlr = dev_id;
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	u32 rx, tx, imask, mask = 0;
+	bool finalize = false;
 
-	if (dw_spi_check_status(dws, false)) {
+	do {
+		/*
+		 * Read data from the Rx FIFO every time we've got a chance executing
+		 * this method. If there is nothing left to receive, terminate the
+		 * procedure. Otherwise adjust the Rx FIFO Threshold level if it's a
+		 * final stage of the transfer. By doing so we'll get the next IRQ
+		 * right when the leftover incoming data is received.
+		 */
+		rx = dw_reader(dws);
+		if (!dws->rx_len) {
+			mask |= DW_SPI_INT_MASK;
+			finalize = true;
+		} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
+			dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
+		}
+
+		/*
+		 * Send data out as much as possible. The Tx FIFO Empty IRQ will be
+		 * disabled after the data transmission is finished so not to
+		 * have the TXE IRQ flood at the final stage of the transfer.
+		 */
+		tx = dw_writer(dws);
+		if (!dws->tx_len)
+			mask |= DW_SPI_INT_TXEI;
+	} while (rx != 0 || tx != 0);
+
+	imask = DW_SPI_INT_TXEI | DW_SPI_INT_TXOI |
+		DW_SPI_INT_RXUI | DW_SPI_INT_RXOI | DW_SPI_INT_RXFI;
+	imask &= ~mask;
+	dw_spi_umask_intr(dws, imask);
+
+	if (finalize)
 		spi_finalize_current_transfer(dws->ctlr);
-		return IRQ_HANDLED;
-	}
 
-	/*
-	 * Read data from the Rx FIFO every time we've got a chance executing
-	 * this method. If there is nothing left to receive, terminate the
-	 * procedure. Otherwise adjust the Rx FIFO Threshold level if it's a
-	 * final stage of the transfer. By doing so we'll get the next IRQ
-	 * right when the leftover incoming data is received.
-	 */
-	dw_reader(dws);
-	if (!dws->rx_len) {
-		dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
+{
+	if (dw_spi_check_status(dws, false)) {
 		spi_finalize_current_transfer(dws->ctlr);
-	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
-		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
+		return IRQ_HANDLED;
 	}
 
-	/*
-	 * Send data out if Tx FIFO Empty IRQ is received. The IRQ will be
-	 * disabled after the data transmission is finished so not to
-	 * have the TXE IRQ flood at the final stage of the transfer.
-	 */
-	if (irq_status & DW_SPI_INT_TXEI) {
-		dw_writer(dws);
-		if (!dws->tx_len)
-			dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
-	}
+	dw_spi_mask_intr(dws, DW_SPI_INT_MASK);
 
-	return IRQ_HANDLED;
+	return IRQ_WAKE_THREAD;
 }
 
 static irqreturn_t dw_spi_irq(int irq, void *dev_id)
@@ -946,8 +970,8 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	/* Basic HW init */
 	dw_spi_hw_init(dev, dws);
 
-	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
-			  ctlr);
+	ret = request_threaded_irq(dws->irq, dw_spi_irq, dw_spi_irq_thread_fn,
+				   IRQF_SHARED, dev_name(dev), ctlr);
 	if (ret < 0 && ret != -ENOTCONN) {
 		dev_err(dev, "can not request IRQ\n");
 		goto err_free_ctlr;
-- 
2.53.0

