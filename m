From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] Add default selection of PL022 for ARM
	reference platforms
Date: Sat, 11 Jul 2009 19:31:41 +0200
Message-ID: <1247333501-17278-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <Linus.Walleij.linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Linus Walleij <Linus Walleij linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

This makes the PL022 driver a default choice for any RealView and
Versatile boards plus the integrator IMPD1 which all contain the
PL022 PrimeCell. This will make it a default choice if and only
if a user selects SPI support for their board.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
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


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
