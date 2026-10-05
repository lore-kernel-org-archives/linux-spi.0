Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA14CB8DD;
	Mon,  5 Oct 2026 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214669; cv=none; b=GhkjQla9KkpoN371YORCv68u1xpKCYPwgHcGtbs62pEw1GdJGRaNxZTQGZuWfgEPSM9yrD02yPsffZh53ZPLlEKUYvMvLmmWhcolEmS6XAECGwiUuNEfo6f0D4C7jD2tsY8saaEcSBzRjJqz9vxckmwH9w9z3zrDys1xQhwWM68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214669; c=relaxed/simple;
	bh=tcujtAke6uyWDLBFD5X3SweiZyj79MIlBLmrKTqhkaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIQhjZ8KO7apQAvfBP+K4tkcIOM5nV+H9NUSiW3Moi3/YdxthUv2vqk0nlbHxmhjpgwAABW6u3uUgZ0yJEmz8dyJvNhc7dF4V9fhxS/gYGbkpS2tz+ydMSevclG9nlZGkoH6nI6mJmVJ9h+V/tVQJ6T0078Lvxs653+1zF5ABRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UisdzB2R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UisdzB2R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1DD1F00893;
	Mon,  5 Oct 2026 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214667;
	bh=IL2P4hsFJ0Ydq3jczaWxSU+Tke4Ds9QL4SVN875yCwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UisdzB2Rx7Qih+FLAVcGw3EH7EKH+7X/1FKs5BobIHKxNu3W+E0OO9cpe71TDHQAl
	 hoFEmWKldlon1m7+tXUXbpecNtYtStjvhq0LhhOP8oMyL7afuaZbOMQAB2b6fGhvmR
	 8FhAVmIHCMf6V49MIvbd62b4/aI2jm9XKlCuApcLr5yNVyi5tF7z6HfNZ5ZQ5AwM2x
	 t5nUXBrv4ZNNiafgZeOJ5Hgrv46dHwsx3ZJXKGFr0cYek8VYxCu+mHOa5BQmJa+wuD
	 ET6YQXfxAE2emERavVRMGL3HQ+h9622Mw1flVlOz6I8oIaxu5+3R/PqMzpBFImVFI+
	 6M+TUvM+/jlLg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Joseph Steel <recv.jo@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] spi: dw: use threaded interrupt and optimize the threaded ISR
Date: Mon,  5 Oct 2026 23:17:39 +0800
Message-ID: <20261005151739.25233-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261005151739.25233-1-jszhang@kernel.org>
References: <20261005151739.25233-1-jszhang@kernel.org>
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
 drivers/spi/spi-dw-core.c | 70 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 06f4b0ea954e..a73c051437b6 100644
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
@@ -210,9 +216,55 @@ int dw_spi_check_status(struct dw_spi *dws, bool raw)
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
+	bool finalize = false;
 
 	if (dw_spi_check_status(dws, false)) {
 		spi_finalize_current_transfer(dws->ctlr);
@@ -229,6 +281,7 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 	dw_reader(dws);
 	if (!dws->rx_len) {
 		dw_spi_mask_intr(dws, 0xff);
+		finalize = true;
 		spi_finalize_current_transfer(dws->ctlr);
 	} else if (dws->rx_len <= dw_readl(dws, DW_SPI_RXFTLR)) {
 		dw_writel(dws, DW_SPI_RXFTLR, dws->rx_len - 1);
@@ -245,7 +298,14 @@ static irqreturn_t dw_spi_transfer_handler(struct dw_spi *dws)
 			dw_spi_mask_intr(dws, DW_SPI_INT_TXEI);
 	}
 
-	return IRQ_HANDLED;
+	if (spi_controller_is_target(dws->ctlr) || finalize ||
+		!dws->rx_len || !dws->tx_len ||
+		!spi_get_csgpiod(dws->ctlr->cur_msg->spi, 0)) {
+		return IRQ_HANDLED;
+	}
+
+	dw_spi_mask_intr(dws, 0xff);
+	return IRQ_WAKE_THREAD;
 }
 
 static irqreturn_t dw_spi_enh_handler(struct dw_spi *dws)
@@ -1334,8 +1394,8 @@ int dw_spi_add_controller(struct device *dev, struct dw_spi *dws)
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

