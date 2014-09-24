From: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] spi: Fix possible ZERO_SIZE_PTR pointer dereferencing error.
Date: Wed, 24 Sep 2014 14:30:29 +0800
Message-ID: <1411540229-24915-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Since we cannot make sure the 'n' will always be none zero here, and
then if either equal to zero, the kzalloc() will return ZERO_SIZE_PTR,
which equals to ((void *)16).

So this patch fix this with just doing the zero check before calling
kzalloc().

Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/spi/spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 95cfe3b..e19512f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -552,6 +552,9 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 	struct boardinfo *bi;
 	int i;
 
+	if (!n)
+		return -EINVAL;
+
 	bi = kzalloc(n * sizeof(*bi), GFP_KERNEL);
 	if (!bi)
 		return -ENOMEM;
-- 
2.1.0.27.g96db324

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
