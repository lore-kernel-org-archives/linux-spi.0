From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] SPI: BCM2835: clock divider can be a multiple of 2
Date: Thu, 19 Mar 2015 09:01:52 +0000
Message-ID: <1426755714-28130-3-git-send-email-kernel@martin.sperl.org>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, warren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1426755714-28130-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

The official documentation is wrong in this respect.
Has been tested empirically for dividers 2-1024

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index e1dea40..779e3a8 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -192,8 +192,9 @@ static int bcm2835_spi_start_transfer(
 	if (spi_hz >= clk_hz / 2) {
 		cdiv = 2; /* clk_hz/2 is the fastest we can go */
 	} else if (spi_hz) {
-		/* CDIV must be a power of two */
-		cdiv = roundup_pow_of_two(DIV_ROUND_UP(clk_hz, spi_hz));
+		/* CDIV must be a multiple of two */
+		cdiv = DIV_ROUND_UP(clk_hz, spi_hz);
+		cdiv += (cdiv % 2);
 
 		if (cdiv >= 65536)
 			cdiv = 0; /* 0 is the slowest we can go */
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
