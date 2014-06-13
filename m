From: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] spi: spi-adi-v3: Remove redundant OOM message
Date: Fri, 13 Jun 2014 10:17:41 +0530
Message-ID: <1402634862-21783-1-git-send-email-sachin.kamat@samsung.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, spk.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Let memory subsystem do the error logging.

Signed-off-by: Sachin Kamat <sachin.kamat-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-adi-v3.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-adi-v3.c b/drivers/spi/spi-adi-v3.c
index dcb2287c7f8a..19ea8fb78cc7 100644
--- a/drivers/spi/spi-adi-v3.c
+++ b/drivers/spi/spi-adi-v3.c
@@ -660,10 +660,9 @@ static int adi_spi_setup(struct spi_device *spi)
 		struct adi_spi3_chip *chip_info = spi->controller_data;
 
 		chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-		if (!chip) {
-			dev_err(&spi->dev, "can not allocate chip data\n");
+		if (!chip)
 			return -ENOMEM;
-		}
+
 		if (chip_info) {
 			if (chip_info->control & ~ctl_reg) {
 				dev_err(&spi->dev,
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
