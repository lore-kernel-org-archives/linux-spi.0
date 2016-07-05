From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] spi: pxa2xx-pci: Support both chipselects on Braswell
Date: Tue,  5 Jul 2016 23:12:05 +0300
Message-ID: <1467749525-100594-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The commit 30f3a6ab44d8 ("spi: pxa2xx: Add support for both chip selects on
Intel Braswell") introduces a support of chipselects for Intel Braswell SPI
host controller. Though it missed to convert the PCI part of the driver.

Do conversion here which enables both chipselects on Intel Braswell when
enumerated via PCI.

We don't care about num_chipselect value since it is overrided inside core
driver.

Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Fixes: 30f3a6ab44d8 ("spi: pxa2xx: Add support for both chip selects on Intel Braswell")
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 5953edc..f3df522 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -127,21 +127,21 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.rx_param = &byt_rx_param,
 	},
 	[PORT_BSW0] = {
-		.type = LPSS_BYT_SSP,
+		.type = LPSS_BSW_SSP,
 		.port_id = 0,
 		.setup = lpss_spi_setup,
 		.tx_param = &bsw0_tx_param,
 		.rx_param = &bsw0_rx_param,
 	},
 	[PORT_BSW1] = {
-		.type = LPSS_BYT_SSP,
+		.type = LPSS_BSW_SSP,
 		.port_id = 1,
 		.setup = lpss_spi_setup,
 		.tx_param = &bsw1_tx_param,
 		.rx_param = &bsw1_rx_param,
 	},
 	[PORT_BSW2] = {
-		.type = LPSS_BYT_SSP,
+		.type = LPSS_BSW_SSP,
 		.port_id = 2,
 		.setup = lpss_spi_setup,
 		.tx_param = &bsw2_tx_param,
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
