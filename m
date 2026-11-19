Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.11.138.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096707;
	b=yDEXJbiXTqrKIsELsSOorQmEs827/09SneZeu16EkJhQFWCqU05399vDhvRDO7U3TXt4
	 7mZi5hhMuyizE1WrTIlu1RY7VdjXDhB6yCAxUdKom6QSnKDX+T4KcKOSsQWMRONHbp8Q7
	 QnW7oR8icmI6FBgMIsy8CousEHd1mhvuzN1bngLetgwbe9xl54QUnSwwRMa7CcHsHR4Bt
	 K0f8beGrWy5fS6zpYNnH0ILZuJhcro2OQCDJV7qJqKyhweqqxPiVFMoZueoQZL0XLX42t
	 /wRXyrWb9uDMdMUgDnfLn95OocDI0LfoQOzYX3lRRCM+jXEKgCE4pKOxa5xDlcUUFIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096707;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=M476Q33nlRwB1R+3UL8yZ5jRuXymmTFCNXnivKPO8dA=;
	b=gUP2IqDHAZ2hNkxAzMApwmthRkzyXUXWVbRmQBhQ0NKKiKlrYiUk4uCcIY+J+1xc+VnY
	 gJrC9LSfNDUoI6am32yTBVz/S+R+w1ZTp1iNs9rV1wHSpRooIQJWd42RQ2Fuwak1VI4sx
	 +Gp/FnZqCr6aPc7Ciy6lKggHOKDw5D3Q0R2kgK9sfNGGG+iN/MfkFae+h6cmT58gGosMw
	 4O9mOuSbV1z/kupQ/huYTzN/PkFU96z/czrOK36Lb6FtjD4EkcbVDikwrLN1UZPEFua7f
	 8wCXtXABI7Qb7DGqVoibH9iuxuYgV2oYul+BhcIjUKEVQ1Y++3bmcq8fwj4rUzqTOvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sntech.de;
	spf=pass smtp.mailfrom=sntech.de;
	dkim=pass header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=WiFLSo2p;
	arc=none smtp.remote-ip=185.11.138.130
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5853606A32F
	for <linux-spi@vger.kernel.org>; Thu, 19 Nov 2026 13:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5853606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.a=rsa-sha256 header.s=gloria202408 header.b=WiFLSo2p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=M476Q33nlRwB1R+3UL8yZ5jRuXymmTFCNXnivKPO8dA=; b=WiFLSo2p6fRabiUBAS37jw0acJ
	xNEYRxbe7b2siovhSluaqNOqLGcS2IxPH6Mofc62LT942SFP4NkT4FlIWLibcaDazGcjgNYt8gtif
	PmLLOday3uXy3u//z92Ots+S+DfeZz7k0sF93J/n+cVRm12hcKGSrpoFMNo6Ozr3ZkjKIibNBqhuR
	Wy/lw8+eUmRx7pISfFPd4BnWO13Wcd1myzhNJH/dR5t69Bd+9nZy4Rdd35D8uEn8nkNMWVR8pz5q0
	nVWcfAay71lJLeXchQ4CMubPGAAiS2XIQLv78LMq1ZXjdIHnasPVB9hp6sJcxrfz7AnR41c1A9epn
	fnAPQfTw==;
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
Subject: [PATCH v4 6/6] spi: rockchip: Add an atomic transfer function
Date: Thu, 19 Nov 2026 14:58:08 +0100
Message-ID: <20261119135808.2377849-7-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119135808.2377849-1-heiko@sntech.de>
References: <20261119135808.2377849-1-heiko@sntech.de>
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
index cc6bd7d8f877..2cd2af3eb28f 100644
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
@@ -722,6 +737,74 @@ static bool rockchip_spi_can_dma(struct spi_controller *ctlr,
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
@@ -750,6 +833,19 @@ static int rockchip_spi_setup(struct spi_device *spi)
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
@@ -858,6 +954,31 @@ static int rockchip_spi_probe(struct platform_device *pdev)
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

