From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/10] spi: fsl-espi: migrate relevant parts of
 mpc8xxx_spi_probe and of_mpc8xxx_spi_probe
Date: Sun, 13 Nov 2016 14:37:41 +0100
Message-ID: <a4319a57-c3fa-7f8b-3292-9e5dee3dd3d6@gmail.com>
References: <b5d17688-7905-7417-d8f3-010bbe199b27@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b5d17688-7905-7417-d8f3-010bbe199b27-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Very little of the library functions mpc8xxx_spi_probe and
of_mpc8xxx_spi_probe is relevant for fsl-espi.

Therefore migrate the relevant parts to fsl-espi (considering
that get_brgfreq() always returns -1 on systems with ESPI)
and remove use of these functions.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index e378622..58314d7 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -587,9 +587,9 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 
 	dev_set_drvdata(dev, master);
 
-	mpc8xxx_spi_probe(dev, mem, irq);
-
-	master->mode_bits |= SPI_RX_DUAL;
+	master->mode_bits = SPI_RX_DUAL | SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
+			    SPI_LSB_FIRST | SPI_LOOP;
+	master->dev.of_node = dev->of_node;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16);
 	master->setup = fsl_espi_setup;
 	master->cleanup = fsl_espi_cleanup;
@@ -601,6 +601,16 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	mpc8xxx_spi = spi_master_get_devdata(master);
 	spin_lock_init(&mpc8xxx_spi->lock);
 
+	mpc8xxx_spi->dev = dev;
+	mpc8xxx_spi->spibrg = fsl_get_sys_freq();
+	if (mpc8xxx_spi->spibrg == -1) {
+		dev_err(dev, "Can't get sys frequency!\n");
+		ret = -EINVAL;
+		goto err_probe;
+	}
+
+	init_completion(&mpc8xxx_spi->done);
+
 	mpc8xxx_spi->local_buf =
 		devm_kmalloc(dev, SPCOM_TRANLEN_MAX, GFP_KERNEL);
 	if (!mpc8xxx_spi->local_buf) {
@@ -713,10 +723,6 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 		return -EINVAL;
 	}
 
-	ret = of_mpc8xxx_spi_probe(ofdev);
-	if (ret)
-		return ret;
-
 	num_cs = of_fsl_espi_get_chipselects(dev);
 	if (!num_cs)
 		return -EINVAL;
-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
