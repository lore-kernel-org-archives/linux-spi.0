From: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: bitbang: Make setup_transfer callback optional
Date: Mon, 13 Apr 2015 12:08:05 +0200
Message-ID: <1428919685-14190-1-git-send-email-per.nilsson@xelmo.com>
References: <552B9045.4040709@xelmo.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <552B9045.4040709-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi-altera doesn't register this callback, and doesn't have a need for it,
but currently causes a NULL dereference when callback is called.
---
 drivers/spi/spi-bitbang.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 5ef6638..d02057d 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -180,7 +180,7 @@ int spi_bitbang_setup(struct spi_device *spi)
 {
 	struct spi_bitbang_cs	*cs = spi->controller_state;
 	struct spi_bitbang	*bitbang;
-	int			retval;
+	int			retval = 0;
 	unsigned long		flags;
 
 	bitbang = spi_master_get_devdata(spi->master);
@@ -197,7 +197,8 @@ int spi_bitbang_setup(struct spi_device *spi)
 	if (!cs->txrx_word)
 		return -EINVAL;
 
-	retval = bitbang->setup_transfer(spi, NULL);
+	if (bitbang->setup_transfer)
+		retval = bitbang->setup_transfer(spi, NULL);
 	if (retval < 0)
 		return retval;
 
@@ -295,9 +296,11 @@ static int spi_bitbang_transfer_one(struct spi_master *master,
 
 		/* init (-1) or override (1) transfer params */
 		if (do_setup != 0) {
-			status = bitbang->setup_transfer(spi, t);
-			if (status < 0)
-				break;
+			if (bitbang->setup_transfer) {
+				status = bitbang->setup_transfer(spi, t);
+				if (status < 0)
+					break;
+			}
 			if (do_setup == -1)
 				do_setup = 0;
 		}
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
