From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Handling vmalloc'd buffers in spi-nor
Date: Tue, 21 Feb 2017 14:07:08 +0530
Message-ID: <8cf1d1d9-38a1-cbef-9a9b-07d2ecf2727f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
        Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
        Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,

I have come across couple of problems[1] when using m25p80 driver with
SPI flash over SPI bus with DMA. Basically filesystems like UBIFS may
pass vmalloc'd buffers to SPI NOR layer which will end up in SPI layer.
SPI core does try to handle such buffers (see spi_map_buf()) by doing
vmalloc_to_page() and creating scatterlist.
But, its known that this does not work well with VIVT/aliasing cache
architectures.
This also fails when buffers are addressed using LPAE (buffers in region
higher than 32 bit addressable region), if DMA is 32bit only.

IMO, it would be better if vmalloc'd buffers are handled in SPI NOR
layer, just like nand, instead of passing them onto SPI layer.
In order to deal with vmalloc'd buffers passed by higher layers (like
UBIFS), I propose to use pre-allocated per flash bounce buffer equal to
the sector size of the flash. This feature can be enabled using a flag
similar to NAND_USE_BOUNCE_BUFFER. The changes will be mostly restricted
to spi_nor_read/write functions. This will help SPI drivers to use DMA
with NOR flashes with filesystems.

This would also enable other SPI NOR drivers to safely use DMA in their
read/write callbacks.

Any thoughts/comments?

Thanks!

[1]https://www.spinics.net/lists/arm-kernel/msg563773.html

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
