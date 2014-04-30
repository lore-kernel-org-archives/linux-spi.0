From: maxim maxim <look2004il-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: MCSPI1_CS1 configuration
Date: Wed, 30 Apr 2014 21:48:41 +0300
Message-ID: <CAL22ZLJ0M0pUxAz9HwYcMU8xuT=JrAHvuRC8CUyFur0A--eVJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi guys,

I have some problem in OMAP3 uboot pin configuration of MCSPI1_CS1, my
configuration of this pin is in the following way in uboot:

MUX_VAL(CP(MCSPI1_CS1),        (IDIS | PTU | EN  | M0))



after configuration above, the  pin MCSPI1_CS1 (pin 175 in OMAP3)
becomes `0`, but I need it '1'.


My question is how to cause to the MCSPI1_CS1 still to be `1' after
configuration.



Best Regards,

Kol
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
