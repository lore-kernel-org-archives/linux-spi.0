From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: cadence: Allow for GPIO pins to be used as chipselects" to the spi tree
Date: Wed, 26 Apr 2017 15:50:16 +0100
Message-ID: <E1d3OGm-0000co-4p@finisterre>
References: <1493145014-3163-1-git-send-email-mdf@kernel.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, alex.williams-acOepvfBmUk@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Moritz Fischer <mdf-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493145014-3163-1-git-send-email-mdf-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: cadence: Allow for GPIO pins to be used as chipselects

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

>From b42a33bd93fe0b2438511b1c7c00cfd47e17841b Mon Sep 17 00:00:00 2001
From: Moritz Fischer <mdf-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Date: Tue, 25 Apr 2017 11:30:14 -0700
Subject: [PATCH] spi: cadence: Allow for GPIO pins to be used as chipselects

This adds support for using GPIOs for chipselects as described by the
default dt-bindings.

Signed-off-by: Moritz Fischer <mdf-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 1c57ce64abba..f0b5c7b91f37 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -127,6 +128,10 @@ struct cdns_spi {
 	u32 is_decoded_cs;
 };
 
+struct cdns_spi_device_data {
+	bool gpio_requested;
+};
+
 /* Macros for the SPI controller read/write */
 static inline u32 cdns_spi_read(struct cdns_spi *xspi, u32 offset)
 {
@@ -456,6 +461,64 @@ static int cdns_unprepare_transfer_hardware(struct spi_master *master)
 	return 0;
 }
 
+static int cdns_spi_setup(struct spi_device *spi)
+{
+
+	int ret = -EINVAL;
+	struct cdns_spi_device_data *cdns_spi_data = spi_get_ctldata(spi);
+
+	/* this is a pin managed by the controller, leave it alone */
+	if (spi->cs_gpio == -ENOENT)
+		return 0;
+
+	/* this seems to be the first time we're here */
+	if (!cdns_spi_data) {
+		cdns_spi_data = kzalloc(sizeof(*cdns_spi_data), GFP_KERNEL);
+		if (!cdns_spi_data)
+			return -ENOMEM;
+		cdns_spi_data->gpio_requested = false;
+		spi_set_ctldata(spi, cdns_spi_data);
+	}
+
+	/* if we haven't done so, grab the gpio */
+	if (!cdns_spi_data->gpio_requested && gpio_is_valid(spi->cs_gpio)) {
+		ret = gpio_request_one(spi->cs_gpio,
+				       (spi->mode & SPI_CS_HIGH) ?
+				       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
+				       dev_name(&spi->dev));
+		if (ret)
+			dev_err(&spi->dev, "can't request chipselect gpio %d\n",
+				spi->cs_gpio);
+		else
+			cdns_spi_data->gpio_requested = true;
+	} else {
+		if (gpio_is_valid(spi->cs_gpio)) {
+			int mode = ((spi->mode & SPI_CS_HIGH) ?
+				    GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH);
+
+			ret = gpio_direction_output(spi->cs_gpio, mode);
+			if (ret)
+				dev_err(&spi->dev, "chipselect gpio %d setup failed (%d)\n",
+					spi->cs_gpio, ret);
+		}
+	}
+
+	return ret;
+}
+
+static void cdns_spi_cleanup(struct spi_device *spi)
+{
+	struct cdns_spi_device_data *cdns_spi_data = spi_get_ctldata(spi);
+
+	if (cdns_spi_data) {
+		if (cdns_spi_data->gpio_requested)
+			gpio_free(spi->cs_gpio);
+		kfree(cdns_spi_data);
+		spi_set_ctldata(spi, NULL);
+	}
+
+}
+
 /**
  * cdns_spi_probe - Probe method for the SPI driver
  * @pdev:	Pointer to the platform_device structure
@@ -555,6 +618,8 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	master->transfer_one = cdns_transfer_one;
 	master->unprepare_transfer_hardware = cdns_unprepare_transfer_hardware;
 	master->set_cs = cdns_spi_chipselect;
+	master->setup = cdns_spi_setup;
+	master->cleanup = cdns_spi_cleanup;
 	master->auto_runtime_pm = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA;
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
