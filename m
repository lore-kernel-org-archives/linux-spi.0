From: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Subject: fsl-espi, m25p80 and max_transfer_size / max_message_size
Date: Mon, 14 Nov 2016 15:22:59 +0100
Message-ID: <17913d2dea0200f818af5f42a0b2ed42@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

since commit 02a595d5d6e4 (spi: fsl-espi: eliminate spi nor flash read 
loop) the fsl-espi is (partly?) broken. Reading 64k from the flash 
results in the following error:
   fsl_espi ffe110000.spi: message too long, size is 65540 bytes
   spi_master spi32766: failed to transfer one message from queue

We are using the m25p80 driver which checks the max_transfer_size. The 
fsl-espi driver sets the max_message_size to 64k. As far as I understand 
it, a message can contain multiple transfers. The m25p80 uses two 
transfers (one 4 byte and one with max_transfer_size, that is 64k) and 
thus the message has a total length of 65540 bytes which is too long for 
the driver.

I didn't find where the max_message_size is checked and I also don't 
know which part is resposible to handle the correct sizes. The m25p80 
driver? Should it use spi_max_message_size() instead of 
spi_max_transfer_size() ?

For example:
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -172,7 +172,7 @@ static ssize_t m25p80_read(struct spi_nor *nor, 
loff_t from, size_t len,

         t[1].rx_buf = buf;
         t[1].rx_nbits = m25p80_rx_nbits(nor);
-       t[1].len = min(len, spi_max_transfer_size(spi) - t[0].len);
+       t[1].len = min(len, spi_max_message_size(spi) - t[0].len);
         spi_message_add_tail(&t[1], &m);

         ret = spi_sync(spi, &m);

-michael
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
