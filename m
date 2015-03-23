From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/2] spi: pxa2xx: Remove needless includes
Date: Mon, 23 Mar 2015 14:07:47 +0200
Message-ID: <1427112468-26782-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

These asm/io.h, asm/irq.h and asm/delay.h are needless since they are
already included by linux/io.h via drivers/spi/spi-pxa2xx.h,
linux/interrupt.h and linux/delay.h.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-pxa2xx.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 6f72ad01e041..74342d167324 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -30,10 +30,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/acpi.h>
 
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/delay.h>
-
 #include "spi-pxa2xx.h"
 
 MODULE_AUTHOR("Stephen Street");
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
