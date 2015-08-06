From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: img-spfi: fix kbuild test robot warning
Date: Thu, 6 Aug 2015 10:33:01 +0100
Message-ID: <1438853581-17154-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

drivers/spi/spi-img-spfi.c: In function 'img_spfi_setup':
drivers/spi/spi-img-spfi.c:446: warning: 'ret' may be used
uninitialized in this function.

Fixes: commit b03ba9e314c1 ("spi: img-spfi: fix multiple calls to request gpio")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-img-spfi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index c253b2f798b4..823cbc92d1e7 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -444,7 +444,7 @@ static int img_spfi_unprepare(struct spi_master *master,
 
 static int img_spfi_setup(struct spi_device *spi)
 {
-	int ret;
+	int ret = -EINVAL;
 	struct img_spfi_device_data *spfi_data = spi_get_ctldata(spi);
 
 	if (!spfi_data) {
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
