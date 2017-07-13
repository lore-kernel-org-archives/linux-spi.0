From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 2/6] ACPI / x86: Consolidate Apple DMI checks
Date: Fri, 14 Jul 2017 00:36:19 +0200
Message-ID: <a0c795358306954294e7fe31ec974f3c51b56f4c.1499983092.git.lukas@wunner.de>
References: <cover.1499983092.git.lukas@wunner.de>
Cc: Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1499983092.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We're about to amend device scan with multiple checks whether we're
running on a Mac.  Speed that up by performing the DMI match only once
and caching the result.

Switch over existing Apple DMI checks, thereby fixing two deficiencies:

* They only match "Apple Inc." but not "Apple Computer, Inc.", which is
  used by BIOSes released between January 2006 (when the first x86 Macs
  started shipping) and January 2007 (when the company name changed upon
  introduction of the iPhone).

* They are now #defined to false on non-x86 arches and can thus be
  optimized away by the compiler.

Suggested-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
---
Changes v2 -> v3:
- Newly inserted patch in v3 to avoid repeated DMI checks for Apple
  hardware:  The result of the first DMI check in osi.c is cached.
  Two other existing DMI checks are converted to use the result.
  Because one of them is in a module (sbs.ko), the bool is_apple_system
  needs to be exported.  On non-x86, the DMI checks and Apple-specific
  code are omitted altogether. (Andy, Rafael)

 drivers/acpi/osi.c      |  4 ++++
 drivers/acpi/pci_root.c |  3 +--
 drivers/acpi/sbs.c      | 24 +-----------------------
 include/linux/acpi.h    |  6 ++++++
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index cd953ae10238..6c253d4006b4 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -258,12 +258,16 @@ bool acpi_osi_is_win8(void)
 EXPORT_SYMBOL(acpi_osi_is_win8);
 
 #ifdef CONFIG_X86
+bool is_apple_system;
+EXPORT_SYMBOL(is_apple_system);
+
 static void __init acpi_osi_dmi_darwin(bool enable,
 				       const struct dmi_system_id *d)
 {
 	pr_notice("DMI detected to setup _OSI(\"Darwin\"): %s\n", d->ident);
 	osi_config.darwin_dmi = 1;
 	__acpi_osi_setup_darwin(enable);
+	is_apple_system = true;
 }
 
 static void __init acpi_osi_dmi_linux(bool enable,
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9eec3095e6c3..1b6341717820 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -431,8 +431,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 	 * been called successfully. We know the feature set supported by the
 	 * platform, so avoid calling _OSC at all
 	 */
-
-	if (dmi_match(DMI_SYS_VENDOR, "Apple Inc.")) {
+	if (is_apple_system) {
 		root->osc_control_set = ~OSC_PCI_EXPRESS_PME_CONTROL;
 		decode_osc_control(root, "OS assumes control of",
 				   root->osc_control_set);
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index ad0b13ad4bbb..9b945ae0037e 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -31,7 +31,6 @@
 #include <linux/jiffies.h>
 #include <linux/delay.h>
 #include <linux/power_supply.h>
-#include <linux/dmi.h>
 
 #include "sbshc.h"
 #include "battery.h"
@@ -58,8 +57,6 @@ static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
 MODULE_PARM_DESC(cache_time, "cache time in milliseconds");
 
-static bool sbs_manager_broken;
-
 #define MAX_SBS_BAT			4
 #define ACPI_SBS_BLOCK_MAX		32
 
@@ -632,31 +629,12 @@ static void acpi_sbs_callback(void *context)
 	}
 }
 
-static int disable_sbs_manager(const struct dmi_system_id *d)
-{
-	sbs_manager_broken = true;
-	return 0;
-}
-
-static struct dmi_system_id acpi_sbs_dmi_table[] = {
-	{
-		.callback = disable_sbs_manager,
-		.ident = "Apple",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc.")
-		},
-	},
-	{ },
-};
-
 static int acpi_sbs_add(struct acpi_device *device)
 {
 	struct acpi_sbs *sbs;
 	int result = 0;
 	int id;
 
-	dmi_check_system(acpi_sbs_dmi_table);
-
 	sbs = kzalloc(sizeof(struct acpi_sbs), GFP_KERNEL);
 	if (!sbs) {
 		result = -ENOMEM;
@@ -677,7 +655,7 @@ static int acpi_sbs_add(struct acpi_device *device)
 
 	result = 0;
 
-	if (!sbs_manager_broken) {
+	if (!is_apple_system) {
 		result = acpi_manager_get_info(sbs);
 		if (!result) {
 			sbs->manager_present = 1;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index cafdfb84ca28..d068cee890ee 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -389,6 +389,12 @@ extern int acpi_blacklisted(void);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
+#ifdef CONFIG_X86
+extern bool is_apple_system;
+#else
+#define is_apple_system false
+#endif
+
 #ifdef CONFIG_ACPI_NUMA
 int acpi_map_pxm_to_online_node(int pxm);
 int acpi_get_node(acpi_handle handle);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
