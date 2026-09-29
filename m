Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF43528439;
	Tue, 29 Sep 2026 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685502; cv=none; b=i19g9gcKiAoGNWFj7zja5fXdmTniH22C0JJOxUuzKxaL54yZkcuEl9LCz+smR3m8EiC5CnAVh//MZeLNn1YqhFq/OOEROnjFC+UcE5SKxgKhj0iPoFn9xaMEP7l8/fkFn7v5lAf8XBcbvorYBf5FoPQoqtwhtZhSRl3dl7VrxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685502; c=relaxed/simple;
	bh=IIRWm7X+L5whAybhd2Ti0m0bZtAz9JahezDgaMJxjl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJuQZfH4ulmrp4mGLgA+hxG+IdwpzN/c/Ur6Aqk6vdrFz5g6uAzuhLplq3rkY8SCcxqNxJNQbLR9YiPDuWEZBRBqjuUnAehwsAk8XHD75gTIYoE4uj93s9itU9EKqYXzZMd0/nKfI9oN03i5fnuXsufZzah5WL3AXNTZME07a8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca28aGvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca28aGvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E201F00893;
	Tue, 29 Sep 2026 12:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685500;
	bh=5r86svmXaUvZkvutPi56IOBmX8MkvlkgG4CpprlIsuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ca28aGvMzwfRUB2EvGlgPQhK1RFyt/G5oSnQjAbmfQrFPV0D7XJbbncFrvcqzg4sj
	 XDPifwSDsfApWjc9jGekUAxWymoJgWr0IeOlBtjH+8rIw2jSWZq6j0dGWq9cFVkq6z
	 RJT/bazBCmcsuo1ry85/j2hInLq/xd5OTF0PgDNUjHFKPHAXAgI4J2OKWD4hVADoqd
	 T0muYUBwS7K+bciuyOV2klc8FIqoxjmCQGhqC66M0Cxe5FB7uSvSm8rgKrYNIVtyT8
	 EqGFeL1FcnE5phH+Suojx40IkhLEBH54dANGmelO8iEcbWdeTAKyc5dTB49zpZyI2V
	 li17axB2eBGVQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] spi: dw: use threaded interrupt and optimize the threaded ISR
Date: Tue, 29 Sep 2026 20:18:17 +0800
Message-ID: <20260929121817.20896-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260929121817.20896-1-jszhang@kernel.org>
References: <20260929121817.20896-1-jszhang@kernel.org>
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
interrupt thread when non-native CS and host only.

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
 drivers/spi/spi-dw-core.c | 67 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index da7d4872e513..bd86cbe8fcfe 100644
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
@@ -210,6 +216,51 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
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
+		cond_resched();
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
 static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 {
 	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
@@ -245,7 +296,13 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 			dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
 	}
 
-	return IRQ_HANDLED;
+	if (spi_controller_is_target(dws->ctlr) || !dws->rx_len || !dws->tx_len ||
+		!spi_get_csgpiod(dws->ctlr->cur_msg->spi, 0)) {
+		return IRQ_HANDLED;
+	} else {
+		dw_spi_mask_intr(dws, 0xff);
+		return IRQ_WAKE_THREAD;
+	}
 }
 
 static irqreturn_t dw_spi_enh_handler(struct dw_spi *dws)
@@ -1305,8 +1362,8 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
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

