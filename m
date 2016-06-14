From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "SPI: imx: Remove "maybe_unused" attributes" to the spi tree
Date: Tue, 14 Jun 2016 10:19:15 +0100
Message-ID: <E1bCkV9-000613-1T@finisterre>
References: <1465405329-5153-3-git-send-email-shc_work@mail.ru>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465405329-5153-3-git-send-email-shc_work-JGs/UdohzUI@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   SPI: imx: Remove "maybe_unused" attributes

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

>From 1cc01e4804b581bf1771d2f0e524816c36167d64 Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Date: Wed, 8 Jun 2016 20:02:08 +0300
Subject: [PATCH] SPI: imx: Remove "maybe_unused" attributes

The SPI-driver no longer contains the conditions for various CPUs, so
"maybe_unused" attributes is no longer needed.
This patch removes these attributes.

Signed-off-by: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 0aa38c23e064..cafe42c72435 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -309,7 +309,7 @@ static unsigned int mx51_ecspi_clkdiv(struct spi_imx_data *spi_imx,
 		(post << MX51_ECSPI_CTRL_POSTDIV_OFFSET);
 }
 
-static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
 	unsigned val = 0;
 
@@ -322,7 +322,7 @@ static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int
 	writel(val, spi_imx->base + MX51_ECSPI_INT);
 }
 
-static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
+static void mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 {
 	u32 reg;
 
@@ -331,8 +331,8 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
-static int __maybe_unused mx51_ecspi_config(struct spi_device *spi,
-					    struct spi_imx_config *config)
+static int mx51_ecspi_config(struct spi_device *spi,
+			     struct spi_imx_config *config)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
@@ -422,12 +422,12 @@ static int __maybe_unused mx51_ecspi_config(struct spi_device *spi,
 	return 0;
 }
 
-static int __maybe_unused mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
+static int mx51_ecspi_rx_available(struct spi_imx_data *spi_imx)
 {
 	return readl(spi_imx->base + MX51_ECSPI_STAT) & MX51_ECSPI_STAT_RR;
 }
 
-static void __maybe_unused mx51_ecspi_reset(struct spi_imx_data *spi_imx)
+static void mx51_ecspi_reset(struct spi_imx_data *spi_imx)
 {
 	/* drain receive buffer */
 	while (mx51_ecspi_rx_available(spi_imx))
@@ -457,7 +457,7 @@ static void __maybe_unused mx51_ecspi_reset(struct spi_imx_data *spi_imx)
  * the i.MX35 has a slightly different register layout for bits
  * we do not use here.
  */
-static void __maybe_unused mx31_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void mx31_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
 	unsigned int val = 0;
 
@@ -469,7 +469,7 @@ static void __maybe_unused mx31_intctrl(struct spi_imx_data *spi_imx, int enable
 	writel(val, spi_imx->base + MXC_CSPIINT);
 }
 
-static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
+static void mx31_trigger(struct spi_imx_data *spi_imx)
 {
 	unsigned int reg;
 
@@ -478,8 +478,7 @@ static void __maybe_unused mx31_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int __maybe_unused mx31_config(struct spi_device *spi,
-				      struct spi_imx_config *config)
+static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
@@ -510,12 +509,12 @@ static int __maybe_unused mx31_config(struct spi_device *spi,
 	return 0;
 }
 
-static int __maybe_unused mx31_rx_available(struct spi_imx_data *spi_imx)
+static int mx31_rx_available(struct spi_imx_data *spi_imx)
 {
 	return readl(spi_imx->base + MX31_CSPISTATUS) & MX31_STATUS_RR;
 }
 
-static void __maybe_unused mx31_reset(struct spi_imx_data *spi_imx)
+static void mx31_reset(struct spi_imx_data *spi_imx)
 {
 	/* drain receive buffer */
 	while (readl(spi_imx->base + MX31_CSPISTATUS) & MX31_STATUS_RR)
@@ -535,7 +534,7 @@ static void __maybe_unused mx31_reset(struct spi_imx_data *spi_imx)
 #define MX21_CSPICTRL_DR_SHIFT	14
 #define MX21_CSPICTRL_CS_SHIFT	19
 
-static void __maybe_unused mx21_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void mx21_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
 	unsigned int val = 0;
 
@@ -547,7 +546,7 @@ static void __maybe_unused mx21_intctrl(struct spi_imx_data *spi_imx, int enable
 	writel(val, spi_imx->base + MXC_CSPIINT);
 }
 
-static void __maybe_unused mx21_trigger(struct spi_imx_data *spi_imx)
+static void mx21_trigger(struct spi_imx_data *spi_imx)
 {
 	unsigned int reg;
 
@@ -556,8 +555,7 @@ static void __maybe_unused mx21_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int __maybe_unused mx21_config(struct spi_device *spi,
-				      struct spi_imx_config *config)
+static int mx21_config(struct spi_device *spi, struct spi_imx_config *config)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_MASTER;
@@ -581,12 +579,12 @@ static int __maybe_unused mx21_config(struct spi_device *spi,
 	return 0;
 }
 
-static int __maybe_unused mx21_rx_available(struct spi_imx_data *spi_imx)
+static int mx21_rx_available(struct spi_imx_data *spi_imx)
 {
 	return readl(spi_imx->base + MXC_CSPIINT) & MX21_INTREG_RR;
 }
 
-static void __maybe_unused mx21_reset(struct spi_imx_data *spi_imx)
+static void mx21_reset(struct spi_imx_data *spi_imx)
 {
 	writel(1, spi_imx->base + MXC_RESET);
 }
@@ -602,7 +600,7 @@ static void __maybe_unused mx21_reset(struct spi_imx_data *spi_imx)
 #define MX1_CSPICTRL_MASTER	(1 << 10)
 #define MX1_CSPICTRL_DR_SHIFT	13
 
-static void __maybe_unused mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
 {
 	unsigned int val = 0;
 
@@ -614,7 +612,7 @@ static void __maybe_unused mx1_intctrl(struct spi_imx_data *spi_imx, int enable)
 	writel(val, spi_imx->base + MXC_CSPIINT);
 }
 
-static void __maybe_unused mx1_trigger(struct spi_imx_data *spi_imx)
+static void mx1_trigger(struct spi_imx_data *spi_imx)
 {
 	unsigned int reg;
 
@@ -623,8 +621,7 @@ static void __maybe_unused mx1_trigger(struct spi_imx_data *spi_imx)
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 }
 
-static int __maybe_unused mx1_config(struct spi_device *spi,
-				     struct spi_imx_config *config)
+static int mx1_config(struct spi_device *spi, struct spi_imx_config *config)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
@@ -643,12 +640,12 @@ static int __maybe_unused mx1_config(struct spi_device *spi,
 	return 0;
 }
 
-static int __maybe_unused mx1_rx_available(struct spi_imx_data *spi_imx)
+static int mx1_rx_available(struct spi_imx_data *spi_imx)
 {
 	return readl(spi_imx->base + MXC_CSPIINT) & MX1_INTREG_RR;
 }
 
-static void __maybe_unused mx1_reset(struct spi_imx_data *spi_imx)
+static void mx1_reset(struct spi_imx_data *spi_imx)
 {
 	writel(1, spi_imx->base + MXC_RESET);
 }
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
