From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] ARM: pxa: Remove unused clock_enable field from struct pxa2xx_spi_master
Date: Fri, 18 Sep 2015 10:14:41 +0300
Message-ID: <1442560481-26008-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Paul Parsons <lost.distance-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use for struct pxa2xx_spi_master clock_enable field was removed years ago
from the pxa2xx-spi driver by the commit 2f1a74e5a2de ("[ARM] pxa: make
pxa2xx_spi driver use ssp_request()/ssp_free()").

Therefore remove it from structure definition, documentation and from
couple affected board files.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
I propose this to be merged via ARM tree. I don't see we would need to do
other SPI related changes to struct pxa2xx_spi_master in near future (knock
on wood).
---
 Documentation/spi/pxa2xx       | 6 ------
 arch/arm/mach-pxa/hx4700.c     | 1 -
 arch/arm/mach-pxa/icontrol.c   | 2 --
 arch/arm/mach-pxa/z2.c         | 2 --
 include/linux/spi/pxa2xx_spi.h | 1 -
 5 files changed, 12 deletions(-)

diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx
index 3352f97430e4..13a0b7fb192f 100644
--- a/Documentation/spi/pxa2xx
+++ b/Documentation/spi/pxa2xx
@@ -22,15 +22,10 @@ Typically a SPI master is defined in the arch/.../mach-*/board-*.c as a
 found in include/linux/spi/pxa2xx_spi.h:
 
 struct pxa2xx_spi_master {
-	u32 clock_enable;
 	u16 num_chipselect;
 	u8 enable_dma;
 };
 
-The "pxa2xx_spi_master.clock_enable" field is used to enable/disable the
-corresponding SSP peripheral block in the "Clock Enable Register (CKEN"). See
-the "PXA2xx Developer Manual" section "Clocks and Power Management".
-
 The "pxa2xx_spi_master.num_chipselect" field is used to determine the number of
 slave device (chips) attached to this SPI master.
 
@@ -57,7 +52,6 @@ static struct resource pxa_spi_nssp_resources[] = {
 };
 
 static struct pxa2xx_spi_master pxa_nssp_master_info = {
-	.clock_enable = CKEN_NSSP, /* NSSP Peripheral clock */
 	.num_chipselect = 1, /* Matches the number of chips attached to NSSP */
 	.enable_dma = 1, /* Enables NSSP DMA */
 };
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 5fb41ad6e3bc..1e0301a0dbbb 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -630,7 +630,6 @@ static struct spi_board_info tsc2046_board_info[] __initdata = {
 
 static struct pxa2xx_spi_master pxa_ssp2_master_info = {
 	.num_chipselect = 1,
-	.clock_enable   = CKEN_SSP2,
 	.enable_dma     = 1,
 };
 
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index 9b0eb0252af6..a1869f9b6219 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -116,13 +116,11 @@ static struct spi_board_info mcp251x_board_info[] = {
 };
 
 static struct pxa2xx_spi_master pxa_ssp3_spi_master_info = {
-	.clock_enable   = CKEN_SSP3,
 	.num_chipselect = 2,
 	.enable_dma     = 1
 };
 
 static struct pxa2xx_spi_master pxa_ssp4_spi_master_info = {
-	.clock_enable   = CKEN_SSP4,
 	.num_chipselect = 2,
 	.enable_dma     = 1
 };
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index e1a121b36cfa..3deeca7bbe41 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -595,13 +595,11 @@ static struct spi_board_info spi_board_info[] __initdata = {
 };
 
 static struct pxa2xx_spi_master pxa_ssp1_master_info = {
-	.clock_enable	= CKEN_SSP,
 	.num_chipselect	= 1,
 	.enable_dma	= 1,
 };
 
 static struct pxa2xx_spi_master pxa_ssp2_master_info = {
-	.clock_enable	= CKEN_SSP2,
 	.num_chipselect	= 1,
 };
 
diff --git a/include/linux/spi/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
index 6d36dacec4ba..9ec4c147abbc 100644
--- a/include/linux/spi/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -23,7 +23,6 @@ struct dma_chan;
 
 /* device.platform_data for SSP controller devices */
 struct pxa2xx_spi_master {
-	u32 clock_enable;
 	u16 num_chipselect;
 	u8 enable_dma;
 
-- 
2.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
