From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: improve and extend register bit definitions" to the spi tree
Date: Wed, 14 Sep 2016 18:25:03 +0100
Message-ID: <E1bkDvj-00036Q-Nc@debutante>
References: <e510529b-8db6-a878-84c3-90ad07d39fbf@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e510529b-8db6-a878-84c3-90ad07d39fbf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: improve and extend register bit definitions

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

>From 81abc2ecac838da89076fe9e0e5892ed83bf1ab2 Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 13 Sep 2016 23:16:06 +0200
Subject: [PATCH] spi: fsl-espi: improve and extend register bit definitions

Add definition of further register bits for use in upcoming
driver extensions and improve current bit definitions:
- use BIT macro
- use bit names as in the chip spec

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 52 +++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 328b04a36328..a7984aeede6b 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -37,18 +37,18 @@
 #define ESPI_SPMODEx(x)	(ESPI_SPMODE0 + (x) * 4)
 
 /* eSPI Controller mode register definitions */
-#define SPMODE_ENABLE		(1 << 31)
-#define SPMODE_LOOP		(1 << 30)
+#define SPMODE_ENABLE		BIT(31)
+#define SPMODE_LOOP		BIT(30)
 #define SPMODE_TXTHR(x)		((x) << 8)
 #define SPMODE_RXTHR(x)		((x) << 0)
 
 /* eSPI Controller CS mode register definitions */
-#define CSMODE_CI_INACTIVEHIGH	(1 << 31)
-#define CSMODE_CP_BEGIN_EDGECLK	(1 << 30)
-#define CSMODE_REV		(1 << 29)
-#define CSMODE_DIV16		(1 << 28)
+#define CSMODE_CI_INACTIVEHIGH	BIT(31)
+#define CSMODE_CP_BEGIN_EDGECLK	BIT(30)
+#define CSMODE_REV		BIT(29)
+#define CSMODE_DIV16		BIT(28)
 #define CSMODE_PM(x)		((x) << 24)
-#define CSMODE_POL_1		(1 << 20)
+#define CSMODE_POL_1		BIT(20)
 #define CSMODE_LEN(x)		((x) << 16)
 #define CSMODE_BEF(x)		((x) << 12)
 #define CSMODE_AFT(x)		((x) << 8)
@@ -60,18 +60,32 @@
 		| CSMODE_AFT(0) | CSMODE_CG(1))
 
 /* SPIE register values */
-#define	SPIE_NE		0x00000200	/* Not empty */
-#define	SPIE_NF		0x00000100	/* Not full */
-
-/* SPIM register values */
-#define	SPIM_NE		0x00000200	/* Not empty */
-#define	SPIM_NF		0x00000100	/* Not full */
 #define SPIE_RXCNT(reg)     ((reg >> 24) & 0x3F)
 #define SPIE_TXCNT(reg)     ((reg >> 16) & 0x3F)
+#define	SPIE_TXE		BIT(15)	/* TX FIFO empty */
+#define	SPIE_DON		BIT(14)	/* TX done */
+#define	SPIE_RXT		BIT(13)	/* RX FIFO threshold */
+#define	SPIE_RXF		BIT(12)	/* RX FIFO full */
+#define	SPIE_TXT		BIT(11)	/* TX FIFO threshold*/
+#define	SPIE_RNE		BIT(9)	/* RX FIFO not empty */
+#define	SPIE_TNF		BIT(8)	/* TX FIFO not full */
+
+/* SPIM register values */
+#define	SPIM_TXE		BIT(15)	/* TX FIFO empty */
+#define	SPIM_DON		BIT(14)	/* TX done */
+#define	SPIM_RXT		BIT(13)	/* RX FIFO threshold */
+#define	SPIM_RXF		BIT(12)	/* RX FIFO full */
+#define	SPIM_TXT		BIT(11)	/* TX FIFO threshold*/
+#define	SPIM_RNE		BIT(9)	/* RX FIFO not empty */
+#define	SPIM_TNF		BIT(8)	/* TX FIFO not full */
 
 /* SPCOM register values */
 #define SPCOM_CS(x)		((x) << 30)
+#define SPCOM_DO		BIT(28) /* Dual output */
+#define SPCOM_TO		BIT(27) /* TX only */
+#define SPCOM_RXSKIP(x)		((x) << 16)
 #define SPCOM_TRANLEN(x)	((x) << 0)
+
 #define	SPCOM_TRANLEN_MAX	0x10000	/* Max transaction length */
 
 #define AUTOSUSPEND_TIMEOUT 2000
@@ -263,7 +277,7 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
 
 	/* enable rx ints */
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, SPIM_NE);
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, SPIM_RNE);
 
 	/* transmit word */
 	word = mpc8xxx_spi->get_tx(mpc8xxx_spi);
@@ -405,7 +419,7 @@ static void fsl_espi_cleanup(struct spi_device *spi)
 static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 {
 	/* We need handle RX first */
-	if (events & SPIE_NE) {
+	if (events & SPIE_RNE) {
 		u32 rx_data, tmp;
 		u8 rx_data_8;
 		int rx_nr_bytes = 4;
@@ -427,7 +441,7 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 			rx_data = fsl_espi_read_reg(mspi, ESPI_SPIRF);
 		} else if (mspi->len <= 0) {
 			dev_err(mspi->dev,
-				"unexpected RX(SPIE_NE) interrupt occurred,\n"
+				"unexpected RX(SPIE_RNE) interrupt occurred,\n"
 				"(local rxlen %d bytes, reg rxlen %d bytes)\n",
 				min(4, mspi->len), SPIE_RXCNT(events));
 			rx_nr_bytes = 0;
@@ -450,14 +464,14 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 			mspi->get_rx(rx_data, mspi);
 	}
 
-	if (!(events & SPIE_NF)) {
+	if (!(events & SPIE_TNF)) {
 		int ret;
 
 		/* spin until TX is done */
 		ret = spin_event_timeout(((events = fsl_espi_read_reg(
-				mspi, ESPI_SPIE)) & SPIE_NF), 1000, 0);
+				mspi, ESPI_SPIE)) & SPIE_TNF), 1000, 0);
 		if (!ret) {
-			dev_err(mspi->dev, "tired waiting for SPIE_NF\n");
+			dev_err(mspi->dev, "tired waiting for SPIE_TNF\n");
 			complete(&mspi->done);
 			return;
 		}
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
