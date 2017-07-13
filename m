From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v3 1/6] ACPI / osi: Exclude x86 DMI quirks on other arches
Date: Fri, 14 Jul 2017 00:36:19 +0200
Message-ID: <6dad5b18be68f1b7abb243ec04383bb7011f1ca3.1499983092.git.lukas@wunner.de>
References: <cover.1499983092.git.lukas@wunner.de>
Cc: Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1499983092.git.lukas@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

All existing quirks in acpi_osi_dmi_table[] as well as their callbacks
are specific to x86 so exclude them on other arches.

The simplest approach is to #ifdef the DMI quirks.  An alternative would
be to declare a __weak empty table which can be overridden per arch.

The ability to specify "acpi_osi=Linux" and "acpi_osi=Darwin" on the
command line is retained, though its usefulness on non-x86 arches is
debatable.  (Do we really need to return false to _OSI(Linux) on
non-x86 arches as well?)

Beyond that the ACPI core contains various other x86-specific quirks
(such as video_detect_dmi_table[]) and a bigger effort is needed to
achieve a clean separation of generic and arch-specific code.

Cc: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes v2 -> v3:
- Newly inserted patch in v3 to avoid repeated DMI checks for Apple
  hardware:  The result of the first DMI check in osi.c is cached.
  Two other existing DMI checks are converted to use the result.
  Because one of them is in a module (sbs.ko), the bool is_apple_system
  needs to be exported.  On non-x86, the DMI checks and Apple-specific
  code are omitted altogether. (Andy, Rafael)

 drivers/acpi/osi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 723bee58bbcf..cd953ae10238 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -257,6 +257,7 @@ bool acpi_osi_is_win8(void)
 }
 EXPORT_SYMBOL(acpi_osi_is_win8);
 
+#ifdef CONFIG_X86
 static void __init acpi_osi_dmi_darwin(bool enable,
 				       const struct dmi_system_id *d)
 {
@@ -312,6 +313,7 @@ static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
 
 	return 0;
 }
+#endif /* CONFIG_X86 */
 
 /*
  * Linux default _OSI response behavior is determined by this DMI table.
@@ -320,6 +322,7 @@ static int __init dmi_disable_osi_win8(const struct dmi_system_id *d)
  * by acpi_osi=!Linux/acpi_osi=!Darwin command line options.
  */
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
+#ifdef CONFIG_X86
 	{
 	.callback = dmi_disable_osi_vista,
 	.ident = "Fujitsu Siemens",
@@ -499,6 +502,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
 		},
 	},
+#endif /* CONFIG_X86 */
 	{}
 };
 
-- 
2.11.0

