From: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] spi: bitbang: Make setup_transfer() callback optional
Date: Tue, 14 Apr 2015 15:40:17 +0200
Message-ID: <1429018817-18117-1-git-send-email-per.nilsson@xelmo.com>
References: <1428919685-14190-1-git-send-email-per.nilsson@xelmo.com>
Cc: ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428919685-14190-1-git-send-email-per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some controller drivers have no need of this callback (spi-altera even
causes a NULL pointer dereference because it doesn't register the callback,
falsely assuming that it is already optional).

Fixes: 30af9b558a56 ("spi/bitbang: Drop empty setup() functions")
Signed-off-by: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-bitbang.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index 5ef6638..840a498 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -180,7 +180,6 @@ int spi_bitbang_setup(struct spi_device *spi)
 {
 	struct spi_bitbang_cs	*cs = spi->controller_state;
 	struct spi_bitbang	*bitbang;
-	int			retval;
 	unsigned long		flags;
 
 	bitbang = spi_master_get_devdata(spi->master);
@@ -197,9 +196,11 @@ int spi_bitbang_setup(struct spi_device *spi)
 	if (!cs->txrx_word)
 		return -EINVAL;
 
-	retval = bitbang->setup_transfer(spi, NULL);
-	if (retval < 0)
-		return retval;
+	if (bitbang->setup_transfer) {
+		int retval = bitbang->setup_transfer(spi, NULL);
+		if (retval < 0)
+			return retval;
+	}
 
 	dev_dbg(&spi->dev, "%s, %u nsec/bit\n", __func__, 2 * cs->nsecs);
 
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
