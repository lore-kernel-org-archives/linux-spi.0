From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/10] spi: fsl-espi: introduce struct fsl_espi_cs
Date: Sun, 13 Nov 2016 14:38:05 +0100
Message-ID: <fcce5b10-4433-9ff2-2f17-bc0cf2f0f6b5@gmail.com>
References: <e1c18c6c-62e3-175e-b2a5-a4ee51d68b59@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e1c18c6c-62e3-175e-b2a5-a4ee51d68b59-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Very little from struct spi_mpc8xxx_cs is relevant for fsl-espi.
Therefore replace it with struct fsl_espi_cs.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 58314d7..5d84694 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -93,6 +93,10 @@
 
 #define AUTOSUSPEND_TIMEOUT 2000
 
+struct fsl_espi_cs {
+	u32 hw_mode;
+};
+
 static inline u32 fsl_espi_read_reg(struct mpc8xxx_spi *mspi, int offset)
 {
 	return ioread32be(mspi->reg_base + offset);
@@ -280,7 +284,7 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
 	int bits_per_word = t ? t->bits_per_word : spi->bits_per_word;
 	u32 pm, hz = t ? t->speed_hz : spi->max_speed_hz;
-	struct spi_mpc8xxx_cs *cs = spi->controller_state;
+	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
 	u32 hw_mode_old = cs->hw_mode;
 
 	/* mask out bits we are going to set */
@@ -437,7 +441,7 @@ static int fsl_espi_setup(struct spi_device *spi)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	u32 loop_mode;
-	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
+	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
 
 	if (!spi->max_speed_hz)
 		return -EINVAL;
@@ -483,7 +487,7 @@ static int fsl_espi_setup(struct spi_device *spi)
 
 static void fsl_espi_cleanup(struct spi_device *spi)
 {
-	struct spi_mpc8xxx_cs *cs = spi_get_ctldata(spi);
+	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
 
 	kfree(cs);
 	spi_set_ctldata(spi, NULL);
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
