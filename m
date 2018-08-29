From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] spi: dw-mmio: add MSCC Jaguar2 support
Date: Wed, 29 Aug 2018 14:45:48 +0200
Message-ID: <20180829124548.4703-1-alexandre.belloni@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Unfortunately, the Jaguar2 CPU_SYSTEM_CTRL register set has a different
layout than the Ocelot one. Handle that while keeping most of the code
common.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Hi,

This is really unfortunate and I hope it will not be necessary to do the same
for every SoC in the line.

I didn't use a regmap_field because it is only accessed once at probe time.

 drivers/spi/spi-dw-mmio.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index e80f60ed6fdf..351f49976161 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -34,8 +34,8 @@ struct dw_spi_mmio {
 };
 
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
-#define OCELOT_IF_SI_OWNER_MASK			GENMASK(5, 4)
 #define OCELOT_IF_SI_OWNER_OFFSET		4
+#define JAGUAR2_IF_SI_OWNER_OFFSET		6
 #define MSCC_IF_SI_OWNER_SISL			0
 #define MSCC_IF_SI_OWNER_SIBM			1
 #define MSCC_IF_SI_OWNER_SIMC			2
@@ -76,7 +76,8 @@ static void dw_spi_mscc_set_cs(struct spi_device *spi, bool enable)
 }
 
 static int dw_spi_mscc_init(struct platform_device *pdev,
-			    struct dw_spi_mmio *dwsmmio)
+			    struct dw_spi_mmio *dwsmmio,
+			    const char *cpu_syscon, u32 if_si_owner_offset)
 {
 	struct dw_spi_mscc *dwsmscc;
 	struct resource *res;
@@ -92,7 +93,7 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 		return PTR_ERR(dwsmscc->spi_mst);
 	}
 
-	dwsmscc->syscon = syscon_regmap_lookup_by_compatible("mscc,ocelot-cpu-syscon");
+	dwsmscc->syscon = syscon_regmap_lookup_by_compatible(cpu_syscon);
 	if (IS_ERR(dwsmscc->syscon))
 		return PTR_ERR(dwsmscc->syscon);
 
@@ -101,8 +102,8 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 
 	/* Select the owner of the SI interface */
 	regmap_update_bits(dwsmscc->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
-			   OCELOT_IF_SI_OWNER_MASK,
-			   MSCC_IF_SI_OWNER_SIMC << OCELOT_IF_SI_OWNER_OFFSET);
+			   0x3 << if_si_owner_offset,
+			   MSCC_IF_SI_OWNER_SIMC << if_si_owner_offset);
 
 	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
 	dwsmmio->priv = dwsmscc;
@@ -110,6 +111,20 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dw_spi_mscc_ocelot_init(struct platform_device *pdev,
+				   struct dw_spi_mmio *dwsmmio)
+{
+	return dw_spi_mscc_init(pdev, dwsmmio, "mscc,ocelot-cpu-syscon",
+				OCELOT_IF_SI_OWNER_OFFSET);
+}
+
+static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
+				    struct dw_spi_mmio *dwsmmio)
+{
+	return dw_spi_mscc_init(pdev, dwsmmio, "mscc,jaguar2-cpu-syscon",
+				JAGUAR2_IF_SI_OWNER_OFFSET);
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -212,7 +227,8 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 
 static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dw-apb-ssi", },
-	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_init},
+	{ .compatible = "mscc,ocelot-spi", .data = dw_spi_mscc_ocelot_init},
+	{ .compatible = "mscc,jaguar2-spi", .data = dw_spi_mscc_jaguar2_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.18.0
