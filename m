From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [RFC PATCH v2 07/12] spi: use gpio_desc instead of numeric gpio
Date: Fri, 28 Jul 2017 10:03:17 +1200
Message-ID: <20170727220322.26654-8-chris.packham@alliedtelesis.co.nz>
References: <20170727220322.26654-1-chris.packham@alliedtelesis.co.nz>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170727220322.26654-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

By using a gpio_desc and gpiod_set_value() instead of a numeric gpio and
gpio_set_value() the gpio flags are taken into account. This is useful
when using a gpio chip-select to supplement a controllers native
chip-select.

Signed-off-by: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
---

Notes:
    (I've included this in this series for context, ultimately it should not be
    needed once everything is using gpio_desc)
    
    My specific use-case is I have a board that uses the spi-orion driver but
    only has one CS pin available. In order to access two spi slave devices the
    board has a 1-of-2 decoder/demultiplexer which is driven via a gpio.
    
    The problem is that for one of the 2 slave devices the gpio level required
    is opposite to the chip-select so I can't simply specify "spi-cs-high".
    With this change I can flag the gpio as active low and the gpio subsystem
    takes care of the additional inversion required.

 drivers/spi/spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0725c78b0de6..918a53c884dd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -725,7 +725,10 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 		enable = !enable;
 
 	if (gpio_is_valid(spi->cs_gpio)) {
-		gpio_set_value(spi->cs_gpio, !enable);
+		struct gpio_desc *gpio = gpio_to_desc(spi->cs_gpio);
+
+		if (gpio)
+			gpiod_set_value(gpio, !enable);
 		/* Some SPI masters need both GPIO CS & slave_select */
 		if ((spi->controller->flags & SPI_MASTER_GPIO_SS) &&
 		    spi->controller->set_cs)
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
