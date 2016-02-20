From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spi-pxa2xx-pci: Add ID and driver type for WildcatPoint PCH" to the spi tree
Date: Sun, 21 Feb 2016 05:02:26 +0900
Message-ID: <E1aXDjW-00036J-Hf@finisterre>
References: <1455996022-19773-1-git-send-email-leif.liddy@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455996022-19773-1-git-send-email-leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spi-pxa2xx-pci: Add ID and driver type for WildcatPoint PCH

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

>From caba248db2863466a886735cb8d5704048063ac9 Mon Sep 17 00:00:00 2001
From: Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 20 Feb 2016 20:20:22 +0100
Subject: [PATCH] spi: spi-pxa2xx-pci: Add ID and driver type for WildcatPoint
 PCH

WildcatPoint PCH as seen on MacBook 12-inch (Early 2015) has a PCI enabled
SPI controller. Enable it by adding its ID to the corresponding driver.
The ACPI enumerated name for this SPI controller (found in spi-pxa2xx.c) is INT33C1.
Therefore, we associate the SPI controller with the corresponding type of LPSS_LPT_SSP.

Signed-off-by: Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index d19d7f2..520ed1d 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -19,6 +19,7 @@ enum {
 	PORT_BSW1,
 	PORT_BSW2,
 	PORT_QUARK_X1000,
+	PORT_LPT,
 };
 
 struct pxa_spi_info {
@@ -42,6 +43,9 @@ static struct dw_dma_slave bsw1_rx_param = { .src_id = 7 };
 static struct dw_dma_slave bsw2_tx_param = { .dst_id = 8 };
 static struct dw_dma_slave bsw2_rx_param = { .src_id = 9 };
 
+static struct dw_dma_slave lpt_tx_param = { .dst_id = 0 };
+static struct dw_dma_slave lpt_rx_param = { .src_id = 1 };
+
 static bool lpss_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *dws = param;
@@ -98,6 +102,14 @@ static struct pxa_spi_info spi_info_configs[] = {
 		.num_chipselect = 1,
 		.max_clk_rate = 50000000,
 	},
+	[PORT_LPT] = {
+		.type = LPSS_LPT_SSP,
+		.port_id = 0,
+		.num_chipselect = 1,
+		.max_clk_rate = 50000000,
+		.tx_param = &lpt_tx_param,
+		.rx_param = &lpt_rx_param,
+	},
 };
 
 static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
@@ -202,6 +214,7 @@ static const struct pci_device_id pxa2xx_spi_pci_devices[] = {
 	{ PCI_VDEVICE(INTEL, 0x228e), PORT_BSW0 },
 	{ PCI_VDEVICE(INTEL, 0x2290), PORT_BSW1 },
 	{ PCI_VDEVICE(INTEL, 0x22ac), PORT_BSW2 },
+	{ PCI_VDEVICE(INTEL, 0x9ce6), PORT_LPT },
 	{ },
 };
 MODULE_DEVICE_TABLE(pci, pxa2xx_spi_pci_devices);
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
