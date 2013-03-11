From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH v2] spi: spi-mpc512x-psc: add support for gpio chip selects
Date: Tue, 12 Mar 2013 00:23:35 +0100
Message-ID: <1363044215-24061-1-git-send-email-agust@denx.de>
References: <20130205141846.173C43E1265@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130205141846.173C43E1265@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Currently the driver only uses one internal chip select.
Add support for gpio chip selects configured by cs-gpios
DT binding.

Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
---
v2:
 - do not parse GPIO chip selects manually

 drivers/spi/spi-mpc512x-psc.c |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 89480b2..4263ed4 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
+#include <linux/gpio.h>
 #include <asm/mpc52xx_psc.h>
 
 struct mpc512x_psc_spi {
@@ -113,7 +114,7 @@ static void mpc512x_psc_spi_activate_cs(struct spi_device *spi)
 	out_be32(&psc->ccr, ccr);
 	mps->bits_per_word = cs->bits_per_word;
 
-	if (mps->cs_control)
+	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
 		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 1 : 0);
 }
 
@@ -121,7 +122,7 @@ static void mpc512x_psc_spi_deactivate_cs(struct spi_device *spi)
 {
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
 
-	if (mps->cs_control)
+	if (mps->cs_control && gpio_is_valid(spi->cs_gpio))
 		mps->cs_control(spi, (spi->mode & SPI_CS_HIGH) ? 0 : 1);
 
 }
@@ -278,6 +279,7 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
 	struct mpc512x_psc_spi *mps = spi_master_get_devdata(spi->master);
 	struct mpc512x_psc_spi_cs *cs = spi->controller_state;
 	unsigned long flags;
+	int ret;
 
 	if (spi->bits_per_word % 8)
 		return -EINVAL;
@@ -286,6 +288,19 @@ static int mpc512x_psc_spi_setup(struct spi_device *spi)
 		cs = kzalloc(sizeof *cs, GFP_KERNEL);
 		if (!cs)
 			return -ENOMEM;
+
+		if (gpio_is_valid(spi->cs_gpio)) {
+			ret = gpio_request(spi->cs_gpio, dev_name(&spi->dev));
+			if (ret) {
+				dev_err(&spi->dev, "can't get CS gpio: %d\n",
+					ret);
+				kfree(cs);
+				return ret;
+			}
+			gpio_direction_output(spi->cs_gpio,
+					spi->mode & SPI_CS_HIGH ? 0 : 1);
+		}
+
 		spi->controller_state = cs;
 	}
 
@@ -319,6 +334,8 @@ static int mpc512x_psc_spi_transfer(struct spi_device *spi,
 
 static void mpc512x_psc_spi_cleanup(struct spi_device *spi)
 {
+	if (gpio_is_valid(spi->cs_gpio))
+		gpio_free(spi->cs_gpio);
 	kfree(spi->controller_state);
 }
 
@@ -405,6 +422,11 @@ static irqreturn_t mpc512x_psc_spi_isr(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static void mpc512x_spi_cs_control(struct spi_device *spi, bool onoff)
+{
+	gpio_set_value(spi->cs_gpio, onoff);
+}
+
 /* bus_num is used only for the case dev->platform_data == NULL */
 static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 					      u32 size, unsigned int irq,
@@ -425,12 +447,9 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	mps->irq = irq;
 
 	if (pdata == NULL) {
-		dev_err(dev, "probe called without platform data, no "
-			"cs_control function will be called\n");
-		mps->cs_control = NULL;
+		mps->cs_control = mpc512x_spi_cs_control;
 		mps->sysclk = 0;
 		master->bus_num = bus_num;
-		master->num_chipselect = 255;
 	} else {
 		mps->cs_control = pdata->cs_control;
 		mps->sysclk = pdata->sysclk;
-- 
1.7.5.4


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
