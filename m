From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit value
Date: Wed, 22 Jul 2015 07:32:23 -0500
Message-ID: <1437568344-18889-4-git-send-email-fcooper@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-spi@vger.kernel.org>, <khilman@deeprootsystems.com>,
	<linux@arm.linux.org.uk>, <galak@codeaurora.org>,
	<ijc+devicetree@hellion.org.uk>, <mark.rutland@arm.com>,
	<pawel.moll@arm.com>, <robh+dt@kernel.org>,
	<linux-arm-kernel@list.infradead.org>,
	Franklin S Cooper Jr <fcooper@ti.com>
To: <broonie@kernel.org>, <nsekhar@ti.com>, <ssantosh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437568344-18889-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI Davinci driver has been updated to allow SOCs to specify their minimum
prescale value. Update the various SOCs board files that use this driver with
their proper prescaler limit.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
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
1.9.1
