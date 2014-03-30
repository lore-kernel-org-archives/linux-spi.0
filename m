From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: fsl: Kill mpc8xxx_spi_cleanup and convert
 fsl_espi_setup to use devm_kzalloc
Date: Sun, 30 Mar 2014 16:43:23 +0800
Message-ID: <1396169003.21905.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In current code, master->cleanup and master->setup are not set in the same
function. This makes it hard to read and not good for code maintain.
One example is in fsl-spi.c, master->cleanup is overrided in mpc8xxx_spi_probe()
which leads to a memory leak.

This patch removes mpc8xxx_spi_cleanup() and converts fsl_espi_setup to use
devm_kzalloc so we don't need to take care of freeing memory.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 2 +-
 drivers/spi/spi-fsl-lib.c  | 6 ------
 drivers/spi/spi-fsl-lib.h  | 1 -
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 6fb2b75..2cbd596 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -457,7 +457,7 @@ static int fsl_espi_setup(struct spi_device *spi)
 		return -EINVAL;
 
 	if (!cs) {
-		cs = kzalloc(sizeof *cs, GFP_KERNEL);
+		cs = devm_kzalloc(&spi->dev, sizeof(*cs), GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
 		spi->controller_state = cs;
diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index e5d45fc..95212ea 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -99,11 +99,6 @@ int mpc8xxx_spi_transfer(struct spi_device *spi,
 	return 0;
 }
 
-void mpc8xxx_spi_cleanup(struct spi_device *spi)
-{
-	kfree(spi->controller_state);
-}
-
 const char *mpc8xxx_spi_strmode(unsigned int flags)
 {
 	if (flags & SPI_QE_CPU_MODE) {
@@ -134,7 +129,6 @@ int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 			| SPI_LSB_FIRST | SPI_LOOP;
 
 	master->transfer = mpc8xxx_spi_transfer;
-	master->cleanup = mpc8xxx_spi_cleanup;
 	master->dev.of_node = dev->of_node;
 
 	mpc8xxx_spi = spi_master_get_devdata(master);
diff --git a/drivers/spi/spi-fsl-lib.h b/drivers/spi/spi-fsl-lib.h
index 52db693..2fcbfd0 100644
--- a/drivers/spi/spi-fsl-lib.h
+++ b/drivers/spi/spi-fsl-lib.h
@@ -124,7 +124,6 @@ extern struct mpc8xxx_spi_probe_info *to_of_pinfo(
 extern int mpc8xxx_spi_bufs(struct mpc8xxx_spi *mspi,
 		struct spi_transfer *t, unsigned int len);
 extern int mpc8xxx_spi_transfer(struct spi_device *spi, struct spi_message *m);
-extern void mpc8xxx_spi_cleanup(struct spi_device *spi);
 extern const char *mpc8xxx_spi_strmode(unsigned int flags);
 extern int mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 		unsigned int irq);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
