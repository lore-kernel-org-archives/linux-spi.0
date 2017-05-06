From: Geliang Tang <geliangtang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: spidev: use memdup_user
Date: Sat,  6 May 2017 23:42:17 +0800
Message-ID: <1028812604e64cd8e1ca2e25b119200fdbec2049.1493781496.git.geliangtang@gmail.com>
References: <df8091d4c64a0d5a7ab0a5989f34552a5eebd15e.1493778999.git.geliangtang@gmail.com>
Cc: Geliang Tang <geliangtang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <df8091d4c64a0d5a7ab0a5989f34552a5eebd15e.1493778999.git.geliangtang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use memdup_user() helper instead of open-coding to simplify the code.

Signed-off-by: Geliang Tang <geliangtang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spidev.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9a2a79a..b00a88f 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -325,7 +325,6 @@ static struct spi_ioc_transfer *
 spidev_get_ioc_message(unsigned int cmd, struct spi_ioc_transfer __user *u_ioc,
 		unsigned *n_ioc)
 {
-	struct spi_ioc_transfer	*ioc;
 	u32	tmp;
 
 	/* Check type, command number and direction */
@@ -342,14 +341,7 @@ spidev_get_ioc_message(unsigned int cmd, struct spi_ioc_transfer __user *u_ioc,
 		return NULL;
 
 	/* copy into scratch area */
-	ioc = kmalloc(tmp, GFP_KERNEL);
-	if (!ioc)
-		return ERR_PTR(-ENOMEM);
-	if (__copy_from_user(ioc, u_ioc, tmp)) {
-		kfree(ioc);
-		return ERR_PTR(-EFAULT);
-	}
-	return ioc;
+	return memdup_user(u_ioc, tmp);
 }
 
 static long
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
