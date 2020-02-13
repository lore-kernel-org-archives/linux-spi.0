From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] trivial: spi: typo Emptry -> Empty
Date: Thu, 13 Feb 2020 12:27:50 +0100
Message-ID: <20200213112750.17450-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Found while reading though spi.c

Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f9502dbbb5c1..93556567ccb9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -92,7 +92,7 @@ static ssize_t driver_override_store(struct device *dev,
 	if (len) {
 		spi->driver_override = driver_override;
 	} else {
-		/* Emptry string, disable driver override */
+		/* Empty string, disable driver override */
 		spi->driver_override = NULL;
 		kfree(driver_override);
 	}
-- 
2.25.0
