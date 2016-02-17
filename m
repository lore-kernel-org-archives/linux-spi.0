From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH v2 1/2] spi: core: Use %zu for printing 'size_t' type
Date: Wed, 17 Feb 2016 15:42:27 -0200
Message-ID: <1455730948-24938-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use %zu for printing 'size_t' type in order to fix the following
build warning on ARM64:

drivers/spi/spi.c: In function '__spi_split_transfer_maxsize':
drivers/spi/spi.c:2278:2: warning: format '%i' expects argument of type 'int', but argument 4 has type 'size_t' [-Wformat=]

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
Changes since v1:
- None

 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f6c76be..0725ffa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2276,7 +2276,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
 
 	/* warn once about this fact that we are splitting a transfer */
 	dev_warn_once(&msg->spi->dev,
-		      "spi_transfer of length %i exceed max length of %i - needed to split transfers\n",
+		      "spi_transfer of length %i exceed max length of %zu - needed to split transfers\n",
 		      xfer->len, maxsize);
 
 	/* calculate how many we have to replace */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
