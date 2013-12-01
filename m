From: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Subject: [PATCH 09/11] ARM: shmobile: r8a7791: MSIOF platform device
Date: Mon,  2 Dec 2013 03:19:20 +0900
Message-ID: <1385921962-19843-9-git-send-email-takasi-y@ops.dti.ne.jp>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>

Define resources for msiof0,1,2. HWM says there is msiof3, but omit
it because its clock, reset and irqs are not seen on HWM. Anyway, only
msiof0 is registerd, so far, because others lack of chance for testing.
msiof0 has id=1 (spi_sh_msiof.1), for a compatibility with BSP.

Signed-off-by: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
---
 arch/arm/mach-shmobile/setup-r8a7791.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index cddca99..5669fa0 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -26,6 +26,7 @@
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
+#include <linux/spi/sh_msiof.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a7791.h>
@@ -200,6 +201,34 @@ static const struct resource thermal_resources[] __initconst = {
 					thermal_resources,		\
 					ARRAY_SIZE(thermal_resources))
 
+static const struct sh_msiof_spi_info sh_msiof_info __initconst = {
+	.rx_fifo_override	= 256,
+	.num_chipselect		= 1,
+	.rx_need_dummy_tx	= 1,
+};
+
+static const struct resource sh_msiof0_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6e20000, 0x0064),
+	DEFINE_RES_IRQ(gic_spi(156)),
+};
+
+static const struct resource sh_msiof1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6e10000, 0x0064),
+	DEFINE_RES_IRQ(gic_spi(157)),
+};
+
+static const struct resource sh_msiof2_resources[] __initconst = {
+	DEFINE_RES_MEM(0xe6e00000, 0x0064),
+	DEFINE_RES_IRQ(gic_spi(158)),
+};
+
+#define r8a7791_register_msiof(idx)					\
+	platform_device_register_resndata(&platform_bus, "spi_sh_msiof", \
+				  (idx+1), sh_msiof##idx##_resources,	\
+				  ARRAY_SIZE(sh_msiof##idx##_resources), \
+				  &sh_msiof_info,		\
+				  sizeof(struct sh_msiof_spi_info))
+
 void __init r8a7791_add_dt_devices(void)
 {
 	r8a7791_register_scif(SCIFA0);
@@ -218,6 +247,7 @@ void __init r8a7791_add_dt_devices(void)
 	r8a7791_register_scif(SCIFA4);
 	r8a7791_register_scif(SCIFA5);
 	r8a7791_register_cmt(00);
+	r8a7791_register_msiof(0);
 }
 
 void __init r8a7791_add_standard_devices(void)
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
