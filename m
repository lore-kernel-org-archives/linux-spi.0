From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 3/6] spi: sh-msiof: Add slave mode support
Date: Wed, 22 Jun 2016 15:42:06 +0200
Message-ID: <1466602929-4191-4-git-send-email-geert+renesas@glider.be>
References: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
	Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466602929-4191-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Add slave mode support to the MSIOF driver.

For now this only supports the transmission of messages with a size
that is known in advance.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
[geert: Timeout handling cleanup, spi core integration, rewording]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c   | 52 ++++++++++++++++++++++++++++++++++----------
 include/linux/spi/sh_msiof.h |  6 +++++
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 0f83ad1d5a5858dd..afde3fe12bce844f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2009 Magnus Damm
  * Copyright (C) 2014 Glider bvba
+ * Copyright (C) 2014 Renesas Electronics Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -33,7 +34,6 @@
 
 #include <asm/unaligned.h>
 
-
 struct sh_msiof_chipdata {
 	u16 tx_fifo_size;
 	u16 rx_fifo_size;
@@ -334,7 +334,10 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
 	tmp |= !cs_high << MDR1_SYNCAC_SHIFT;
 	tmp |= lsb_first << MDR1_BITLSB_SHIFT;
 	tmp |= sh_msiof_spi_get_dtdl_and_syncdl(p);
-	sh_msiof_write(p, TMDR1, tmp | MDR1_TRMD | TMDR1_PCON);
+	if (p->master->flags & SPI_MASTER_IS_SLAVE)
+		sh_msiof_write(p, TMDR1, tmp | TMDR1_PCON);
+	else
+		sh_msiof_write(p, TMDR1, tmp | MDR1_TRMD | TMDR1_PCON);
 	if (p->master->flags & SPI_MASTER_MUST_TX) {
 		/* These bits are reserved if RX needs TX */
 		tmp &= ~0x0000ffff;
@@ -561,17 +564,19 @@ static int sh_msiof_prepare_message(struct spi_master *master,
 
 static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
 {
-	int ret;
+	bool slave = p->master->flags & SPI_MASTER_IS_SLAVE;
+	int ret = 0;
 
 	/* setup clock and rx/tx signals */
-	ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TSCKE);
+	if (!slave)
+		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TSCKE);
 	if (rx_buf && !ret)
 		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_RXE);
 	if (!ret)
 		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TXE);
 
 	/* start by setting frame bit */
-	if (!ret)
+	if (!ret && !slave)
 		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TFSE);
 
 	return ret;
@@ -579,15 +584,17 @@ static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
 
 static int sh_msiof_spi_stop(struct sh_msiof_spi_priv *p, void *rx_buf)
 {
-	int ret;
+	bool slave = p->master->flags & SPI_MASTER_IS_SLAVE;
+	int ret = 0;
 
 	/* shut down frame, rx/tx and clock signals */
-	ret = sh_msiof_modify_ctr_wait(p, CTR_TFSE, 0);
+	if (!slave)
+		ret = sh_msiof_modify_ctr_wait(p, CTR_TFSE, 0);
 	if (!ret)
 		ret = sh_msiof_modify_ctr_wait(p, CTR_TXE, 0);
 	if (rx_buf && !ret)
 		ret = sh_msiof_modify_ctr_wait(p, CTR_RXE, 0);
-	if (!ret)
+	if (!ret && !slave)
 		ret = sh_msiof_modify_ctr_wait(p, CTR_TSCKE, 0);
 
 	return ret;
@@ -633,7 +640,11 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	if (!wait_for_completion_timeout(&p->done, HZ)) {
+	if (p->master->flags & SPI_MASTER_IS_SLAVE)
+		ret = !wait_for_completion_interruptible(&p->done);
+	else
+		ret = wait_for_completion_timeout(&p->done, HZ);
+	if (!ret) {
 		dev_err(&p->pdev->dev, "PIO timeout\n");
 		ret = -ETIMEDOUT;
 		goto stop_reset;
@@ -743,7 +754,11 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	if (!wait_for_completion_timeout(&p->done, HZ)) {
+	if (p->master->flags & SPI_MASTER_IS_SLAVE)
+		ret = !wait_for_completion_interruptible(&p->done);
+	else
+		ret = wait_for_completion_timeout(&p->done, HZ);
+	if (!ret) {
 		dev_err(&p->pdev->dev, "DMA timeout\n");
 		ret = -ETIMEDOUT;
 		goto stop_reset;
@@ -840,7 +855,8 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	int ret;
 
 	/* setup clocks (clock already enabled in chipselect()) */
-	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
+	if (!(p->master->flags & SPI_MASTER_IS_SLAVE))
+		sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
 
 	while (master->dma_tx && len > 15) {
 		/*
@@ -986,14 +1002,24 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
 {
 	struct sh_msiof_spi_info *info;
 	struct device_node *np = dev->of_node;
+	struct device_node *slave;
 	u32 num_cs = 1;
 
 	info = devm_kzalloc(dev, sizeof(struct sh_msiof_spi_info), GFP_KERNEL);
 	if (!info)
 		return NULL;
 
+	slave = of_get_child_by_name(np, "slave");
+	if (slave) {
+		info->mode = MSIOF_SPI_SLAVE;
+		of_node_put(slave);
+	} else {
+		info->mode = MSIOF_SPI_MASTER;
+	}
+
 	/* Parse the MSIOF properties */
-	of_property_read_u32(np, "num-cs", &num_cs);
+	if (info->mode == MSIOF_SPI_MASTER)
+		of_property_read_u32(np, "num-cs", &num_cs);
 	of_property_read_u32(np, "renesas,tx-fifo-size",
 					&info->tx_fifo_override);
 	of_property_read_u32(np, "renesas,rx-fifo-size",
@@ -1228,6 +1254,8 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->mode_bits |= SPI_LSB_FIRST | SPI_3WIRE;
 	master->flags = chipdata->master_flags;
+	if (p->info->mode == MSIOF_SPI_SLAVE)
+		master->flags |= SPI_MASTER_IS_SLAVE;
 	master->bus_num = pdev->id;
 	master->dev.of_node = pdev->dev.of_node;
 	master->num_chipselect = p->info->num_chipselect;
diff --git a/include/linux/spi/sh_msiof.h b/include/linux/spi/sh_msiof.h
index b087a85f5f72a351..f74b581f242f8c43 100644
--- a/include/linux/spi/sh_msiof.h
+++ b/include/linux/spi/sh_msiof.h
@@ -1,10 +1,16 @@
 #ifndef __SPI_SH_MSIOF_H__
 #define __SPI_SH_MSIOF_H__
 
+enum {
+	MSIOF_SPI_MASTER,
+	MSIOF_SPI_SLAVE,
+};
+
 struct sh_msiof_spi_info {
 	int tx_fifo_override;
 	int rx_fifo_override;
 	u16 num_chipselect;
+	int mode;
 	unsigned int dma_tx_id;
 	unsigned int dma_rx_id;
 	u32 dtdl;
-- 
1.9.1
