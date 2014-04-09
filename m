From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/9] mtd: st_spi_fsm: fixup Kconfig dependency
Date: Wed,  9 Apr 2014 10:32:51 -0700
Message-ID: <1397064774-31784-6-git-send-email-computersforpeace@gmail.com>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397064774-31784-1-git-send-email-computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I hear that this driver should depend on ARCH_STI, and that "SH" is not
actually a real symbol. At the same time, let's allow compile-testing on
other ARCH'es.

Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mtd/devices/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index f9e32b53dfc6..9aae1042c14f 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -212,7 +212,7 @@ config MTD_DOCG3
 
 config MTD_ST_SPI_FSM
 	tristate "ST Microelectronics SPI FSM Serial Flash Controller"
-	depends on ARM || SH
+	depends on ARCH_STI || COMPILE_TEST
 	help
 	  This provides an MTD device driver for the ST Microelectronics
 	  SPI Fast Sequence Mode (FSM) Serial Flash Controller and support
-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
