From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH 3/6] ARM: shmobile: r7s72100: Add RSPI resources
Date: Tue, 24 Dec 2013 12:56:47 +0100
Message-ID: <1387886210-3634-4-git-send-email-geert+renesas@linux-m68k.org>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387886210-3634-1-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 arch/arm/mach-shmobile/setup-r7s72100.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 55f0b9c7c482..fbcb0c798994 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -79,6 +79,26 @@ static struct resource mtu2_0_resources[] __initdata = {
 					  &mtu2_##idx##_platform_data,	\
 					  sizeof(struct sh_timer_config))
 
+/* RSPI */
+#define RSPI_RESOURCE(idx, baseaddr, irq)				\
+static const struct resource rspi##idx##_resources[] __initconst = {	\
+	DEFINE_RES_MEM(baseaddr, 0x24),					\
+	DEFINE_RES_IRQ(irq),		/* SPEI */			\
+	DEFINE_RES_IRQ(irq + 1),	/* SPRI */			\
+	DEFINE_RES_IRQ(irq + 2),	/* SPTI */			\
+}
+
+RSPI_RESOURCE(0, 0xe800c800, gic_iid(270));
+RSPI_RESOURCE(1, 0xe800d000, gic_iid(273));
+RSPI_RESOURCE(2, 0xe800d800, gic_iid(276));
+RSPI_RESOURCE(3, 0xe800e000, gic_iid(279));
+RSPI_RESOURCE(4, 0xe800e800, gic_iid(282));
+
+#define r7s72100_register_rspi(idx)					\
+	platform_device_register_simple("rspi" #idx, idx,		\
+					rspi##idx##_resources,		\
+					ARRAY_SIZE(rspi##idx##_resources))
+
 void __init r7s72100_add_dt_devices(void)
 {
 	r7s72100_register_scif(SCIF0);
@@ -90,6 +110,11 @@ void __init r7s72100_add_dt_devices(void)
 	r7s72100_register_scif(SCIF6);
 	r7s72100_register_scif(SCIF7);
 	r7s72100_register_mtu2(0);
+	r7s72100_register_rspi(0);
+	r7s72100_register_rspi(1);
+	r7s72100_register_rspi(2);
+	r7s72100_register_rspi(3);
+	r7s72100_register_rspi(4);
 }
 
 void __init r7s72100_init_early(void)
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
