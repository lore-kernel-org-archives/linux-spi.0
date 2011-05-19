From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/2] spi/pl022: mark driver non-experimental
Date: Thu, 19 May 2011 14:13:19 +0200
Message-ID: <1305807199-11739-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@stericsson.com>,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

This driver has no TODO, and is now used on several platforms:
ARM, U300, Ux500, SPEAr and more. So drop the EXPERIMENTAL
requirement.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/spi/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fc14b8d..fbd96b2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -271,8 +271,8 @@ config SPI_ORION
 	  This enables using the SPI master controller on the Orion chips.
 
 config SPI_PL022
-	tristate "ARM AMBA PL022 SSP controller (EXPERIMENTAL)"
-	depends on ARM_AMBA && EXPERIMENTAL
+	tristate "ARM AMBA PL022 SSP controller"
+	depends on ARM_AMBA
 	default y if MACH_U300
 	default y if ARCH_REALVIEW
 	default y if INTEGRATOR_IMPD1
-- 
1.7.3.2
