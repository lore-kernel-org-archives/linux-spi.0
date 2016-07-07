From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx-pci: Support both chipselects on Braswell" to the spi tree
Date: Thu, 07 Jul 2016 12:05:23 +0200
Message-ID: <E1bL6BP-0001JO-CX@finisterre>
References: <1467749525-100594-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467749525-100594-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx-pci: Support both chipselects on Braswell

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

>From ca80ef718b12eebe247b776d4b97a5e571bb489d Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Tue, 5 Jul 2016 23:12:05 +0300
Subject: [PATCH] spi: pxa2xx-pci: Support both chipselects on Braswell

The commit 30f3a6ab44d8 ("spi: pxa2xx: Add support for both chip selects on
Intel Braswell") introduces a support of chipselects for Intel Braswell SPI
host controller. Though it missed to convert the PCI part of the driver.

Do conversion here which enables both chipselects on Intel Braswell when
enumerated via PCI.

We don't care about num_chipselect value since it is overrided inside core
driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 5953edc86ec8..f3df522db93b 100644
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
