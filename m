From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] Add SPI to platform_no_drv_owner.cocci warnings
Date: Wed, 28 Oct 2015 12:49:07 -0500
Message-ID: <1446054547-23859-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove .owner field if calls are used which set it automatically

Signed-off-by: Andrew F. Davis <afd-l0cyMroinI0@public.gmane.org>
---
 scripts/coccinelle/api/platform_no_drv_owner.cocci | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/scripts/coccinelle/api/platform_no_drv_owner.cocci b/scripts/coccinelle/api/platform_no_drv_owner.cocci
index c5e3f73f..52d5f53 100644
--- a/scripts/coccinelle/api/platform_no_drv_owner.cocci
+++ b/scripts/coccinelle/api/platform_no_drv_owner.cocci
@@ -12,6 +12,7 @@ virtual report
 declarer name module_i2c_driver;
 declarer name module_platform_driver;
 declarer name module_platform_driver_probe;
+declarer name module_spi_driver;
 identifier __driver;
 @@
 (
@@ -20,6 +21,8 @@ identifier __driver;
 	module_platform_driver(__driver);
 |
 	module_platform_driver_probe(__driver, ...);
+|
+	module_spi_driver(__driver);
 )
 
 @fix1 depends on match1 && patch && !context && !org && !report@
@@ -40,6 +43,15 @@ identifier match1.__driver;
 		}
 	};
 
+@fix1_spi depends on match1 && patch && !context && !org && !report@
+identifier match1.__driver;
+@@
+	static struct spi_driver __driver = {
+		.driver = {
+-			.owner = THIS_MODULE,
+		}
+	};
+
 @match2@
 identifier __driver;
 @@
@@ -51,6 +63,8 @@ identifier __driver;
 	platform_create_bundle(&__driver, ...)
 |
 	i2c_add_driver(&__driver)
+|
+	spi_register_driver(&__driver)
 )
 
 @fix2 depends on match2 && patch && !context && !org && !report@
@@ -71,6 +85,15 @@ identifier match2.__driver;
 		}
 	};
 
+@fix2_spi depends on match2 && patch && !context && !org && !report@
+identifier match2.__driver;
+@@
+	static struct spi_driver __driver = {
+		.driver = {
+-			.owner = THIS_MODULE,
+		}
+	};
+
 // ----------------------------------------------------------------------------
 
 @fix1_context depends on match1 && !patch && (context || org || report)@
@@ -95,6 +118,17 @@ position j0;
 		}
 	};
 
+@fix1_spi_context depends on match1 && !patch && (context || org || report)@
+identifier match1.__driver;
+position j0;
+@@
+
+	static struct spi_driver __driver = {
+		.driver = {
+*			.owner@j0 = THIS_MODULE,
+		}
+	};
+
 @fix2_context depends on match2 && !patch && (context || org || report)@
 identifier match2.__driver;
 position j0;
@@ -117,6 +151,17 @@ position j0;
 		}
 	};
 
+@fix2_spi_context depends on match2 && !patch && (context || org || report)@
+identifier match2.__driver;
+position j0;
+@@
+
+	static struct spi_driver __driver = {
+		.driver = {
+*			.owner@j0 = THIS_MODULE,
+		}
+	};
+
 // ----------------------------------------------------------------------------
 
 @script:python fix1_org depends on org@
@@ -133,6 +178,13 @@ j0 << fix1_i2c_context.j0;
 msg = "No need to set .owner here. The core will do it."
 coccilib.org.print_todo(j0[0], msg)
 
+@script:python fix1_spi_org depends on org@
+j0 << fix1_spi_context.j0;
+@@
+
+msg = "No need to set .owner here. The core will do it."
+coccilib.org.print_todo(j0[0], msg)
+
 @script:python fix2_org depends on org@
 j0 << fix2_context.j0;
 @@
@@ -147,6 +199,13 @@ j0 << fix2_i2c_context.j0;
 msg = "No need to set .owner here. The core will do it."
 coccilib.org.print_todo(j0[0], msg)
 
+@script:python fix2_spi_org depends on org@
+j0 << fix2_spi_context.j0;
+@@
+
+msg = "No need to set .owner here. The core will do it."
+coccilib.org.print_todo(j0[0], msg)
+
 // ----------------------------------------------------------------------------
 
 @script:python fix1_report depends on report@
@@ -163,6 +222,13 @@ j0 << fix1_i2c_context.j0;
 msg = "No need to set .owner here. The core will do it."
 coccilib.report.print_report(j0[0], msg)
 
+@script:python fix1_spi_report depends on report@
+j0 << fix1_spi_context.j0;
+@@
+
+msg = "No need to set .owner here. The core will do it."
+coccilib.report.print_report(j0[0], msg)
+
 @script:python fix2_report depends on report@
 j0 << fix2_context.j0;
 @@
@@ -177,3 +243,10 @@ j0 << fix2_i2c_context.j0;
 msg = "No need to set .owner here. The core will do it."
 coccilib.report.print_report(j0[0], msg)
 
+@script:python fix2_spi_report depends on report@
+j0 << fix2_spi_context.j0;
+@@
+
+msg = "No need to set .owner here. The core will do it."
+coccilib.report.print_report(j0[0], msg)
+
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
