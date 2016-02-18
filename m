From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: Use %u for unsigned int, %zu for size_t
Date: Thu, 18 Feb 2016 14:32:57 +0100
Message-ID: <1455802378-17780-1-git-send-email-thierry.reding@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

When printing unsigned int it is more idiomatic to use %u, for size_t
the correct specifier is %zu (see Documentation/printk-formats.txt).

GCC only warns about the latter, but fixing up the former while at it
for consistency.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f6c76be39e96..f123f9f4d779 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2276,7 +2276,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
 
 	/* warn once about this fact that we are splitting a transfer */
 	dev_warn_once(&msg->spi->dev,
-		      "spi_transfer of length %i exceed max length of %i - needed to split transfers\n",
+		      "spi_transfer of length %u exceed max length of %zu - needed to split transfers\n",
 		      xfer->len, maxsize);
 
 	/* calculate how many we have to replace */
-- 
2.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
