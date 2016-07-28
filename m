From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: pic32-sqi: use list_move_tail and list_move" to the spi tree
Date: Thu, 28 Jul 2016 20:56:56 +0100
Message-ID: <E1bSrQO-00039d-I9@debutante>
References: <1469722787-15413-1-git-send-email-weiyj.lk@gmail.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469722787-15413-1-git-send-email-weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: pic32-sqi: use list_move_tail and list_move

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 27d4b7dbf55c0b5f8cdf12b07401ebd7b41977d0 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Thu, 28 Jul 2016 16:19:47 +0000
Subject: [PATCH] spi: pic32-sqi: use list_move_tail and list_move

Using list_move_tail() and list_move() to simplify the code.

Signed-off-by: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-pic32-sqi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index c41abddab318..bd1c6b53283f 100644
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
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
