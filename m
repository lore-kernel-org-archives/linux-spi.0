From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Fwd: [PATCH] Add default selection of PL022 for
	ARM reference platforms
Date: Sat, 11 Jul 2009 11:19:43 -0700
Message-ID: <200907111119.44087.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
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


----------  Forwarded Message  ----------

Subject: [PATCH] Add default selection of PL022 for ARM reference platforms
Date: Saturday 11 July 2009
From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>

From: Linus Walleij <Linus Walleij linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

This makes the PL022 driver a default choice for any RealView and
Versatile boards plus the integrator IMPD1 which all contain the
PL022 PrimeCell. This will make it a default choice if and only
if a user selects SPI support for their board.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

---
 drivers/spi/Kconfig |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2c733c2..37a7aac 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -173,6 +173,9 @@ config SPI_PL022
 	tristate "ARM AMBA PL022 SSP controller (EXPERIMENTAL)"
 	depends on ARM_AMBA && EXPERIMENTAL
 	default y if MACH_U300
+	default y if ARCH_REALVIEW
+	default y if INTEGRATOR_IMPD1
+	default y if ARCH_VERSATILE
 	help
 	  This selects the ARM(R) AMBA(R) PrimeCell PL022 SSP
 	  controller. If you have an embedded system with an AMBA(R)
-- 
1.6.2.5


-------------------------------------------------------

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
