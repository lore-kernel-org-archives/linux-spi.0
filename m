Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603356B843;
	Wed,  9 Sep 2026 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965808; cv=none; b=VzmtobWbJ/b85lUSTOumq7pX8W8q1fHab5JlqviP9R+Qd6L7GSLWip/xsgYOVcSd/GVNvsRWxhEDpRH0uU8YIxKPO3sYepAH01IE8w5RYRvtK8PYRNftPCA0v2B8Ii0dDPm9Ghdqzxic1Km1vD7WF7WxeGAAVI9VOlGHgPPJWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965808; c=relaxed/simple;
	bh=EfdVcm7oOBV5+uMpuaGCOSLJBIUFRXHNfXCqOq2JwP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYuGgbF7SIsyfn9d7qUx3u4SbAsW0t/V0674OtGRgFICY6LIswQCGJqLKze15ymDG+FEPzNRic1tyKD5/owyTuSE8JCJatrXDSynou7PIxCUB62+88j3G3Gjn+qfkUlpswdqrzFHNU+K0vJ/d1uunMGMHofCaOpZ9VTVYoYW/64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeMe76B8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeMe76B8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150B31F00A3A;
	Wed,  9 Sep 2026 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965806;
	bh=SEv5DPhtIQKp4tr7foAtnrNAn/IGR+fxuJIVNvbZUS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jeMe76B8xT0qA1zlOId1jnCQHzNWBmlrQJxAy9myoJ5lAizSTeQLrXGkgouLb5O43
	 UAmRrigzlkyCi3KjTDOmazxPxTSjhjXZbFYJn+EzmkTK1hWi7aose8qNMud7inypmX
	 sPfa5E+D3ppSCAW5xD+zF0xRImK9xO2SBM/iQhO0wold+cBstaZRuzI/tIWVPY52eO
	 yCBybYzV176YuJyxS1D98pknRa1JuNk8pdhCRq5iCmRDx71eA4Lq0DaaaWagUJXNPP
	 vFdi7M8ljYqA0EkbmGvCxzwlFY1v2Dd0i90OuqwMR6IszjK8F29HT6ZldmuAu8RzF9
	 uoOwl1PzlbhyA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] spi: dw: use threaded interrupt and optimize the threaded ISR
Date: Wed,  9 Sep 2026 22:36:52 +0800
Message-ID: <20260909143652.9234-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260909143652.9234-1-jszhang@kernel.org>
References: <20260909143652.9234-1-jszhang@kernel.org>
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
interrupt thread for host mode and non enhanced spi for two reasons:

"while the performance improvement will apply for both target mode
has no control over the clocking of data by the host so is much more
vulnerable to dropping data in a threaded interrupt if the system is
loaded.  In host mode this isn't an issue since we'll simply stop
clocking data while waiting for the scheduler to get round to the
interrupt thread."

In theory, we could do this for enhanced spi too, but I don't have the
HW to test, so I leave enhanced spi interrupt routine as is, anyone
has the HW can implement similar optimization in the future.

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
 drivers/spi/spi-dw-core.c | 75 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index da7d4872e513..c1f24f263488 100644
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
@@ -210,6 +216,62 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
 }
 EXPORT_SYMBOL_NS_GPL(dw_spi_check_status, "SPI_DW_CORE");
 
+static irqreturn_t dw_spi_irq_thread_fn(int irq, void *dev_id)
+{
+	struct spi_controller *ctlr = dev_id;
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	u32 rx, tx, imask, mask = 0;
+	bool finalize = false;
+
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
+			mask |= 0xff;
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
+		spi_finalize_current_transfer(dws->ctlr);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dw_spi_host_handler(struct dw_spi *dws)
+{
+	if (dw_spi_check_status(dws, false)) {
+		spi_finalize_current_transfer(dws->ctlr);
+		return IRQ_HANDLED;
+	}
+
+	dw_spi_mask_intr(dws, 0xff);
+
+	return IRQ_WAKE_THREAD;
+}
+
 static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 {
 	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
@@ -415,7 +477,10 @@ static void dw_spi_irq_setup(struct dw_spi *dws)
 	dw_writel(dws, DW_SPI_TXFTLR, level);
 	dw_writel(dws, DW_SPI_RXFTLR, level - 1);
 
-	dws->transfer_handler = dw_spi_transfer_handler;
+	if (spi_controller_is_target(dws->ctlr))
+		dws->transfer_handler = dw_spi_transfer_handler;
+	else
+		dws->transfer_handler = dw_spi_host_handler;
 
 	imask = DW_SPI_INT_TXEI | DW_SPI_INT_TXOI |
 		DW_SPI_INT_RXUI | DW_SPI_INT_RXOI | DW_SPI_INT_RXFI;
@@ -1305,8 +1370,8 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
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

