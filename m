Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788492;
	b=bgT7jlv/LUofeUk8+Pb/vl4cMwWQbayysDS//BBILF5WaaqiCKCCBO3MorSV3ITheMMx
	 pfxkS6zo9+h5Sm7sy9NptW4jRWp8HKiZiw8b5vzi/xmQk0PMFgOnp9oji5r5dPCDr5aTk
	 jW9P7xhV8JYxG6RYf+4gEse1SippSqnO/xsG92r6PRMUDlxn/snb+fUrm8UMgx5FtvFMN
	 JC/YFtlbeKewetATzZHRuBI+jk4Uk+iPNvfk3Q1aeBeT0FtQBdJfXU19ETmbxURf2z4np
	 THvKtBX6aov18rv+gjTdnFlqznON6X9Lez3AeCwREhcgGec442MlXIM+LPsvGJcpeIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788492;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bUjGbbi+Bqho3+8A4sV06cTTG0i8q5FzTjD92qrqscI=;
	b=B8s1LCIwUm/XvOw7B4YDqQHRtbaJRXTaFJNuNgCO5V5KNmQstfERmA92++OVXdaa4fSZ
	 rEu9lOFn/crbVQ+rNuoohPefhmYl+4fdoj+wvFw9Mqcxp62moIzaFkoPzXDxe4V+fL3Gk
	 PUEfqyzm7d2BrAiAZ/0h5UrPzYCngtSLxEuxVvGriToBjwaPNq6OOcCUIa39kRt8I0ojd
	 VaMzzUXDnKy0kkUeMP36QFp2pV9Q5F61G7B9zsztJVH/1MQaaipWOibFZrrGVvj8RDN4j
	 DyuCRvK1teh39uaeGMN6hxcInesyyMgNaW2R0kmxiSIdlPewFtW23+svJlA6WNDnQ6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=B2ndbX1j;
	arc=none smtp.remote-ip=115.124.28.218
Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96907606A327;
	Fri, 27 Nov 2026 14:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96907606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=B2ndbX1j
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1795788480; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bUjGbbi+Bqho3+8A4sV06cTTG0i8q5FzTjD92qrqscI=;
	b=B2ndbX1jRwRywQ9LQSU51mkREEfOTnKi0qUnNpCF8R+jb3qCUax+kctKq5Cy0U1fUfBuML34Gck0/egV5ZHFK0sEOcn15rH3DZtyjQJuaGN865GKfPZ8SlocrWIdUYlXWTHSBadP9MiPvg3wGlxkOlR2SA9PMG2FcTzQ+WfdMYelepsO/gFnbP/b1XXozfsJPgEa86u/pjm2CnH9Rdr/Z8oYaKpUAu8JQLNatH7Y0bRvbtxRPD8bpcc9jUG/83iKTqmYOv5X2IQ2LLQeCqWLKdeqmlcJrzYLk0nN2pv5kc6QMke2l7RJkHo45jFGSj7WXcMqqpxUJntncMjIXB2leQ==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00708847-0.0123632-0.980548;FP=11966960765120302294|9|2|10|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.kBVByRl_1795788479;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.kBVByRl_1795788479 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 22:08:00 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Mark Brown <broonie@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [RFC PATCH v4] spi: fsl-lpspi: add atomic transfer support
Date: Fri, 27 Nov 2026 22:02:28 +0800
Message-ID: <20261127140228.48851-1-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement transfer_atomic() for the i.MX LPSPI controller, following the
atomic transfer API added by Heiko Stuebner.  The callback uses PIO
polling with interrupts and DMA disabled, handles chip select through
spi_set_cs(), and runs the message synchronously without completions.
The controller is reset before the message so state left by a crashed
transfer does not leak into the atomic path.

The atomic path cannot call clk_get_rate(), because it takes the clock
prepare lock.  Cache the per-clock rate at probe and refresh it in the
normal transfer path; the atomic path only uses the cached value.  A
zero rate is rejected instead of programming a bogus divisor.

Program clock polarity and phase before the core asserts the GPIO chip
select, matching fsl_lpspi_prepare_message().  Terminate continuous mode
after the last data word, matching fsl_lpspi_write_tx_fifo(), and wait
for the frame-complete flag after each transfer.  The FIFO reset between
transfers leaves TCR_CONT set, so the next command can continue with
CONTC as in the normal transfer path.  Poll the receive FIFO empty flag
rather than the FIFO watermark so multi-word transfers do not time out,
use spi_bpw_to_bytes() for the length check so 17..24-bit transfers with
a 4-byte stride are accepted, and populate effective_speed_hz and
actual_length for the atomic path.

Only host mode registers the callback.  Poweroff and restart prepare
handlers runtime-resume the controller so the atomic path can be used
from the shutdown notifiers, matching the Rockchip implementation.

The driver is compile-tested on x86 with COMPILE_TEST and on arm64;
hardware validation on i.MX8QXP is pending.

This patch was developed with AI assistance.

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
Changes in v4:
- queue the TCR_CONTC-clear command after the last data word, matching
  fsl_lpspi_write_tx_fifo(), instead of before it; TCR and TDR share the
  same FIFO, so the old order ended a frame early;
- document that the inter-transfer FIFO reset leaves TCR_CONT set, so
  the next command can continue with CONTC as in the normal path.

 drivers/spi/spi-fsl-lpspi.c | 205 ++++++++++++++++++++++++++++++++++--
 1 file changed, 197 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index ed395f822dab1..bc76a564137b9 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -22,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/dma/imx-dma.h>
 #include <linux/pm_runtime.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
@@ -112,6 +114,7 @@ struct fsl_lpspi_data {
 	unsigned long base_phys;
 	struct clk *clk_ipg;
 	struct clk *clk_per;
+	u32 perclk_rate;
 	bool is_target;
 	bool is_only_cs1;
 	bool is_first_byte;
@@ -335,7 +338,8 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 	dev_dbg(fsl_lpspi->dev, "FCR=0x%08x\n", temp);
 }
 
-static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
+static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi,
+				 bool atomic)
 {
 	struct lpspi_config config = fsl_lpspi->config;
 	unsigned int perclk_rate, div;
@@ -343,7 +347,14 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 	u8 prescale;
 	int scldiv;
 
-	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
+	if (atomic) {
+		perclk_rate = fsl_lpspi->perclk_rate;
+	} else {
+		perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
+		fsl_lpspi->perclk_rate = perclk_rate;
+	}
+	if (!perclk_rate)
+		return -EINVAL;
 	prescale_max = fsl_lpspi->devtype_data->prescale_max ?: 7;
 
 	if (!config.speed_hz) {
@@ -427,13 +438,13 @@ static int fsl_lpspi_dma_configure(struct spi_controller *controller)
 	return 0;
 }
 
-static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
+static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi, bool atomic)
 {
 	u32 temp;
 	int ret;
 
 	if (!fsl_lpspi->is_target) {
-		ret = fsl_lpspi_set_bitrate(fsl_lpspi);
+		ret = fsl_lpspi_set_bitrate(fsl_lpspi, atomic);
 		if (ret)
 			return ret;
 	}
@@ -464,7 +475,7 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 
 static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 				     struct spi_device *spi,
-				     struct spi_transfer *t)
+				     struct spi_transfer *t, bool atomic)
 {
 	struct fsl_lpspi_data *fsl_lpspi =
 				spi_controller_get_devdata(spi->controller);
@@ -496,7 +507,7 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 
 	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
 
-	return fsl_lpspi_config(fsl_lpspi);
+	return fsl_lpspi_config(fsl_lpspi, atomic);
 }
 
 static int fsl_lpspi_prepare_message(struct spi_controller *controller,
@@ -515,7 +526,7 @@ static int fsl_lpspi_prepare_message(struct spi_controller *controller,
 
 	fsl_lpspi->is_first_byte = true;
 	fsl_lpspi->usedma = false;
-	ret = fsl_lpspi_setup_transfer(controller, spi, t);
+	ret = fsl_lpspi_setup_transfer(controller, spi, t, false);
 
 	fsl_lpspi->usedma = fsl_lpspi_can_dma(controller, spi, t);
 
@@ -774,6 +785,148 @@ static int fsl_lpspi_pio_transfer(struct fsl_lpspi_data *fsl_lpspi,
 	return ret;
 }
 
+static int fsl_lpspi_pio_xfer_atomic(struct fsl_lpspi_data *fsl_lpspi,
+				     struct spi_transfer *t)
+{
+	u32 sr, temp, timeout_us;
+	unsigned int bytes_per_word;
+	int ret;
+
+	/* One frame plus margin, at least 1ms. */
+	timeout_us = DIV_ROUND_UP(fsl_lpspi->config.bpw * USEC_PER_SEC,
+				  fsl_lpspi->config.speed_hz);
+	timeout_us = max(timeout_us * 2, 1000U);
+
+	bytes_per_word = spi_bpw_to_bytes(fsl_lpspi->config.bpw);
+	fsl_lpspi->tx_buf = t->tx_buf;
+	fsl_lpspi->rx_buf = t->rx_buf;
+	fsl_lpspi->remain = t->len;
+
+	while (fsl_lpspi->remain) {
+		ret = readl_poll_timeout_atomic(fsl_lpspi->base + IMX7ULP_SR,
+						sr, sr & SR_TDF, 0, timeout_us);
+		if (ret)
+			return ret;
+
+		/* Terminate continuous mode before the last frame. */
+		if (fsl_lpspi->remain == bytes_per_word) {
+			temp = readl(fsl_lpspi->base + IMX7ULP_TCR);
+			temp &= ~TCR_CONTC;
+			writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
+		}
+
+		fsl_lpspi->tx(fsl_lpspi);
+
+		ret = readl_poll_timeout_atomic(fsl_lpspi->base + IMX7ULP_RSR,
+						sr, !(sr & RSR_RXEMPTY), 0,
+						timeout_us);
+		if (ret)
+			return ret;
+		fsl_lpspi->rx(fsl_lpspi);
+	}
+
+	ret = readl_poll_timeout_atomic(fsl_lpspi->base + IMX7ULP_SR, sr,
+					sr & SR_FCF, 0, timeout_us);
+	if (ret)
+		return ret;
+
+	writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
+	return 0;
+}
+
+static int fsl_lpspi_transfer_atomic(struct spi_device *spi,
+				     struct spi_message *msg)
+{
+	struct spi_controller *controller = spi->controller;
+	struct fsl_lpspi_data *fsl_lpspi =
+				spi_controller_get_devdata(controller);
+	struct spi_transfer *t, *first, *next;
+	bool keep_cs = false;
+	bool first_xfer = true;
+	int ret = 0;
+
+	if (!pm_runtime_active(fsl_lpspi->dev))
+		return -ESHUTDOWN;
+
+	msg->actual_length = 0;
+	fsl_lpspi->usedma = false;
+	fsl_lpspi_reset(fsl_lpspi);
+	writel(0, fsl_lpspi->base + IMX7ULP_DER);
+
+	first = list_first_entry(&msg->transfers, struct spi_transfer,
+				 transfer_list);
+
+	/*
+	 * Match fsl_lpspi_prepare_message(): program CPOL/CPHA and the
+	 * first command before the core asserts GPIO chip select.
+	 */
+	fsl_lpspi->is_first_byte = true;
+	ret = fsl_lpspi_setup_transfer(controller, spi, first, true);
+	if (ret)
+		goto out;
+
+	fsl_lpspi_set_cmd(fsl_lpspi);
+	writel(0, fsl_lpspi->base + IMX7ULP_IER);
+	writel(CR_RRF | CR_RTF, fsl_lpspi->base + IMX7ULP_CR);
+	writel(SR_CLEAR_MASK, fsl_lpspi->base + IMX7ULP_SR);
+
+	spi_set_cs(spi, !first->cs_off, false);
+
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if (t->len) {
+			fsl_lpspi->is_first_byte = first_xfer;
+			ret = fsl_lpspi_setup_transfer(controller, spi, t, true);
+			if (ret)
+				break;
+
+			t->effective_speed_hz = fsl_lpspi->config.effective_speed_hz;
+
+			if (t->len %
+			    spi_bpw_to_bytes(fsl_lpspi->config.bpw)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			fsl_lpspi_set_cmd(fsl_lpspi);
+			fsl_lpspi->is_first_byte = false;
+
+			ret = fsl_lpspi_pio_xfer_atomic(fsl_lpspi, t);
+			if (ret)
+				break;
+
+			msg->actual_length += t->len;
+			fsl_lpspi_reset(fsl_lpspi);
+			first_xfer = false;
+		}
+
+		spi_transfer_delay_exec(t);
+
+		if (t->cs_change) {
+			if (list_is_last(&t->transfer_list, &msg->transfers)) {
+				keep_cs = true;
+			} else {
+				if (!t->cs_off)
+					spi_set_cs(spi, false, false);
+				spi_transfer_cs_change_delay_exec(msg, t);
+				next = list_next_entry(t, transfer_list);
+				if (!next->cs_off)
+					spi_set_cs(spi, true, false);
+			}
+		} else if (!list_is_last(&t->transfer_list, &msg->transfers)) {
+			next = list_next_entry(t, transfer_list);
+			if (t->cs_off != next->cs_off)
+				spi_set_cs(spi, !next->cs_off, false);
+		}
+	}
+
+out:
+	if (ret || !keep_cs)
+		spi_set_cs(spi, false, false);
+	fsl_lpspi_reset(fsl_lpspi);
+	msg->status = ret;
+	return ret;
+}
+
 static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 				  struct spi_device *spi,
 				  struct spi_transfer *t)
@@ -784,7 +937,7 @@ static int fsl_lpspi_transfer_one(struct spi_controller *controller,
 
 	fsl_lpspi->usedma = fsl_lpspi_can_dma(controller, spi, t);
 
-	ret = fsl_lpspi_setup_transfer(controller, spi, t);
+	ret = fsl_lpspi_setup_transfer(controller, spi, t, false);
 	if (ret < 0)
 		return ret;
 
@@ -878,6 +1031,19 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
 	return 0;
 }
 
+static int fsl_lpspi_power_off(struct sys_off_data *data)
+{
+	struct fsl_lpspi_data *fsl_lpspi = data->cb_data;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(fsl_lpspi->dev);
+	if (ret)
+		dev_warn(fsl_lpspi->dev,
+			 "failed to resume controller for poweroff: %d\n", ret);
+
+	return 0;
+}
+
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
 	const struct fsl_lpspi_devtype_data *devtype_data;
@@ -958,6 +1124,9 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 		goto out_pm_get;
 	}
 
+	/* The atomic transfer path cannot call clk_get_rate(). */
+	fsl_lpspi->perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
+
 	temp = readl(fsl_lpspi->base + IMX7ULP_PARAM);
 	fsl_lpspi->txfifosize = 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
@@ -972,6 +1141,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	controller->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
 	controller->prepare_message = fsl_lpspi_prepare_message;
 	controller->transfer_one = fsl_lpspi_transfer_one;
+	if (!fsl_lpspi->is_target)
+		controller->transfer_atomic = fsl_lpspi_transfer_atomic;
 	controller->prepare_transfer_hardware = lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware = lpspi_unprepare_xfer_hardware;
 	controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
@@ -982,6 +1153,24 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	if (!fsl_lpspi->is_target)
 		controller->use_gpio_descriptors = true;
 
+	if (!fsl_lpspi->is_target) {
+		ret = devm_register_sys_off_handler(&pdev->dev,
+						    SYS_OFF_MODE_POWER_OFF_PREPARE,
+						    SYS_OFF_PRIO_DEFAULT,
+						    fsl_lpspi_power_off,
+						    fsl_lpspi);
+		if (ret)
+			goto out_pm_get;
+
+		ret = devm_register_sys_off_handler(&pdev->dev,
+						    SYS_OFF_MODE_RESTART_PREPARE,
+						    SYS_OFF_PRIO_DEFAULT,
+						    fsl_lpspi_power_off,
+						    fsl_lpspi);
+		if (ret)
+			goto out_pm_get;
+	}
+
 	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
 	if (ret == -EPROBE_DEFER)
 		goto out_pm_get;
base-commit: 63083539d2bf955ccf84042d4b044d1133752bed

-- 
2.47.3

