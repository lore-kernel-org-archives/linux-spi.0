From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: align register access with other drivers" to the spi tree
Date: Wed, 14 Sep 2016 18:25:07 +0100
Message-ID: <E1bkDvn-00037C-0a@debutante>
References: <7d703c07-d2d9-e1e9-157c-030891bdc94c@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7d703c07-d2d9-e1e9-157c-030891bdc94c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: align register access with other drivers

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 46afd38b7de347fd329767957886901ee9912d7a Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 13 Sep 2016 23:16:02 +0200
Subject: [PATCH] spi: fsl-espi: align register access with other drivers

Change register access to the method used in other drivers too.
- use register names as in the chip spec for constants
- avoid hard to read statements like
  __be32 __iomem *espi_mode = &reg_base->mode
- get rid of old powerpc-specific functions like in_8

In addition annotate reg_base in struct mpc8xxx_spi as __iomem.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 135 ++++++++++++++++++++++++---------------------
 drivers/spi/spi-fsl-lib.h  |   2 +-
 2 files changed, 73 insertions(+), 64 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 032bf3af8388..328b04a36328 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -26,16 +26,15 @@
 #include "spi-fsl-lib.h"
 
 /* eSPI Controller registers */
-struct fsl_espi_reg {
-	__be32 mode;		/* 0x000 - eSPI mode register */
-	__be32 event;		/* 0x004 - eSPI event register */
-	__be32 mask;		/* 0x008 - eSPI mask register */
-	__be32 command;		/* 0x00c - eSPI command register */
-	__be32 transmit;	/* 0x010 - eSPI transmit FIFO access register*/
-	__be32 receive;		/* 0x014 - eSPI receive FIFO access register*/
-	u8 res[8];		/* 0x018 - 0x01c reserved */
-	__be32 csmode[4];	/* 0x020 - 0x02c eSPI cs mode register */
-};
+#define ESPI_SPMODE	0x00	/* eSPI mode register */
+#define ESPI_SPIE	0x04	/* eSPI event register */
+#define ESPI_SPIM	0x08	/* eSPI mask register */
+#define ESPI_SPCOM	0x0c	/* eSPI command register */
+#define ESPI_SPITF	0x10	/* eSPI transmit FIFO access register*/
+#define ESPI_SPIRF	0x14	/* eSPI receive FIFO access register*/
+#define ESPI_SPMODE0	0x20	/* eSPI cs0 mode register */
+
+#define ESPI_SPMODEx(x)	(ESPI_SPMODE0 + (x) * 4)
 
 /* eSPI Controller mode register definitions */
 #define SPMODE_ENABLE		(1 << 31)
@@ -77,6 +76,28 @@ struct fsl_espi_reg {
 
 #define AUTOSUSPEND_TIMEOUT 2000
 
+static inline u32 fsl_espi_read_reg(struct mpc8xxx_spi *mspi, int offset)
+{
+	return ioread32be(mspi->reg_base + offset);
+}
+
+static inline u8 fsl_espi_read_reg8(struct mpc8xxx_spi *mspi, int offset)
+{
+	return ioread8(mspi->reg_base + offset);
+}
+
+static inline void fsl_espi_write_reg(struct mpc8xxx_spi *mspi, int offset,
+				      u32 val)
+{
+	iowrite32be(val, mspi->reg_base + offset);
+}
+
+static inline void fsl_espi_write_reg8(struct mpc8xxx_spi *mspi, int offset,
+				       u8 val)
+{
+	iowrite8(val, mspi->reg_base + offset);
+}
+
 static void fsl_espi_copy_to_buf(struct spi_message *m,
 				 struct mpc8xxx_spi *mspi)
 {
@@ -133,9 +154,6 @@ static void fsl_espi_change_mode(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
 	struct spi_mpc8xxx_cs *cs = spi->controller_state;
-	struct fsl_espi_reg *reg_base = mspi->reg_base;
-	__be32 __iomem *mode = &reg_base->csmode[spi->chip_select];
-	__be32 __iomem *espi_mode = &reg_base->mode;
 	u32 tmp;
 	unsigned long flags;
 
@@ -143,10 +161,11 @@ static void fsl_espi_change_mode(struct spi_device *spi)
 	local_irq_save(flags);
 
 	/* Turn off SPI unit prior changing mode */
-	tmp = mpc8xxx_spi_read_reg(espi_mode);
-	mpc8xxx_spi_write_reg(espi_mode, tmp & ~SPMODE_ENABLE);
-	mpc8xxx_spi_write_reg(mode, cs->hw_mode);
-	mpc8xxx_spi_write_reg(espi_mode, tmp);
+	tmp = fsl_espi_read_reg(mspi, ESPI_SPMODE);
+	fsl_espi_write_reg(mspi, ESPI_SPMODE, tmp & ~SPMODE_ENABLE);
+	fsl_espi_write_reg(mspi, ESPI_SPMODEx(spi->chip_select),
+			      cs->hw_mode);
+	fsl_espi_write_reg(mspi, ESPI_SPMODE, tmp);
 
 	local_irq_restore(flags);
 }
@@ -228,7 +247,6 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	struct fsl_espi_reg *reg_base = mpc8xxx_spi->reg_base;
 	u32 word;
 	int ret;
 
@@ -241,15 +259,15 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	reinit_completion(&mpc8xxx_spi->done);
 
 	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
-	mpc8xxx_spi_write_reg(&reg_base->command,
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM,
 		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
 
 	/* enable rx ints */
-	mpc8xxx_spi_write_reg(&reg_base->mask, SPIM_NE);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, SPIM_NE);
 
 	/* transmit word */
 	word = mpc8xxx_spi->get_tx(mpc8xxx_spi);
-	mpc8xxx_spi_write_reg(&reg_base->transmit, word);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPITF, word);
 
 	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
 	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
@@ -259,7 +277,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 			mpc8xxx_spi->count);
 
 	/* disable rx ints */
-	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
 
 	return mpc8xxx_spi->count > 0 ? -EMSGSIZE : 0;
 }
@@ -329,7 +347,6 @@ out:
 static int fsl_espi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct fsl_espi_reg *reg_base;
 	u32 hw_mode;
 	u32 loop_mode;
 	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
@@ -345,13 +362,12 @@ static int fsl_espi_setup(struct spi_device *spi)
 	}
 
 	mpc8xxx_spi = spi_master_get_devdata(spi->master);
-	reg_base = mpc8xxx_spi->reg_base;
 
 	pm_runtime_get_sync(mpc8xxx_spi->dev);
 
 	hw_mode = cs->hw_mode; /* Save original settings */
-	cs->hw_mode = mpc8xxx_spi_read_reg(
-			&reg_base->csmode[spi->chip_select]);
+	cs->hw_mode = fsl_espi_read_reg(mpc8xxx_spi,
+					   ESPI_SPMODEx(spi->chip_select));
 	/* mask out bits we are going to set */
 	cs->hw_mode &= ~(CSMODE_CP_BEGIN_EDGECLK | CSMODE_CI_INACTIVEHIGH
 			 | CSMODE_REV);
@@ -364,11 +380,11 @@ static int fsl_espi_setup(struct spi_device *spi)
 		cs->hw_mode |= CSMODE_REV;
 
 	/* Handle the loop mode */
-	loop_mode = mpc8xxx_spi_read_reg(&reg_base->mode);
+	loop_mode = fsl_espi_read_reg(mpc8xxx_spi, ESPI_SPMODE);
 	loop_mode &= ~SPMODE_LOOP;
 	if (spi->mode & SPI_LOOP)
 		loop_mode |= SPMODE_LOOP;
-	mpc8xxx_spi_write_reg(&reg_base->mode, loop_mode);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, loop_mode);
 
 	fsl_espi_setup_transfer(spi, NULL);
 
@@ -388,8 +404,6 @@ static void fsl_espi_cleanup(struct spi_device *spi)
 
 static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 {
-	struct fsl_espi_reg *reg_base = mspi->reg_base;
-
 	/* We need handle RX first */
 	if (events & SPIE_NE) {
 		u32 rx_data, tmp;
@@ -401,7 +415,7 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 		if (SPIE_RXCNT(events) < min(4, mspi->len)) {
 			ret = spin_event_timeout(
 				!(SPIE_RXCNT(events =
-				mpc8xxx_spi_read_reg(&reg_base->event)) <
+				fsl_espi_read_reg(mspi, ESPI_SPIE)) <
 						min(4, mspi->len)),
 						10000, 0); /* 10 msec */
 			if (!ret)
@@ -410,7 +424,7 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 		}
 
 		if (mspi->len >= 4) {
-			rx_data = mpc8xxx_spi_read_reg(&reg_base->receive);
+			rx_data = fsl_espi_read_reg(mspi, ESPI_SPIRF);
 		} else if (mspi->len <= 0) {
 			dev_err(mspi->dev,
 				"unexpected RX(SPIE_NE) interrupt occurred,\n"
@@ -422,7 +436,8 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 			tmp = mspi->len;
 			rx_data = 0;
 			while (tmp--) {
-				rx_data_8 = in_8((u8 *)&reg_base->receive);
+				rx_data_8 = fsl_espi_read_reg8(mspi,
+							       ESPI_SPIRF);
 				rx_data |= (rx_data_8 << (tmp * 8));
 			}
 
@@ -439,8 +454,8 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 		int ret;
 
 		/* spin until TX is done */
-		ret = spin_event_timeout(((events = mpc8xxx_spi_read_reg(
-				&reg_base->event)) & SPIE_NF), 1000, 0);
+		ret = spin_event_timeout(((events = fsl_espi_read_reg(
+				mspi, ESPI_SPIE)) & SPIE_NF), 1000, 0);
 		if (!ret) {
 			dev_err(mspi->dev, "tired waiting for SPIE_NF\n");
 			complete(&mspi->done);
@@ -452,7 +467,7 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 	if (mspi->count) {
 		u32 word = mspi->get_tx(mspi);
 
-		mpc8xxx_spi_write_reg(&reg_base->transmit, word);
+		fsl_espi_write_reg(mspi, ESPI_SPITF, word);
 	} else {
 		complete(&mspi->done);
 	}
@@ -461,11 +476,10 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 {
 	struct mpc8xxx_spi *mspi = context_data;
-	struct fsl_espi_reg *reg_base = mspi->reg_base;
 	u32 events;
 
 	/* Get interrupt events(tx/rx) */
-	events = mpc8xxx_spi_read_reg(&reg_base->event);
+	events = fsl_espi_read_reg(mspi, ESPI_SPIE);
 	if (!events)
 		return IRQ_NONE;
 
@@ -474,7 +488,7 @@ static irqreturn_t fsl_espi_irq(s32 irq, void *context_data)
 	fsl_espi_cpu_irq(mspi, events);
 
 	/* Clear the events */
-	mpc8xxx_spi_write_reg(&reg_base->event, events);
+	fsl_espi_write_reg(mspi, ESPI_SPIE, events);
 
 	return IRQ_HANDLED;
 }
@@ -484,12 +498,11 @@ static int fsl_espi_runtime_suspend(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
-	struct fsl_espi_reg *reg_base = mpc8xxx_spi->reg_base;
 	u32 regval;
 
-	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
+	regval = fsl_espi_read_reg(mpc8xxx_spi, ESPI_SPMODE);
 	regval &= ~SPMODE_ENABLE;
-	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
 
 	return 0;
 }
@@ -498,12 +511,11 @@ static int fsl_espi_runtime_resume(struct device *dev)
 {
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(master);
-	struct fsl_espi_reg *reg_base = mpc8xxx_spi->reg_base;
 	u32 regval;
 
-	regval = mpc8xxx_spi_read_reg(&reg_base->mode);
+	regval = fsl_espi_read_reg(mpc8xxx_spi, ESPI_SPMODE);
 	regval |= SPMODE_ENABLE;
-	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
 
 	return 0;
 }
@@ -520,7 +532,6 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct spi_master *master;
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct fsl_espi_reg *reg_base;
 	struct device_node *nc;
 	const __be32 *prop;
 	u32 regval, csmode;
@@ -558,8 +569,6 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 		goto err_probe;
 	}
 
-	reg_base = mpc8xxx_spi->reg_base;
-
 	/* Register for SPI Interrupt */
 	ret = devm_request_irq(dev, mpc8xxx_spi->irq, fsl_espi_irq,
 			  0, "fsl_espi", mpc8xxx_spi);
@@ -572,10 +581,10 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	}
 
 	/* SPI controller initializations */
-	mpc8xxx_spi_write_reg(&reg_base->mode, 0);
-	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
-	mpc8xxx_spi_write_reg(&reg_base->command, 0);
-	mpc8xxx_spi_write_reg(&reg_base->event, 0xffffffff);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, 0);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM, 0);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIE, 0xffffffff);
 
 	/* Init eSPI CS mode register */
 	for_each_available_child_of_node(master->dev.of_node, nc) {
@@ -600,7 +609,7 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 			csmode &= ~(CSMODE_AFT(0xf));
 			csmode |= CSMODE_AFT(be32_to_cpup(prop));
 		}
-		mpc8xxx_spi_write_reg(&reg_base->csmode[i], csmode);
+		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(i), csmode);
 
 		dev_info(dev, "cs=%d, init_csmode=0x%x\n", i, csmode);
 	}
@@ -608,7 +617,7 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	/* Enable SPI interface */
 	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
 
-	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
 
 	pm_runtime_set_autosuspend_delay(dev, AUTOSUSPEND_TIMEOUT);
 	pm_runtime_use_autosuspend(dev);
@@ -620,7 +629,8 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	if (ret < 0)
 		goto err_pm;
 
-	dev_info(dev, "at 0x%p (irq = %d)\n", reg_base, mpc8xxx_spi->irq);
+	dev_info(dev, "at 0x%p (irq = %d)\n", mpc8xxx_spi->reg_base,
+		 mpc8xxx_spi->irq);
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
@@ -726,27 +736,26 @@ static int of_fsl_espi_resume(struct device *dev)
 	struct fsl_spi_platform_data *pdata = dev_get_platdata(dev);
 	struct spi_master *master = dev_get_drvdata(dev);
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	struct fsl_espi_reg *reg_base;
 	u32 regval;
 	int i, ret;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
-	reg_base = mpc8xxx_spi->reg_base;
 
 	/* SPI controller initializations */
-	mpc8xxx_spi_write_reg(&reg_base->mode, 0);
-	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
-	mpc8xxx_spi_write_reg(&reg_base->command, 0);
-	mpc8xxx_spi_write_reg(&reg_base->event, 0xffffffff);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, 0);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, 0);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM, 0);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIE, 0xffffffff);
 
 	/* Init eSPI CS mode register */
 	for (i = 0; i < pdata->max_chipselect; i++)
-		mpc8xxx_spi_write_reg(&reg_base->csmode[i], CSMODE_INIT_VAL);
+		fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODEx(i),
+				      CSMODE_INIT_VAL);
 
 	/* Enable SPI interface */
 	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
 
-	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPMODE, regval);
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 065b9db212cf..2925c8089fd9 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -23,7 +23,7 @@
 /* SPI/eSPI Controller driver's private data. */
 struct mpc8xxx_spi {
 	struct device *dev;
-	void *reg_base;
+	void __iomem *reg_base;
 
 	/* rx & tx bufs from the spi_transfer */
 	const void *tx;
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
