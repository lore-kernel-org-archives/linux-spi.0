Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989112;
	b=BoWpeMZGyWmCjw6WLJ/U84TDEr2avh+SnlQdTQiO1PiUdAXPUViDsNzhQGuGRHmgQcEO
	 R+kHrOjrdKSp1ISOO19vOLXaxdKKKHLu1QckDkVBFda+7s0aO/FXz6GWLP97QlnOCpsZF
	 8ivSZ1Pno8Km7yDVtqQB29YYCdiWKYAo9eqBTEg4dsnGf2GddEX4tk2tY37ka2nLW1+In
	 TfuXLZaXfk+9EuCbaKAz/sZ1xroNnYx9MQqaZJD+sxlNMLNvQVjEMX4bM1JoY9LxnUTT3
	 6MT1b8giwsztxoXV4ck0W/KgAMerbnUgTRe26kwEsL8scXCm1V7W9k0NL0HgSsUm4/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989112;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=viGs+vwwaeijL9cDm80I/p7kjifrlWJt38UtKh73BZk=;
	b=qJxlGm9UryGFlCTg32pj7f/w+ZmooGjpVqkqvkLixlAH4x/xAs2wOGckJm7X4HGB6skc
	 AIS3786aqcQx1b1hRFxcHzYg0y49G83vKTQ/jVlbYBAeqfdRrP7S93eE7MKCZHZpDZD0l
	 yH82HmfWusVQUuxPIiTKqLLriRrUbAghmU1weN137g87ewbW+LRbHbRtnpufGdFt9LsUU
	 PTsyfuT4CGg8HozExDAiPHX2tYPLoVuAGaPcGVUpc0JdDbNE397jq19N4KDxFyVEOFt/K
	 deTCQOSIVFAfy/J5CKUiDoL9lMaLczVlOq+4B1ysmIMEfSiQcohofnrcn3mEi1svQdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ELKGUAEL;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31D606A32D
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 18:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E31D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=ELKGUAEL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=viGs+vwwaeijL9cDm80I/p7kjifrlWJt38UtKh73BZk=; b=ELKGUAELozpvtv/RXWTyPzn1zp
	/4JMLLL8ebK3BK4gAKPmXQRcnIwTzyqfk4P7C57iJFNYkNOEBwME9Xa5vyUjG3GIn8CpMS7TMfjZ1
	XrQ8wa7zEPXPY9K1VJoXm/WlprA+GDQtFq8JzHpOT8vc8RDfLGEAW7AoABZU0tYFz3YUoXStreDks
	+/7g8ZtRV8F2I+s/HPLYSn3d63ze8VFvYGrZFonAEV/wIK4LmdL1++5RTlCbyAS6WoO7EZ0AjCwXP
	6wPVqwEoBLNUEsbmsS1/erQQqz/LGTlTGsQoGJ652B9JJRzIQwjXz4NFgRHWDl3TsQzHMqfQh+c8S
	KwOpjx2Q==;
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
Subject: [PATCH 2/2] spi: rockchip: add an atomic transfer function
Date: Fri,  6 Nov 2026 19:18:23 +0100
Message-ID: <20261106181824.1361235-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106181824.1361235-1-heiko@sntech.de>
References: <20261106181824.1361235-1-heiko@sntech.de>
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

Additionally, setting ctrl->transfer to this function also let it work
just fine as the standard transfer function, so I'm hopefully not abusing
the SPI framework too much.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/spi/spi-rockchip.c | 88 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1a81fd94b439..96582c7d5c03 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
@@ -13,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/pm_runtime.h>
+#include <linux/reboot.h>
 #include <linux/scatterlist.h>
 
 #define DRIVER_NAME "rockchip-spi"
@@ -724,6 +726,74 @@ static bool rockchip_spi_can_dma(struct spi_controller *ctlr,
 	return xfer->len / bytes_per_word >= rs->fifo_len;
 }
 
+static int rockchip_spi_transfer_atomic(struct spi_device *spi, struct spi_message *msg)
+{
+	struct spi_controller *ctlr = spi->controller;
+	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
+	bool cs_en = (spi->mode & SPI_CS_HIGH) ? 1 : 0;
+	struct spi_transfer *xfer;
+	int ret = 0;
+
+	pm_runtime_get_sync(rs->dev);
+	rockchip_spi_set_cs(spi, cs_en);
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
+		wait_for_tx_idle(rs, false);
+
+		spi_enable_chip(rs, false);
+
+		if (xfer->cs_change && !list_is_last(&xfer->transfer_list, &msg->transfers)) {
+			rockchip_spi_set_cs(spi, !cs_en);
+			ndelay(10 * NSEC_PER_USEC);
+			rockchip_spi_set_cs(spi, cs_en);
+		}
+	}
+
+out_disable:
+	rockchip_spi_set_cs(spi, !cs_en);
+	ndelay(10 * NSEC_PER_USEC);
+	msg->status = ret;
+
+	if (msg->complete)
+		msg->complete(msg->context);
+
+	pm_runtime_put(rs->dev);
+
+	return ret;
+}
+
 static int rockchip_spi_setup(struct spi_device *spi)
 {
 	struct rockchip_spi *rs = spi_controller_get_devdata(spi->controller);
@@ -752,6 +822,14 @@ static int rockchip_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
+static int rockchip_spi_power_off(struct sys_off_data *data)
+{
+	struct rockchip_spi *rs = data->cb_data;
+
+	/* enable controller for possible calls from shutdown handlers */
+	return pm_runtime_get_sync(rs->dev);
+}
+
 static int rockchip_spi_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -832,6 +910,14 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	ret = devm_register_sys_off_handler(&pdev->dev,
+					    SYS_OFF_MODE_POWER_OFF_PREPARE,
+					    SYS_OFF_PRIO_DEFAULT,
+					    &rockchip_spi_power_off, rs);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register poweroff handler\n");
+
 	ctlr->auto_runtime_pm = true;
 	ctlr->bus_num = pdev->id;
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_LSB_FIRST;
@@ -860,6 +946,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ctlr->max_transfer_size = rockchip_spi_max_transfer_size;
 	ctlr->handle_err = rockchip_spi_handle_err;
 
+	ctlr->transfer_atomic = rockchip_spi_transfer_atomic;
+
 	ctlr->dma_tx = dma_request_chan(rs->dev, "tx");
 	if (IS_ERR(ctlr->dma_tx)) {
 		/* Check tx to see if we need to defer driver probing */
-- 
2.47.3

