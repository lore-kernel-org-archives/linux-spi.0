From: stephanolbrich-Mmb7MZpHnFY@public.gmane.org
Subject: [PATCH 1/4] spi: bcm2835aux: fix bitmask defines
Date: Tue,  9 Feb 2016 19:10:32 +0100
Message-ID: <1455041435-8015-2-git-send-email-stephanolbrich@gmx.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
Cc: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455041435-8015-1-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>

The bitmasks for txempty and idle interrupts were interchanged.

Signed-off-by: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 7de6f84..ecc73c0 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -73,8 +73,8 @@
 
 /* Bitfields in CNTL1 */
 #define BCM2835_AUX_SPI_CNTL1_CSHIGH	0x00000700
-#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000080
-#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000040
+#define BCM2835_AUX_SPI_CNTL1_TXEMPTY	0x00000080
+#define BCM2835_AUX_SPI_CNTL1_IDLE	0x00000040
 #define BCM2835_AUX_SPI_CNTL1_MSBF_IN	0x00000002
 #define BCM2835_AUX_SPI_CNTL1_KEEP_IN	0x00000001
 
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
