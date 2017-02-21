From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/bcm63xx: fix typo in bcm63xx_spi_max_length breaking compilation
Date: Wed, 22 Feb 2017 00:30:40 +0100
Message-ID: <20170221233040.24241-1-jonas.gorski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Fix compilation by renaming argument dev to spi as expected by the code.

Fixes the following error:

drivers/spi/spi-bcm63xx.c: In function ‘bcm63xx_spi_max_length’:
drivers/spi/spi-bcm63xx.c:434:50: error: ‘spi’ undeclared (first use in this function)
  struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
                                                  ^~~

Fixes: 0135c03df914 ("spi/bcm63xx: make spi subsystem aware of message size limits")
Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Oops, fixed it up in the wrong tree. And I forgot I can compile test it,
and can do compile tests directly.

Anyway, Done on top of topic/bcm63xx.

 drivers/spi/spi-bcm63xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 325131370941..247f71b02235 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -429,7 +429,7 @@ static irqreturn_t bcm63xx_spi_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static size_t bcm63xx_spi_max_length(struct spi_device *dev)
+static size_t bcm63xx_spi_max_length(struct spi_device *spi)
 {
 	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
