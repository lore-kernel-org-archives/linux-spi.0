From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: dw-mmio: avoid hardcoded field mask" to the spi tree
Date: Fri, 31 Aug 2018 16:43:12 +0100 (BST)
Message-ID: <20180831154312.183C911226FE@debutante.sirena.org.uk>
References: <20180831114046.27094-1-alexandre.belloni@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-spi@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831114046.27094-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: dw-mmio: avoid hardcoded field mask

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From c1d8b0825d50e1eb6b6ea2cb9e450637dba9b4e2 Mon Sep 17 00:00:00 2001
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Fri, 31 Aug 2018 13:40:46 +0200
Subject: [PATCH] spi: dw-mmio: avoid hardcoded field mask

Define a mask for the IF_SI_OWNER field.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-dw-mmio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 351f49976161..a768461614a0 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -36,6 +36,7 @@ struct dw_spi_mmio {
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
 #define OCELOT_IF_SI_OWNER_OFFSET		4
 #define JAGUAR2_IF_SI_OWNER_OFFSET		6
+#define MSCC_IF_SI_OWNER_MASK			GENMASK(1, 0)
 #define MSCC_IF_SI_OWNER_SISL			0
 #define MSCC_IF_SI_OWNER_SIBM			1
 #define MSCC_IF_SI_OWNER_SIMC			2
@@ -102,7 +103,7 @@ static int dw_spi_mscc_init(struct platform_device *pdev,
 
 	/* Select the owner of the SI interface */
 	regmap_update_bits(dwsmscc->syscon, MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL,
-			   0x3 << if_si_owner_offset,
+			   MSCC_IF_SI_OWNER_MASK << if_si_owner_offset,
 			   MSCC_IF_SI_OWNER_SIMC << if_si_owner_offset);
 
 	dwsmmio->dws.set_cs = dw_spi_mscc_set_cs;
-- 
2.19.0.rc1
