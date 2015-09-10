From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 1/6] spi/bcm63xx: remove unused rx_tail variable
Date: Thu, 10 Sep 2015 16:11:39 +0200
Message-ID: <1441894304-22316-2-git-send-email-jogo@openwrt.org>
References: <1441894304-22316-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441894304-22316-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fixes the following warning:
drivers/spi/spi-bcm63xx.c:125:5: warning: unused variable 'rx_tail' [-Wunused-variable]
  u8 rx_tail;
     ^

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index e73e2b05..2b908db 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -122,7 +122,6 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, struct spi_transfer *first,
 	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
 	u16 msg_ctl;
 	u16 cmd;
-	u8 rx_tail;
 	unsigned int i, timeout = 0, prepend_len = 0, len = 0;
 	struct spi_transfer *t = first;
 	bool do_rx = false;
-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
