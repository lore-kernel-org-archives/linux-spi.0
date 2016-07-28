From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH -next] spi: pic32-sqi: use list_move_tail and list_move
Date: Thu, 28 Jul 2016 16:19:47 +0000
Message-ID: <1469722787-15413-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Using list_move_tail() and list_move() to simplify the code.

Signed-off-by: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-pic32-sqi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index c41abdd..bd1c6b5 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -253,15 +253,13 @@ static struct ring_desc *ring_desc_get(struct pic32_sqi *sqi)
 		return NULL;
 
 	rdesc = list_first_entry(&sqi->bd_list_free, struct ring_desc, list);
-	list_del(&rdesc->list);
-	list_add_tail(&rdesc->list, &sqi->bd_list_used);
+	list_move_tail(&rdesc->list, &sqi->bd_list_used);
 	return rdesc;
 }
 
 static void ring_desc_put(struct pic32_sqi *sqi, struct ring_desc *rdesc)
 {
-	list_del(&rdesc->list);
-	list_add(&rdesc->list, &sqi->bd_list_free);
+	list_move(&rdesc->list, &sqi->bd_list_free);
 }
 
 static int pic32_sqi_one_transfer(struct pic32_sqi *sqi,



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
