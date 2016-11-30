From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] spi: orion: fix comment to mention MVEBU
Date: Wed, 30 Nov 2016 11:47:44 +0100
Message-ID: <20161130104744.19724-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
        Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

MVEBU chips (Armada XP, Armada 370 and others) are supported by this
driver. Mention this in the help text to make more obvious what is
already specified in the dependencies of this symbol.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b7995474148c..2b0119150bde 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -451,7 +451,8 @@ config SPI_ORION
 	tristate "Orion SPI master"
 	depends on PLAT_ORION || ARCH_MVEBU || COMPILE_TEST
 	help
-	  This enables using the SPI master controller on the Orion chips.
+	  This enables using the SPI master controller on the Orion
+	  and MVEBU chips.
 
 config SPI_PIC32
 	tristate "Microchip PIC32 series SPI"
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
