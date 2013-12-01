From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 1/2] spi/bcm63xx: don't substract prepend length from total length
Date: Sun,  1 Dec 2013 16:44:21 +0100
Message-ID: <1385912662-8261-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The spi command must include the full message length including any
prepended writes, else transfers larger than 256 bytes will be
incomplete.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 469ecd8..dceb7b2 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -169,8 +169,6 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 			       transfer_list);
 	}
 
-	len -= prepend_len;
-
 	init_completion(&bs->done);
 
 	/* Fill in the Message control register */
-- 
1.8.4.rc3
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
