From: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] spi: spi-fsl-spi: Return an error code in fsl_spi_do_one_msg()
Date: Thu, 4 Dec 2014 11:15:47 -0200
Message-ID: <1417698947-4273-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since commit c592becbe704127 ("spi: fsl-(e)spi: migrate to generic master
queueing") the function fsl_spi_do_one_msg() is not void anymore, so return
an error code to avoid the following buid warning:

   drivers/spi/spi-fsl-spi.c: In function 'fsl_spi_do_one_msg':
>> drivers/spi/spi-fsl-spi.c:374:4: warning: 'return' with no value, in function returning non-void [-Wreturn-type]
       return;
       ^

Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> 
Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi-fsl-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index e24a9bf..83f8081 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -371,7 +371,7 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 			status = -EINVAL;
 			dev_err(&spi->dev,
 				"bits_per_word/speed_hz should be same for the same SPI transfer\n");
-			return;
+			return -EINVAL;
 		}
 	}
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
