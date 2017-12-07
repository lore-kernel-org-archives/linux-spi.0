From: Takuo Koguchi <takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi: jcore: disable clock when registering spi conroller  failed When probe function fails in registering the spi controller, the clock should remain disabled.
Date: Thu,  7 Dec 2017 19:03:47 +0900
Message-ID: <1512641032-5848-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khoroshilov-ufN2psIa012HXe+LvDLADg@public.gmane.org,
        takuo.koguchi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw-FCd8Q96Dh0JBDgjK7y7TUQ@public.gmane.org>
---
 Compiled test only, no runtime test done.
 
 drivers/spi/spi-jcore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index cebfea5..dafed62 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -198,8 +198,10 @@ static int jcore_spi_probe(struct platform_device *pdev)
 
 	/* Register our spi controller */
 	err = devm_spi_register_master(&pdev->dev, master);
-	if (err)
+	if (err) {
+		clk_disable(clk);
 		goto exit;
+	}
 
 	return 0;
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
