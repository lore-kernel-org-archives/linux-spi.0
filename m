From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2 5/7] spi: sh-msiof: Add slave mode support
Date: Mon, 12 Sep 2016 22:50:44 +0200
Message-ID: <1473713446-30366-6-git-send-email-geert+renesas@glider.be>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473713446-30366-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Add slave mode support to the MSIOF driver, in both PIO and DMA mode.

For now this only supports the transmission of messages with a size
that is known in advance.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
[geert: Timeout handling cleanup, spi core integration, cancellation,
	rewording]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
FIXME What's the proper way to cancel a completion blocked on
      wait_for_completion_interruptible() from the kernel?

  - When an in-kernel SPI slave handler calls signal_wake_up() on the
    blocked thread (the SPI worker thread), this does cancel the
    completion, and makes wait_for_completion_interruptible() return
    -ERESTARTSYS.
    However, all subsequent calls to wait_for_completion_interruptible()
    fail immediately with -ERESTARTSYS :-(
  - When using spidev as an SPI slave handler, stopping (CTRL-C) the
    userspace process also cancels the completion, but subsequent calls
    to wait_for_completion_interruptible() work fine.

Thanks!

v2:
  - Document "spi-slave" property in DT bindings,
  - Use spi_controller_is_slave() helper,
  - Check for "spi-slave" property instead of "slave" child node,
  - Replace SPI_MASTER_IS_SLAVE by SPI_CONTROLLER_IS_SLAVE,
  - Implement cancellation.
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt |  2 +
 drivers/spi/spi-sh-msiof.c                         | 67 ++++++++++++++++++----
 include/linux/spi/sh_msiof.h                       |  6 ++
 3 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index aa005c1d10d95756..7782c6abc7890bb0 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -31,6 +31,8 @@ Optional properties:
 			 specifiers, one for transmission, and one for
 			 reception.
 - dma-names            : Must contain a list of two DMA names, "tx" and "rx".
+- spi-slave            : Empty property indicating the SPI controller is used
+			 in slave mode.
 - renesas,dtdl         : delay sync signal (setup) in transmit mode.
 			 Must contain one of the following values:
 			 0   (no bit delay)
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 0f83ad1d5a5858dd..c585c9f3eb126738 100644
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
+	if (spi_controller_is_slave(p->master))
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
+	bool slave = spi_controller_is_slave(p->master);
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
@@ -579,20 +584,42 @@ static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
 
 static int sh_msiof_spi_stop(struct sh_msiof_spi_priv *p, void *rx_buf)
 {
-	int ret;
+	bool slave = spi_controller_is_slave(p->master);
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
 }
 
+static int sh_msiof_slave_abort(struct spi_master *master)
+{
+	struct sh_msiof_spi_priv *p = spi_master_get_devdata(master);
+	unsigned long flags;
+
+	spin_lock_irqsave(&p->done.wait.lock, flags);
+	if (!p->done.done) {
+		wait_queue_t *curr, *next;
+
+		list_for_each_entry_safe(curr, next, &p->done.wait.task_list,
+					 task_list) {
+			// FIXME Find a better way to signal and wake up
+			signal_wake_up(curr->private, 1);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&p->done.wait.lock, flags);
+	return 0;
+}
+
 static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 				  void (*tx_fifo)(struct sh_msiof_spi_priv *,
 						  const void *, int, int),
@@ -633,7 +660,11 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	if (!wait_for_completion_timeout(&p->done, HZ)) {
+	if (spi_controller_is_slave(p->master))
+		ret = !wait_for_completion_interruptible(&p->done);
+	else
+		ret = wait_for_completion_timeout(&p->done, HZ);
+	if (!ret) {
 		dev_err(&p->pdev->dev, "PIO timeout\n");
 		ret = -ETIMEDOUT;
 		goto stop_reset;
@@ -743,7 +774,11 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	if (!wait_for_completion_timeout(&p->done, HZ)) {
+	if (spi_controller_is_slave(p->master))
+		ret = !wait_for_completion_interruptible(&p->done);
+	else
+		ret = wait_for_completion_timeout(&p->done, HZ);
+	if (!ret) {
 		dev_err(&p->pdev->dev, "DMA timeout\n");
 		ret = -ETIMEDOUT;
 		goto stop_reset;
@@ -840,7 +875,8 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	int ret;
 
 	/* setup clocks (clock already enabled in chipselect()) */
-	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
+	if (!spi_controller_is_slave(p->master))
+		sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
 
 	while (master->dma_tx && len > 15) {
 		/*
@@ -992,8 +1028,12 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
 	if (!info)
 		return NULL;
 
+	info->mode = of_property_read_bool(np, "spi-slave") ? MSIOF_SPI_SLAVE
+							    : MSIOF_SPI_MASTER;
+
 	/* Parse the MSIOF properties */
-	of_property_read_u32(np, "num-cs", &num_cs);
+	if (info->mode == MSIOF_SPI_MASTER)
+		of_property_read_u32(np, "num-cs", &num_cs);
 	of_property_read_u32(np, "renesas,tx-fifo-size",
 					&info->tx_fifo_override);
 	of_property_read_u32(np, "renesas,rx-fifo-size",
@@ -1228,11 +1268,14 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 	master->mode_bits |= SPI_LSB_FIRST | SPI_3WIRE;
 	master->flags = chipdata->master_flags;
+	if (p->info->mode == MSIOF_SPI_SLAVE)
+		master->flags |= SPI_CONTROLLER_IS_SLAVE;
 	master->bus_num = pdev->id;
 	master->dev.of_node = pdev->dev.of_node;
 	master->num_chipselect = p->info->num_chipselect;
 	master->setup = sh_msiof_spi_setup;
 	master->prepare_message = sh_msiof_prepare_message;
+	master->slave_abort = sh_msiof_slave_abort;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
 	master->auto_runtime_pm = true;
 	master->transfer_one = sh_msiof_transfer_one;
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
