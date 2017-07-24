From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>
Subject: [PATCH] spi: core: use gpio_request_one for configured gpio cs
Date: Mon, 24 Jul 2017 11:53:27 +0200
Message-ID: <20170724095327.18602-1-mnhu@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some gpio controllers requires lines to be configured as outputs to make
subsequent calls to `gpio_set_value()` have any effect.

Add a call to `gpio_request_one()` for configured gpio chip-selects to
make it work on (at least) mvebu gpio controllers.

Signed-off-by: Martin Hundebøll <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>
---
 drivers/spi/spi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0725c78b0de6..b7bfc52525aa 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2010,8 +2010,13 @@ static int of_spi_register_master(struct spi_controller *ctlr)
 	for (i = 0; i < ctlr->num_chipselect; i++)
 		cs[i] = -ENOENT;
 
-	for (i = 0; i < nb; i++)
+	for (i = 0; i < nb; i++) {
 		cs[i] = of_get_named_gpio(np, "cs-gpios", i);
+		if (gpio_is_valid(cs[i]) &&
+		    gpio_request_one(cs[i], 0, "spi-cs") < 0)
+			dev_warn(&master->dev,
+				 "gpio_request_one failed for chipselect %i\n", i);
+	}
 
 	return 0;
 }
-- 
2.13.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
