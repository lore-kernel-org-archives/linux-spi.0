From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 06/09] spi: fsl-espi: make better use of the RX FIFO
Date: Thu, 27 Oct 2016 21:27:56 +0200
Message-ID: <082fee3f-4623-2cca-803b-b0fdf7cc8ab1@gmail.com>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5b98be38-17a2-79a2-14da-fb2bb6f8820f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

So far an interrupt is triggered whenever there's at least one byte
in the RX FIFO. This results in a unnecessarily high number of
interrupts.
Change this to generate an interrupt if
- RX FIFO is half full (except if all bytes to read fit into the
  RX FIFO anyway)
- end of transfer has been reached

This way the number of interrupts can be significantly reduced.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index ca14575..06fb185 100644
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
 
@@ -281,6 +282,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
+	u32 mask;
 	int ret;
 
 	mpc8xxx_spi->rx_len = t->len;
@@ -295,8 +297,11 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
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
