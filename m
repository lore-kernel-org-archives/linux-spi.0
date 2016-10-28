From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fsl-espi: make better use of the RX FIFO" to the spi tree
Date: Fri, 28 Oct 2016 19:51:56 +0100
Message-ID: <E1c0CFw-000679-MR@finisterre>
References: <144b73b1-dff2-a5b6-9df1-837238f20008@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <144b73b1-dff2-a5b6-9df1-837238f20008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fsl-espi: make better use of the RX FIFO

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

>From e508cea45bc31de87b35180a9ba5ef9572ffde3f Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 27 Oct 2016 21:27:56 +0200
Subject: [PATCH] spi: fsl-espi: make better use of the RX FIFO

So far an interrupt is triggered whenever there's at least one byte
in the RX FIFO. This results in a unnecessarily high number of
interrupts.
Change this to generate an interrupt if
- RX FIFO is half full (except if all bytes to read fit into the
  RX FIFO anyway)
- end of transfer has been reached

This way the number of interrupts can be significantly reduced.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index a9593f9691ec..239f0362df61 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -55,9 +55,10 @@
 #define CSMODE_CG(x)		((x) << 3)
 
 #define FSL_ESPI_FIFO_SIZE	32
+#define FSL_ESPI_RXTHR		15
 
 /* Default mode/csmode for eSPI controller */
-#define SPMODE_INIT_VAL (SPMODE_TXTHR(4) | SPMODE_RXTHR(3))
+#define SPMODE_INIT_VAL (SPMODE_TXTHR(4) | SPMODE_RXTHR(FSL_ESPI_RXTHR))
 #define CSMODE_INIT_VAL (CSMODE_POL_1 | CSMODE_BEF(0) \
 		| CSMODE_AFT(0) | CSMODE_CG(1))
 
@@ -263,6 +264,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	u32 mask;
 	int ret;
 
 	mpc8xxx_spi->rx_len = t->len;
@@ -277,8 +279,11 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPCOM,
 		(SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN(t->len - 1)));
 
-	/* enable rx ints */
-	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, SPIM_RNE);
+	/* enable interrupts */
+	mask = SPIM_DON;
+	if (mpc8xxx_spi->rx_len > FSL_ESPI_FIFO_SIZE)
+		mask |= SPIM_RXT;
+	fsl_espi_write_reg(mpc8xxx_spi, ESPI_SPIM, mask);
 
 	/* Prevent filling the fifo from getting interrupted */
 	spin_lock_irq(&mpc8xxx_spi->lock);
-- 
2.10.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
