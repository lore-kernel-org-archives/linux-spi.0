From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 4/6] spi: sh-msiof: Add slave mode support
Date: Thu,  4 May 2017 19:45:49 +0200
Message-ID: <1493919951-32122-5-git-send-email-geert+renesas@glider.be>
References: <1493919951-32122-1-git-send-email-geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493919951-32122-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Add slave mode support to the MSIOF driver, in both PIO and DMA mode.

For now this only supports the transmission of messages with a size
that is known in advance.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
[geert: Timeout handling cleanup, spi core integration, cancellation,
	rewording]
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
v3:
  - Clear TIF_SIGPENDING when interrupted to fix cancellation,
  - Extract sh_msiof_wait_for_completion(),
  - Add #include <linux/sched/signal.h>,
  - Convert to use spi_alloc_slave(),

v2:
  - Document "spi-slave" property in DT bindings,
  - Use spi_controller_is_slave() helper,
  - Check for "spi-slave" property instead of "slave" child node,
  - Replace SPI_MASTER_IS_SLAVE by SPI_CONTROLLER_IS_SLAVE,
  - Implement cancellation.
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   2 +
 drivers/spi/spi-sh-msiof.c                         | 121 +++++++++++++++------
 include/linux/spi/sh_msiof.h                       |   6 +
 3 files changed, 96 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index dc975064fa273c36..64ee489571c42f88 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -38,6 +38,8 @@ Optional properties:
 			 specifiers, one for transmission, and one for
 			 reception.
 - dma-names            : Must contain a list of two DMA names, "tx" and "rx".
+- spi-slave            : Empty property indicating the SPI controller is used
+			 in slave mode.
 - renesas,dtdl         : delay sync signal (setup) in transmit mode.
 			 Must contain one of the following values:
 			 0   (no bit delay)
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 2ce15ca977828668..7c4e8c4f3a9bddfd 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -2,7 +2,8 @@
  * SuperH MSIOF SPI Master Interface
  *
  * Copyright (c) 2009 Magnus Damm
- * Copyright (C) 2014 Glider bvba
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright (C) 2014-2017 Glider bvba
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -26,6 +27,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/sched/signal.h>
 #include <linux/sh_dma.h>
 
 #include <linux/spi/sh_msiof.h>
@@ -33,7 +35,6 @@
 
 #include <asm/unaligned.h>
 
-
 struct sh_msiof_chipdata {
 	u16 tx_fifo_size;
 	u16 rx_fifo_size;
@@ -337,7 +338,10 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
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
@@ -564,17 +568,19 @@ static int sh_msiof_prepare_message(struct spi_master *master,
 
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
@@ -582,20 +588,61 @@ static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
 
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
+			signal_wake_up(curr->private, 1);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&p->done.wait.lock, flags);
+	return 0;
+}
+
+static int sh_msiof_wait_for_completion(struct sh_msiof_spi_priv *p)
+{
+	if (spi_controller_is_slave(p->master)) {
+		int ret = wait_for_completion_interruptible(&p->done);
+
+		if (ret) {
+			dev_dbg(&p->pdev->dev, "interrupted\n");
+			clear_thread_flag(TIF_SIGPENDING);
+			return ret;
+		}
+	} else {
+		if (!wait_for_completion_timeout(&p->done, HZ)) {
+			dev_err(&p->pdev->dev, "timeout\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
 static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 				  void (*tx_fifo)(struct sh_msiof_spi_priv *,
 						  const void *, int, int),
@@ -636,11 +683,9 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	if (!wait_for_completion_timeout(&p->done, HZ)) {
-		dev_err(&p->pdev->dev, "PIO timeout\n");
-		ret = -ETIMEDOUT;
+	ret = sh_msiof_wait_for_completion(p);
+	if (ret)
 		goto stop_reset;
-	}
 
 	/* read rx fifo */
 	if (rx_buf)
@@ -746,11 +791,9 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	}
 
 	/* wait for tx fifo to be emptied / rx fifo to be filled */
-	if (!wait_for_completion_timeout(&p->done, HZ)) {
-		dev_err(&p->pdev->dev, "DMA timeout\n");
-		ret = -ETIMEDOUT;
+	ret = sh_msiof_wait_for_completion(p);
+	if (ret)
 		goto stop_reset;
-	}
 
 	/* clear status bits */
 	sh_msiof_reset_str(p);
@@ -843,7 +886,8 @@ static int sh_msiof_transfer_one(struct spi_master *master,
 	int ret;
 
 	/* setup clocks (clock already enabled in chipselect()) */
-	sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
+	if (!spi_controller_is_slave(p->master))
+		sh_msiof_spi_set_clk_regs(p, clk_get_rate(p->clk), t->speed_hz);
 
 	while (master->dma_tx && len > 15) {
 		/*
@@ -998,8 +1042,12 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
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
@@ -1159,34 +1207,40 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	const struct sh_msiof_chipdata *chipdata;
 	const struct of_device_id *of_id;
+	struct sh_msiof_spi_info *info;
 	struct sh_msiof_spi_priv *p;
 	int i;
 	int ret;
 
-	master = spi_alloc_master(&pdev->dev, sizeof(struct sh_msiof_spi_priv));
-	if (master == NULL)
-		return -ENOMEM;
-
-	p = spi_master_get_devdata(master);
-
-	platform_set_drvdata(pdev, p);
-	p->master = master;
-
 	of_id = of_match_device(sh_msiof_match, &pdev->dev);
 	if (of_id) {
 		chipdata = of_id->data;
-		p->info = sh_msiof_spi_parse_dt(&pdev->dev);
+		info = sh_msiof_spi_parse_dt(&pdev->dev);
 	} else {
 		chipdata = (const void *)pdev->id_entry->driver_data;
-		p->info = dev_get_platdata(&pdev->dev);
+		info = dev_get_platdata(&pdev->dev);
 	}
 
-	if (!p->info) {
+	if (!info) {
 		dev_err(&pdev->dev, "failed to obtain device info\n");
-		ret = -ENXIO;
-		goto err1;
+		return -ENXIO;
 	}
 
+	if (info->mode == MSIOF_SPI_SLAVE)
+		master = spi_alloc_slave(&pdev->dev,
+					 sizeof(struct sh_msiof_spi_priv));
+	else
+		master = spi_alloc_master(&pdev->dev,
+					  sizeof(struct sh_msiof_spi_priv));
+	if (master == NULL)
+		return -ENOMEM;
+
+	p = spi_master_get_devdata(master);
+
+	platform_set_drvdata(pdev, p);
+	p->master = master;
+	p->info = info;
+
 	init_completion(&p->done);
 
 	p->clk = devm_clk_get(&pdev->dev, NULL);
@@ -1237,6 +1291,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
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
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
