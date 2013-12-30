From: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/1] spi: nuc900: Cleanup spi-nuc900.h header
Date: Mon, 30 Dec 2013 11:56:42 +0530
Message-ID: <1388384802-32660-1-git-send-email-sachin.kamat@linaro.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 54ecf4f05637 ("ARM: w90x900: move platform_data definitions")
moved the file to the current location but forgot to remove the pointer
to its previous location. Clean it up. While at it also change the header
file protection macros appropriately.

Signed-off-by: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 include/linux/platform_data/spi-nuc900.h |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_data/spi-nuc900.h b/include/linux/platform_data/spi-nuc900.h
index 2c4e0c128501..4b3f46832e19 100644
--- a/include/linux/platform_data/spi-nuc900.h
+++ b/include/linux/platform_data/spi-nuc900.h
@@ -1,6 +1,4 @@
 /*
- * arch/arm/mach-w90x900/include/mach/nuc900_spi.h
- *
  * Copyright (c) 2009 Nuvoton technology corporation.
  *
  * Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
@@ -11,8 +9,8 @@
  *
  */
 
-#ifndef __ASM_ARCH_SPI_H
-#define __ASM_ARCH_SPI_H
+#ifndef __SPI_NUC900_H
+#define __SPI_NUC900_H
 
 extern void mfp_set_groupg(struct device *dev, const char *subname);
 
@@ -32,4 +30,4 @@ struct nuc900_spi_chip {
 	unsigned char bits_per_word;
 };
 
-#endif /* __ASM_ARCH_SPI_H */
+#endif /* __SPI_NUC900_H */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
