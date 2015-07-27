From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] spi: img-spfi: check for timeout error before proceeding
Date: Mon, 27 Jul 2015 13:11:15 +0100
Message-ID: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	"Stable kernel (v4.1)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Calling spfi_wait_all_done is not required if the transfer has timed
out before all data is transferred.

spfi_wait_all_done polls for Alldone interrupt which is triggered to
mark the transfer as complete and to indicate it is now safe to issue
a new transfer.

Fixes: 8c2c8c0 ("spi: img-spfi: Control CS lines with GPIO")
Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: Stable kernel (v4.1) <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
---
 drivers/spi/spi-img-spfi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 00f1ac3..f27d9d5 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -267,15 +267,15 @@ static int img_spfi_start_pio(struct spi_master *master,
 		cpu_relax();
 	}
 
-	ret = spfi_wait_all_done(spfi);
-	if (ret < 0)
-		return ret;
-
 	if (rx_bytes > 0 || tx_bytes > 0) {
 		dev_err(spfi->dev, "PIO transfer timed out\n");
 		return -ETIMEDOUT;
 	}
 
+	ret = spfi_wait_all_done(spfi);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
