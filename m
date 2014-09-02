From: "Tang, Feng" <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: does cs_change work in spi-dw.c?
Date: Tue, 2 Sep 2014 05:14:03 +0000
Message-ID: <A74E4C03C808B649AF1F11527F2D44140508E042@SHSMSX101.ccr.corp.intel.com>
References: <53EA31B5.4010201@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Wenxi Jin <jwenxi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Michael Jones <michael.jones-P0pTl12WyEgpBod+wgzj8A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53EA31B5.4010201-P0pTl12WyEgpBod+wgzj8A@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jones and Jin,

AFAIK, the dw-spi controller HW has a feature (so-called) that the CS
will be de-asserted when the TX FIFO is empty, if you use the chip
select register for CS.

So if you meet problem with the chip select stuff, there are 2 ways you
may try:
1. Try to keep the TX FIFO not empty
2. Use a dedicated extern GPIO based line for the chip select. 

There is already a "cs_control" hook in current spi-dw code, and you can
tweak your device's platform data to set the right cs_control. (btw: that
code is contributed by other developer, and myself haven't manually
tested that).

- Feng

> -----Original Message-----
> From: Michael Jones [mailto:michael.jones-P0pTl12WyEgpBod+wgzj8A@public.gmane.org]
> Sent: Tuesday, August 12, 2014 11:25 PM
> To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Tang, Feng
> Subject: does cs_change work in spi-dw.c?
> 
> Hello,
> 
> I'm using spi-dw.c via a userspace spidev device.  I'm doing an SPI read
> access via the ioctl SPI_IOC_MESSAGE().  I would like to execute two
> messages, with the chip select staying active between the two. If I
> understand correctly, this is what the member 'cs_change' in 'struct
> spi_ioc_transfer' is suppose to provide.  What I observe, though, is
> that the chip select deactivates between messages regardless of how I
> set 'cs_change'.
> 
> Can anybody confirm that they're able to use the cs_change switch with
> this driver?
> 
> I'm using an older kernel (3.10.31-LTSI), but I've browsed the more
> recent changes to this driver and didn't see anything that obviously
> effected this feature.
> 
> thanks,
> Michael
> 
> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
> Registergericht: Amtsgericht Stuttgart, HRB 271090
> Geschaeftsfuehrer: Uwe Furtner, Erhard Meier
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
