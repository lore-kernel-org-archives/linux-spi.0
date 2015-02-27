From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] spi: pl022: Don't touch unspecified bits in interrupt
 mask
Date: Fri, 27 Feb 2015 16:30:07 +0100
Message-ID: <54F08D7F.6050301@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi: pl022: Don't touch unspecified bits in interrupt mask

PL022 Programmers model explicitely states "do not modify undefined register
bits". Correct the "all enable" interrupt mask so that it only enables defined
ones.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-pl022.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index f68cbf6..0566657 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -278,7 +278,12 @@
  */
 #define DEFAULT_SSP_REG_IMSC  0x0UL
 #define DISABLE_ALL_INTERRUPTS DEFAULT_SSP_REG_IMSC
-#define ENABLE_ALL_INTERRUPTS (~DEFAULT_SSP_REG_IMSC)
+#define ENABLE_ALL_INTERRUPTS ( \
+	SSP_IMSC_MASK_RORIM | \
+	SSP_IMSC_MASK_RTIM | \
+	SSP_IMSC_MASK_RXIM | \
+	SSP_IMSC_MASK_TXIM \
+)
 
 #define CLEAR_ALL_INTERRUPTS  0x3
 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
