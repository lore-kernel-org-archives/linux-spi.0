From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 2/4] spi/bcm63xx: don't reject reads >= 256 bytes
Date: Tue, 17 Dec 2013 21:42:08 +0100
Message-ID: <1387312930-22436-3-git-send-email-jogo@openwrt.org>
References: <1387312930-22436-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387312930-22436-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The rx_tail register is only 8 bit wide, so it will wrap around
after 256 read bytes. This makes it rather meaningless, so drop any
usage of it to not treat reads over 256 as failed.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Acked-by: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 5693b4f..ae60731 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -203,13 +203,7 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 	if (!timeout)
 		return -ETIMEDOUT;
 
-	/* read out all data */
-	rx_tail = bcm_spi_readb(bs, SPI_RX_TAIL);
-
-	if (do_rx && rx_tail != len)
-		return -EIO;
-
-	if (!rx_tail)
+	if (!do_rx)
 		return 0;
 
 	len = 0;
-- 
1.8.5.1
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
