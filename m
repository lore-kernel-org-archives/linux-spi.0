From: Daniele Nicolodi <daniele-4Vzs6UKX4iGsTnJN9+BGXg@public.gmane.org>
Subject: spi-omap2: AM335x SPI interface 3WIRE mode
Date: Wed, 7 Jun 2017 17:01:16 -0600
Message-ID: <a5070efe-4ed7-b6e3-dd4a-95be963a63b2@grinta.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, samuel.ortiz-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org,
        juha.yrjola-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

I would like to interface a SoC system based on an AM335x processor (in
the specific a BeagleBone Black) to some peripherals speaking SPI in
3-wire mode.

Looking at the spi-omap2 driver code (kernel version 3.11.4), the 3WIRE
mode is not supported, but a comment in the code suggests that this may
be supported by the hardware. The TRM indeed reports that the the McSPI
in the AM335x processors supports 3-wire SPI.

Does anyone have the code to add 3-wire SPI mode support to the driver?

No?! I guess that would have been too much luck.  In that case, can
someone point me to what needs to be done to add this support to the
driver?  I may figure it out by myself, but a little guidance would
probably help to make it happen before I loose interest :-)

Thank you!  Best,
Daniele
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
