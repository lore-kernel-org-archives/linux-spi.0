From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: fsl-spi: fix incomplete return statement
Date: Thu, 04 Dec 2014 19:17:17 +0100
Message-ID: <5480A52D.8010204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fixes an incomplete return statement after fsl_spi_do_one_msg was changed
to return an int and removes an unused variable assignment.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-fsl-spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index e24a9bf..60c5907 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -368,10 +368,9 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		if ((first->bits_per_word != t->bits_per_word) ||
 			(first->speed_hz != t->speed_hz)) {
-			status = -EINVAL;
 			dev_err(&spi->dev,
 				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
-			return;
+			return -EINVAL;
 		}
 	}
 
-- 
2.1.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
