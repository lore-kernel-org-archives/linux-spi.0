From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH] spi: sc18is602: Support multiple devices on a single I2C bus if DT is configured
Date: Fri,  6 Feb 2015 12:25:54 -0800
Message-ID: <1423254354-18846-1-git-send-email-linux@roeck-us.net>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The driver currently only supports a single device per I2C bus since it uses
the I2C bus number to set the SPI bus number. This makes it impossible to
connect more than one chip to a single I2C bus.

We don't want to use dynamic bus numbers unconditionally since this would
result in every instantiation getting a different bus number starting with
65,535 counting down unless devicetree is configured. If devicetree is
configured, however, the SPI bus number is obtained from devicetree
data. So we can use dynamic SPI bus numbers in this case.

Reported-and-Tested-by: Marco Menchise <marco.menchise-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
 drivers/spi/spi-sc18is602.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sc18is602.c b/drivers/spi/spi-sc18is602.c
index 237f2e7..c04e601 100644
--- a/drivers/spi/spi-sc18is602.c
+++ b/drivers/spi/spi-sc18is602.c
@@ -290,7 +290,7 @@ static int sc18is602_probe(struct i2c_client *client,
 			hw->freq = SC18IS602_CLOCK;
 		break;
 	}
-	master->bus_num = client->adapter->nr;
+	master->bus_num = np ? -1 : client->adapter->nr;
 	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
 	master->setup = sc18is602_setup;
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
