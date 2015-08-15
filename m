From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ARM: davinci: Set proper SPI prescale limit value" to the spi tree
Date: Sat, 15 Aug 2015 09:22:52 -0700
Message-ID: <E1ZQeEO-0007af-2t@finisterre>
References: <1436903127-6777-4-git-send-email-fcooper@ti.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
	Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436903127-6777-4-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   ARM: davinci: Set proper SPI prescale limit value

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

>From 1b0838b5a794456ca36ce02b405bd7bcc85bfba0 Mon Sep 17 00:00:00 2001
From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Date: Wed, 12 Aug 2015 08:26:19 -0500
Subject: [PATCH] ARM: davinci: Set proper SPI prescale limit value

SPI Davinci driver has been updated to allow SOCs to specify their minimum
prescale value. Update the various SOCs board files that use this driver with
their proper prescaler limit.

Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-davinci/devices-da8xx.c | 2 ++
 arch/arm/mach-davinci/dm355.c         | 1 +
 arch/arm/mach-davinci/dm365.c         | 1 +
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index ddfdd82..29e08aa 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1010,11 +1010,13 @@ static struct davinci_spi_platform_data da8xx_spi_pdata[] = {
 		.version	= SPI_VERSION_2,
 		.intr_line	= 1,
 		.dma_event_q	= EVENTQ_0,
+		.prescaler_limit = 2,
 	},
 	[1] = {
 		.version	= SPI_VERSION_2,
 		.intr_line	= 1,
 		.dma_event_q	= EVENTQ_0,
+		.prescaler_limit = 2,
 	},
 };
 
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 9cbeda7..567dc56 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -411,6 +411,7 @@ static struct davinci_spi_platform_data dm355_spi0_pdata = {
 	.num_chipselect = 2,
 	.cshold_bug	= true,
 	.dma_event_q	= EVENTQ_1,
+	.prescaler_limit = 1,
 };
 static struct platform_device dm355_spi0_device = {
 	.name = "spi_davinci",
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index e3a3c54..6a890a8 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -646,6 +646,7 @@ static struct davinci_spi_platform_data dm365_spi0_pdata = {
 	.version 	= SPI_VERSION_1,
 	.num_chipselect = 2,
 	.dma_event_q	= EVENTQ_3,
+	.prescaler_limit = 1,
 };
 
 static struct resource dm365_spi0_resources[] = {
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
