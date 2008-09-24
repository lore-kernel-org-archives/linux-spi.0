From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.27-rc7] spi: core and gpio expanders
	use subsys_init
Date: Wed, 24 Sep 2008 10:42:48 -0700
Message-ID: <200809241042.48668.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

Make the SPI external GPIO expander drivers register themselves
at subsys_initcall() time when they're statically linked, and
make the SPI core do its driver model initialization earlier so
that's safe.

SOC-integrated GPIOs are available starting very early -- often
before initcalls start to run, or earily in arch_initcall() at
latest -- so this improves consistency, letting more subsystems
rely on GPIOs being usable by their own subsys_initcall() code.

(This patch is a sibling to some related I2C patches.)

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
For the 2.6.28-rc0 merge window.

 drivers/gpio/max7301.c  |    6 ++++--
 drivers/gpio/mcp23s08.c |    5 ++++-
 drivers/spi/spi.c       |    2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/gpio/max7301.c
+++ b/drivers/gpio/max7301.c
@@ -325,13 +325,15 @@ static int __init max7301_init(void)
 {
 	return spi_register_driver(&max7301_driver);
 }
+/* register after spi postcore initcall and before
+ * subsys initcalls that may rely on these GPIOs
+ */
+subsys_initcall(max7301_init);
 
 static void __exit max7301_exit(void)
 {
 	spi_unregister_driver(&max7301_driver);
 }
-
-module_init(max7301_init);
 module_exit(max7301_exit);
 
 MODULE_AUTHOR("Juergen Beisert");
--- a/drivers/gpio/mcp23s08.c
+++ b/drivers/gpio/mcp23s08.c
@@ -419,7 +419,10 @@ static int __init mcp23s08_init(void)
 {
 	return spi_register_driver(&mcp23s08_driver);
 }
-module_init(mcp23s08_init);
+/* register after spi postcore initcall and before
+ * subsys initcalls that may rely on these GPIOs
+ */
+subsys_initcall(mcp23s08_init);
 
 static void __exit mcp23s08_exit(void)
 {
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -738,5 +738,5 @@ err0:
  * driver registration) _could_ be dynamically linked (modular) ... costs
  * include needing to have boardinfo data structures be much more public.
  */
-subsys_initcall(spi_init);
+postcore_initcall(spi_init);
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
