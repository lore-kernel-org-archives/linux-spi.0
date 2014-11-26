From: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: meson: Select REGMAP_MMIO
Date: Thu, 27 Nov 2014 00:07:48 +0100
Message-ID: <1417043268-17563-1-git-send-email-b.galvani@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The Meson SPIFC driver uses regmap mmio functions and so it must
select REGMAP_MMIO to avoid the following build error:

spi-meson-spifc.c: undefined reference to `devm_regmap_init_mmio_clk'

Reported-by: Jim Davis <jim.epost-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Beniamino Galvani <b.galvani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 0373c37..400c344 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -311,6 +311,7 @@ config SPI_FSL_ESPI
 config SPI_MESON_SPIFC
 	tristate "Amlogic Meson SPIFC controller"
 	depends on ARCH_MESON || COMPILE_TEST
+	select REGMAP_MMIO
 	help
 	  This enables master mode support for the SPIFC (SPI flash
 	  controller) available in Amlogic Meson SoCs.
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
