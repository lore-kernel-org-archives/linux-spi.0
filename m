From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/7] spi: s3c24xx: remove unnecessary OOM messages
Date: Tue, 29 Apr 2014 17:20:02 +0900
Message-ID: <002701cf6383$d15b4940$7411dbc0$%han@samsung.com>
References: <002401cf6383$7e9ce1f0$7bd6a5d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002401cf6383$7e9ce1f0$7bd6a5d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-s3c24xx.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index bd85181..e713737 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -185,10 +185,8 @@ static int s3c24xx_spi_setup(struct spi_device *spi)
 		cs = devm_kzalloc(&spi->dev,
 				  sizeof(struct s3c24xx_spi_devstate),
 				  GFP_KERNEL);
-		if (!cs) {
-			dev_err(&spi->dev, "no memory for controller state\n");
+		if (!cs)
 			return -ENOMEM;
-		}
 
 		cs->spcon = SPCON_DEFAULT;
 		cs->hz = -1;
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
