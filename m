Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4F30BB8A;
	Mon, 15 Jun 2026 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781499604; cv=none; b=EgNpdgxzu3kAQxOO95FAJmA0DyK887vbXCC43hu2goWXmJnV7Iqa8cHGMr9bO6MZ7qdzYnOc9moGehSV7XiN3d0w2YPzMRfKwYiyOq8xl7tHhCYx/YluEz7HSgcNPW2kpF1MB2N3Vu346ax78rBa9QbAg1RfyNWAQTNyIsZep9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781499604; c=relaxed/simple;
	bh=heF1/4lv945ptuAY6snoCIuipSymQLUHwb7y9ARQLRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql1KpxC7DzuO7kjZXZpC7PmbTOrRAT4cIibNLILv8xuyT17N1hsupYdleBumI8z7UtJMeqS8eUjkWlZrAFB9Kkthi/S/4J0Nx7EJnHtGVrf3zQwji2cSSspxeVJnMwuCsBlKik8lPYnXfgHbOrLbYW6fV2BMKItT7u/K/ScWD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeQHR1JF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeQHR1JF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32C81F00A3A;
	Mon, 15 Jun 2026 05:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781499602;
	bh=qa8XjZCp8LSzRJ+P7Jo0yefXRaA7qTMyVvzCFbAxRA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BeQHR1JFZW9cruzx6VxYn9B+GD1FwvMnrx5q1GfUOCiJwP/j+iLQ4S/hArH+a5jhm
	 K8jR8F21a/CL0HVbukFrLWPq9nVnBVhdbqzQmbE/dD6BieFg8QArs7kJoL8txnEXDh
	 5LUPhd1SKZkv4gOhi8nqeEoAD20/bdEgLL7euofpHHurZD+31A3rLTBOTgnmJ4u+lL
	 AdZGWOx8cHT7KK5Ez4/SY6sDpC/jlmAxJI8A0epVB8v9f8rsgiGNVk/ZbQEtNQyG6A
	 0qyMXj2h2xLlufpFXC1+V8aVKFkUIG0X082BB1HZj4z7ERwz0Q+LVbztRoGwtJmzLA
	 Lp3PRHvVRtI0g==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] spi: dw: use threaded interrupt and optimize the threaded ISR
Date: Mon, 15 Jun 2026 12:40:39 +0800
Message-ID: <20260615044039.9750-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615044039.9750-1-jszhang@kernel.org>
References: <20260615044039.9750-1-jszhang@kernel.org>
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
each 32KB spi spidev_test transfer triggers 33118 interrupts

spidev_test reports ~22090kbps
and rtla reports:
                                     Timer Latency
  0 00:00:37   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
  0 #9958      |        1         0        67    103394 |        6         4      2198    105031
  1 #36902     |        1         0         1        18 |        5         4         5        29

After the patch:
each 32KB spi spidev_test transfer only triggers 3 interrupts

spidev_test reports ~23520kbps
and now rtla reports:
                                    Timer Latency
  0 00:00:58   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max
  0 #58362     |        1         0         0        29 |        6         3         4        56
  1 #58363     |        1         0         1        23 |        6         4         5        68

In summary:
before the patch	after the patch
33118 interrutps	3 interrupts	 	reduced by 11038 times!
103394 us max latency	29 us max latency	reduced by 3564 times!
22090 kbps		23520 kbps		improved by 6.5%	

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-dw-core.c | 100 +++++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index feac17655847..cc4cc058ee72 100644
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
@@ -210,42 +216,59 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
 }
 EXPORT_SYMBOL_NS_GPL(dw_spi_check_status, "SPI_DW_CORE");
 
-static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
+static irqreturn_t dw_spi_irq_thread_fn(int irq, void *dev_id)
 {
-	u16 irq_status = dw_readl(dws, DW_SPI_ISR);
+	struct spi_controller *ctlr = dev_id;
+	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
+	u16 irq_status = dw_readl(dws, DW_SPI_RISR);
+	u32 rx, tx, imask, mask = 0;
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
+			mask = DW_SPI_INT_MASK;
+			spi_finalize_current_transfer(dws->ctlr);
+		} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
+			dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
+		}
+
+		/*
+		 * Send data out if Tx FIFO Empty IRQ is received. The IRQ will be
+		 * disabled after the data transmission is finished so not to
+		 * have the TXE IRQ flood at the final stage of the transfer.
+		 */
+		if (irq_status & DW_SPI_INT_TXEI) {
+			tx = dw_writer(dws);
+			if (!dws->tx_len)
+				mask = DW_SPI_INT_TXEI;
+		}
+	} while (rx != 0 || tx != 0);
+
+	imask = DW_SPI_INT_TXEI | DW_SPI_INT_TXOI |
+		DW_SPI_INT_RXUI | DW_SPI_INT_RXOI | DW_SPI_INT_RXFI;
+	imask &= ~mask;
+	dw_spi_umask_intr(dws, imask);
 
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
+{
 	if (dw_spi_check_status(dws, false)) {
 		spi_finalize_current_transfer(dws->ctlr);
 		return IRQ_HANDLED;
 	}
 
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
-		spi_finalize_current_transfer(dws->ctlr);
-	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
-		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
-	}
-
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
@@ -944,13 +967,6 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	/* Basic HW init */
 	dw_spi_hw_init(dev, dws);
 
-	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dev_name(dev),
-			  ctlr);
-	if (ret < 0 && ret != -ENOTCONN) {
-		dev_err(dev, "can not request IRQ\n");
-		goto err_free_ctlr;
-	}
-
 	dw_spi_init_mem_ops(dws);
 
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
@@ -990,7 +1006,7 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	if (dws->dma_ops && dws->dma_ops->dma_init) {
 		ret = dws->dma_ops->dma_init(dev, dws);
 		if (ret == -EPROBE_DEFER) {
-			goto err_free_irq;
+			goto err_free_ctlr;
 		} else if (ret) {
 			dev_warn(dev, "DMA init failed\n");
 		} else {
@@ -999,6 +1015,13 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 		}
 	}
 
+	ret = request_threaded_irq(dws->irq, dw_spi_irq, dw_spi_irq_thread_fn,
+				   IRQF_SHARED, dev_name(dev), ctlr);
+	if (ret < 0 && ret != -ENOTCONN) {
+		dev_err(dev, "can not request IRQ\n");
+		goto err_free_ctlr;
+	}
+
 	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err_probe(dev, ret, "problem registering spi controller\n");
@@ -1012,7 +1035,6 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 	dw_spi_enable_chip(dws, 0);
-err_free_irq:
 	free_irq(dws->irq, ctlr);
 err_free_ctlr:
 	spi_controller_put(ctlr);
-- 
2.53.0

