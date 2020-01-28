From: Maxim Kochetkov <fido_max-aPYA7nAdAYY@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support
Date: Tue, 28 Jan 2020 09:48:36 +0300
Message-ID: <067ed094-fa5d-f472-8abd-c22f4c0dba03@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Subject: [PATCH] spi: spi-fsl-espi: add GPIO chipselect support

eSPI controller can't send transactions without hardware chip selects.
So, to use GPIO chip selects with eSPI controller we need to use one 
dedicated hardware chip select signal. To specify shared chip select for 
GPIO use "fsl,espi-shared-chipselect" DT property.

Signed-off-by: Maxim Kochetkov <fido_max-aPYA7nAdAYY@public.gmane.org>
---
  .../devicetree/bindings/spi/fsl-spi.txt       |  2 +
  drivers/spi/spi-fsl-espi.c                    | 40 ++++++++++++++-----
  2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt 
b/Documentation/devicetree/bindings/spi/fsl-spi.txt
index 411375eac54d..cfae3e762926 100644
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-spi.txt
@@ -47,6 +47,8 @@ Required properties:
  Optional properties:
  - fsl,csbef: chip select assertion time in bits before frame starts
  - fsl,csaft: chip select negation time in bits after frame ends
+- fsl,espi-shared-chipselect: hardware CS used for gpio chip selects
+- cs-gpios: GPIOs to use as chip selects, see spi-controller.yaml

  Example:
  	spi@110000 {
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index f20326714b9d..edffaa5333b0 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -107,6 +107,7 @@ struct fsl_espi {
  	u32 spibrg;             /* SPIBRG input clock */

  	struct completion done;
+	int shared_cs;
  };

  struct fsl_espi_cs {
@@ -328,6 +329,7 @@ static void fsl_espi_setup_transfer(struct 
spi_device *spi,
  	u32 pm, hz = t ? t->speed_hz : spi->max_speed_hz;
  	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
  	u32 hw_mode_old = cs->hw_mode;
+	int chip_select = spi->cs_gpiod ? espi->shared_cs : spi->chip_select;

  	/* mask out bits we are going to set */
  	cs->hw_mode &= ~(CSMODE_LEN(0xF) | CSMODE_DIV16 | CSMODE_PM(0xF));
@@ -345,7 +347,7 @@ static void fsl_espi_setup_transfer(struct 
spi_device *spi,

  	/* don't write the mode register if the mode doesn't change */
  	if (cs->hw_mode != hw_mode_old)
-		fsl_espi_write_reg(espi, ESPI_SPMODEx(spi->chip_select),
+		fsl_espi_write_reg(espi, ESPI_SPMODEx(chip_select),
  				   cs->hw_mode);
  }

@@ -359,7 +361,12 @@ static int fsl_espi_bufs(struct spi_device *spi, 
struct spi_transfer *t)
  	reinit_completion(&espi->done);

  	/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
-	spcom = SPCOM_CS(spi->chip_select);
+	if (spi->cs_gpiod) {
+		gpiod_set_value(spi->cs_gpiod, 1);
+		spcom = SPCOM_CS(espi->shared_cs);
+	} else {
+		spcom = SPCOM_CS(spi->chip_select);
+	}
  	spcom |= SPCOM_TRANLEN(t->len - 1);

  	/* configure RXSKIP mode */
@@ -385,12 +392,16 @@ static int fsl_espi_bufs(struct spi_device *spi, 
struct spi_transfer *t)

  	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
  	ret = wait_for_completion_timeout(&espi->done, 2 * HZ);
+
+	if (spi->cs_gpiod) {
+		gpiod_set_value(spi->cs_gpiod, 0);
+	}
+
  	if (ret == 0)
  		dev_err(espi->dev, "Transfer timed out!\n");

  	/* disable rx ints */
  	fsl_espi_write_reg(espi, ESPI_SPIM, 0);
-
  	return ret == 0 ? -ETIMEDOUT : 0;
  }

@@ -475,9 +486,10 @@ static int fsl_espi_do_one_msg(struct spi_master 
*master,

  static int fsl_espi_setup(struct spi_device *spi)
  {
-	struct fsl_espi *espi;
  	u32 loop_mode;
+	struct fsl_espi *espi = spi_master_get_devdata(spi->master);
  	struct fsl_espi_cs *cs = spi_get_ctldata(spi);
+	int chip_select = spi->cs_gpiod ? espi->shared_cs : spi->chip_select;

  	if (!cs) {
  		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
@@ -486,11 +498,10 @@ static int fsl_espi_setup(struct spi_device *spi)
  		spi_set_ctldata(spi, cs);
  	}

-	espi = spi_master_get_devdata(spi->master);

  	pm_runtime_get_sync(espi->dev);

-	cs->hw_mode = fsl_espi_read_reg(espi, ESPI_SPMODEx(spi->chip_select));
+	cs->hw_mode = fsl_espi_read_reg(espi, ESPI_SPMODEx(chip_select));
  	/* mask out bits we are going to set */
  	cs->hw_mode &= ~(CSMODE_CP_BEGIN_EDGECLK | CSMODE_CI_INACTIVEHIGH
  			 | CSMODE_REV);
@@ -659,7 +670,7 @@ static void fsl_espi_init_regs(struct device *dev, 
bool initial)
  }

  static int fsl_espi_probe(struct device *dev, struct resource *mem,
-			  unsigned int irq, unsigned int num_cs)
+			  unsigned int irq, unsigned int num_cs, int shared_cs)
  {
  	struct spi_master *master;
  	struct fsl_espi *espi;
@@ -687,6 +698,10 @@ static int fsl_espi_probe(struct device *dev, 
struct resource *mem,

  	espi->dev = dev;
  	espi->spibrg = fsl_get_sys_freq();
+	espi->shared_cs = shared_cs;
+	if (shared_cs >= 0) {
+		master->use_gpio_descriptors = true;
+	}
  	if (espi->spibrg == -1) {
  		dev_err(dev, "Can't get sys frequency!\n");
  		ret = -EINVAL;
@@ -757,7 +772,7 @@ static int of_fsl_espi_probe(struct platform_device 
*ofdev)
  	struct device *dev = &ofdev->dev;
  	struct device_node *np = ofdev->dev.of_node;
  	struct resource mem;
-	unsigned int irq, num_cs;
+	unsigned int irq, num_cs, shared_cs;
  	int ret;

  	if (of_property_read_bool(np, "mode")) {
@@ -777,7 +792,14 @@ static int of_fsl_espi_probe(struct platform_device 
*ofdev)
  	if (!irq)
  		return -EINVAL;

-	return fsl_espi_probe(dev, &mem, irq, num_cs);
+	ret = of_property_read_u32(np, "fsl,espi-shared-chipselect", &shared_cs);
+	if (!ret) {
+		dev_info(dev, "Using CS%d as shared for GPIO CS\n", shared_cs);
+	} else {
+		shared_cs = -1;
+	}
+
+	return fsl_espi_probe(dev, &mem, irq, num_cs, shared_cs);
  }

  static int of_fsl_espi_remove(struct platform_device *dev)
-- 
2.24.0
