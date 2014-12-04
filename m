From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: fsl-spi: remove unused variable assignment
Date: Thu, 04 Dec 2014 20:28:11 +0100
Message-ID: <5480B5CB.9070503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Remove an unused variable assignment.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index 83f8081..60c5907 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -368,7 +368,6 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if ((first->bits_per_word != t->bits_per_word) ||
 			(first->speed_hz != t->speed_hz)) {
-			status = -EINVAL;
 			dev_err(&spi->dev,
 				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
 			return -EINVAL;
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
