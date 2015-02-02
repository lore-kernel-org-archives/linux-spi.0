From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH 1/5] spi: match var type to return type of wait_for_completion
Date: Mon,  2 Feb 2015 03:30:32 -0500
Message-ID: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>

return type of wait_for_completion_timeout is unsigned long not int, this
patch changes the type of m from int to unsigned long.

Signed-off-by: Nicholas Mc Guire <der.herr-kA1LtwSENNE@public.gmane.org>
---

The return type of wait_for_completion_timeout is unsigned long not
int. This patch resolves the type missmatch by changing the type
to unsigned long.

This patch was only compile tested with x86_64_defconfig + CONFIG_SPI=y

Patch is against 3.19.0-rc6 -next-20150130

 drivers/spi/spi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b9fb711..c64a3e5 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -784,7 +784,7 @@ static int spi_transfer_one_message(struct spi_master *master,
 	struct spi_transfer *xfer;
 	bool keep_cs = false;
 	int ret = 0;
-	int ms = 1;
+	unsigned long ms = 1;
 
 	spi_set_cs(msg->spi, true);
 
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
