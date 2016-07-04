From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pxa2xx-pci: Enable SPI on Intel Merrifield" to the spi tree
Date: Mon, 04 Jul 2016 16:17:28 +0200
Message-ID: <E1bK4gi-0006JF-9B@finisterre>
References: <1467625467-103785-3-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1467625467-103785-3-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pxa2xx-pci: Enable SPI on Intel Merrifield

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

>From 4f4709109ef7e1248b5515c68df4b9c5ad39fbdf Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Mon, 4 Jul 2016 12:44:25 +0300
Subject: [PATCH] spi: pxa2xx-pci: Enable SPI on Intel Merrifield

The SPI controllers used on Intel Merrifield are PXA2XX compatible. This patch
enables them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 8d58598c325d..b025eaf14f0f 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -15,6 +15,7 @@
 enum {
 	PORT_CE4100,
 	PORT_BYT,
+	PORT_MRFLD,
 	PORT_BSW0,
 	PORT_BSW1,
 	PORT_BSW2,
@@ -89,6 +90,27 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
 	return 0;
 }
 
+static int mrfld_spi_setup(struct pci_dev *dev, struct pxa_spi_info *c)
+{
+	switch (PCI_FUNC(dev->devfn)) {
+	case 0:
+		c->port_id = 3;
+		c->num_chipselect = 1;
+		break;
+	case 1:
+		c->port_id = 5;
+		c->num_chipselect = 4;
+		break;
+	case 2:
+		c->port_id = 6;
+		c->num_chipselect = 1;
+		break;
+	default:
+		return -ENODEV;
+	}
+	return 0;
+}
+
 static struct pxa_spi_info spi_info_configs[] = {
 	[PORT_CE4100] = {
 		.type = PXA25x_SSP,
@@ -124,6 +146,11 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.tx_param = &bsw2_tx_param,
 		.rx_param = &bsw2_rx_param,
 	},
+	[PORT_MRFLD] = {
+		.type = PXA27x_SSP,
+		.max_clk_rate = 25000000,
+		.setup = mrfld_spi_setup,
+	},
 	[PORT_QUARK_X1000] = {
 		.type = QUARK_X1000_SSP,
 		.port_id = -1,
@@ -222,6 +249,7 @@ static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
 	{ PCI_VDEVICE(INTEL, 0x2e6a), PORT_CE4100 },
 	{ PCI_VDEVICE(INTEL, 0x0935), PORT_QUARK_X1000 },
 	{ PCI_VDEVICE(INTEL, 0x0f0e), PORT_BYT },
+	{ PCI_VDEVICE(INTEL, 0x1194), PORT_MRFLD },
 	{ PCI_VDEVICE(INTEL, 0x228e), PORT_BSW0 },
 	{ PCI_VDEVICE(INTEL, 0x2290), PORT_BSW1 },
 	{ PCI_VDEVICE(INTEL, 0x22ac), PORT_BSW2 },
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
