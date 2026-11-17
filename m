Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794959454;
	b=HyPCUsgq2GRTBjX0SdxdDNqj05saUYu48G6UvvJp3ems7X0cvYUajwdZ5HA7M5h2hYl4
	 Q4LEIVxiR745U6HRbFPXWjHQH9zjtm8/PPVypFFJa1s2eTYd8jUmz/sq/03SiVJrq6kG0
	 ATQUeZefKXwjBLyamdNh24RFFdxJwyFuCRrty/jHXs7USJ2w4MBM2KZPAluNwotakepmM
	 vV1576LGm/nKwJOgzbAzMipD+w612Dd7Bq8ifz6Uu9EM9LjquspfmCcpR82vt+kUb+g0C
	 k71XahATbp3CdO7LYoMtM5YYgCEEicHaV4zHEifVqJ/M29XCeEbYSnuOV4lQs17xnmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794959454;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3B38yKhNhlA5OZ7ETKheHjpFgCHfCqpoLU45qrtyMjg=;
	b=MrBbh0sIPnVX2abTOeQCAC3wVLAzo/Tm83SIfM980LBYkAFaezTP1gAdSMbIekIPLsKb
	 CEeg6PYWhQdtOKYbSggv1wFpaYWHOwwz4hJhvApw5eOHrznZSY8IimALur+nFkpj3Q1mS
	 4MRRuaGslXfeiXBIskL3mVoyXl8FPFY2JFdIm3aj9pZzbHHpmxdnLbm5axV1ZtGUw6ld/
	 5ablpFMDUszFRsU6mFyoVgG3KzNTUpG73TSXUpRvEJiOqLGMQdAXACN8fhXHHDEkFObBE
	 7AkOexdGcfcDZrKgYnMY01zm+XV+WmSzS/TSXbphgh0ju1Ipsc2Polsz6KZ9MDapJlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=g++5zmQW;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB86606A32F
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 23:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB86606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=g++5zmQW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=3B38yKhNhlA5OZ7ETKheHjpFgCHfCqpoLU45qrtyMjg=; b=g++5zmQWWOpyueZrWB/iZYrimj
	GqyGxlISVRLzmwZ6Gt/dQaP5zLD4undWM8PFgWPKcwT+tBPLfaWc/CXrzbhCNEtV4IuLidYoQ/lEn
	DjIVBgawvuH9f47BhgCGdl6WDotSul5WtmSrt5Dn80DHZqpbIPyxLFh1+ipf1EUCqP9dzOpPGRC3c
	nfCvvr9lLtB5duDT1okjDi9eBP4qcfmZbhEmGi00GGpiuypik2PcdQB4Jr6lZTfK98PW3CP8UMXaf
	x2Ag3ODQAZ8lgUBWtr6D+farrvpKf1C8Pup4jVeILmY8TZjt7jc813jZCX6DCI0tMUxCG54JYfmMN
	AHGTLAyA==;
From: Heiko Stuebner <heiko@sntech.de>
To: broonie@kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@cherry.de,
	Lee Jones <lee@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 7/7] spi: rockchip: Add an atomic transfer function
Date: Wed, 18 Nov 2026 00:50:21 +0100
Message-ID: <20261117235021.2013719-8-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117235021.2013719-1-heiko@sntech.de>
References: <20261117235021.2013719-1-heiko@sntech.de>
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Rockchip SPI controllers are often used to handle SPI connected PMICs that
also handle system power-off events, like the RK806.

When the kernel signals the power-off, all the interrupts are already
disabled, so regular SPI with its mutexes and DMA transfers does not
work anymore.

Implement an atomic transfer function that does SPI transfers polling the
controller in a loop without any DMA or IRQ.

This can successfully handle the power-off command to RK806, but also
read back the 2 chip-id registers just fine before that, as a test.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi-rockchip.c | 121 +++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index ce1629e5a513..c28a4ef6b55f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -7,12 +7,14 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
+#include <linux/reboot.h>
 #include <linux/scatterlist.h>
 
 #define DRIVER_NAME "rockchip-spi"
@@ -218,6 +220,19 @@ static inline void wait_for_tx_idle(struct rockchip_spi *rs, bool target_mode)
 	dev_warn(rs->dev, "spi controller is in busy state!\n");
 }
 
+/* atomic transfers only in host-mode */
+static inline void wait_for_tx_idle_atomic(struct rockchip_spi *rs)
+{
+	u32 sr;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout_atomic(rs->regs + ROCKCHIP_SPI_SR, sr,
+						!(sr & SR_BUSY),
+						10, 5 * USEC_PER_MSEC);
+	if (ret)
+		dev_warn(rs->dev, "spi controller still in busy state!\n");
+}
+
 static u32 get_fifo_len(struct rockchip_spi *rs)
 {
 	u32 ver;
@@ -724,6 +739,74 @@ static bool rockchip_spi_can_dma(struct spi_controller *ctlr,
 	return xfer->len / bytes_per_word >= rs->fifo_len;
 }
 
+static int rockchip_spi_transfer_atomic(struct spi_device *spi, struct spi_message *msg)
+{
+	struct spi_controller *ctlr = spi->controller;
+	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
+	struct spi_transfer *xfer;
+	int ret = 0;
+
+	if (!pm_runtime_active(rs->dev)) {
+		dev_err(rs->dev, "Failed to do atomic SPI transfer due to runtime suspend\n");
+		return -EIO;
+	}
+
+	spi_set_cs(spi, true, false);
+
+	/* make sure all interrupts are masked and status cleared */
+	writel_relaxed(0, rs->regs + ROCKCHIP_SPI_IMR);
+	writel_relaxed(0xffffffff, rs->regs + ROCKCHIP_SPI_ICR);
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		WARN_ON(readl_relaxed(rs->regs + ROCKCHIP_SPI_SSIENR) &&
+			(readl_relaxed(rs->regs + ROCKCHIP_SPI_SR) & SR_BUSY));
+
+		rs->n_bytes = xfer->bits_per_word <= 8 ? 1 : 2;
+
+		ret = rockchip_spi_config(rs, spi, xfer, false, false);
+		if (ret < 0)
+			goto out_disable;
+
+		writel_relaxed(0, rs->regs + ROCKCHIP_SPI_RXFTLR);
+
+		rs->tx = xfer->tx_buf;
+		rs->rx = xfer->rx_buf;
+		rs->tx_left = rs->tx ? xfer->len / rs->n_bytes : 0;
+		rs->rx_left = xfer->len / rs->n_bytes;
+
+		spi_enable_chip(rs, true);
+
+		while (rs->tx_left || rs->rx_left) {
+			u32 status = readl_relaxed(rs->regs + ROCKCHIP_SPI_SR);
+
+			if (rs->tx_left && !(status & SR_TF_FULL))
+				rockchip_spi_pio_writer(rs);
+
+			if (rs->rx_left && !(status & SR_RF_EMPTY))
+				rockchip_spi_pio_reader(rs);
+		}
+
+		wait_for_tx_idle_atomic(rs);
+
+		spi_enable_chip(rs, false);
+
+		if (xfer->cs_change && !list_is_last(&xfer->transfer_list, &msg->transfers)) {
+			spi_set_cs(spi, false, false);
+			spi_transfer_cs_change_delay_exec(msg, xfer);
+			spi_set_cs(spi, true, false);
+		}
+	}
+
+out_disable:
+	spi_set_cs(spi, false, false);
+	msg->status = ret;
+
+	if (msg->complete)
+		msg->complete(msg->context);
+
+	return ret;
+}
+
 static int rockchip_spi_setup(struct spi_device *spi)
 {
 	struct rockchip_spi *rs = spi_controller_get_devdata(spi->controller);
@@ -752,6 +835,19 @@ static int rockchip_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static int rockchip_spi_power_off(struct sys_off_data *data)
+{
+	struct rockchip_spi *rs = data->cb_data;
+	int ret;
+
+	/* enable controller for possible calls from shutdown handlers */
+	ret = pm_runtime_resume_and_get(rs->dev);
+	if (ret)
+		dev_warn(rs->dev, "spi controller failed to runtime resume: %d\n", ret);
+
+	return 0;
+}
+
 static int rockchip_spi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -860,6 +956,31 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ctlr->max_transfer_size = rockchip_spi_max_transfer_size;
 	ctlr->handle_err = rockchip_spi_handle_err;
 
+	/* Only register atomic transfer in host-mode */
+	if (!target_mode) {
+		ctlr->transfer_atomic = rockchip_spi_transfer_atomic;
+
+		ret = devm_register_sys_off_handler(&pdev->dev,
+						    SYS_OFF_MODE_POWER_OFF_PREPARE,
+						    SYS_OFF_PRIO_DEFAULT,
+						    &rockchip_spi_power_off, rs);
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret,
+				     "failed to register poweroff handler\n");
+			goto err_disable_pm_runtime;
+		}
+
+		ret = devm_register_sys_off_handler(&pdev->dev,
+						    SYS_OFF_MODE_RESTART_PREPARE,
+						    SYS_OFF_PRIO_DEFAULT,
+						    &rockchip_spi_power_off, rs);
+		if (ret) {
+			dev_err_probe(&pdev->dev, ret,
+				     "failed to register restart handler\n");
+			goto err_disable_pm_runtime;
+		}
+	}
+
 	ctlr->dma_tx = dma_request_chan(rs->dev, "tx");
 	if (IS_ERR(ctlr->dma_tx)) {
 		/* Check tx to see if we need to defer driver probing */
-- 
2.53.0

