From: Michael Jones <michael.jones-P0pTl12WyEgpBod+wgzj8A@public.gmane.org>
Subject: does cs_change work in spi-dw.c?
Date: Tue, 12 Aug 2014 17:24:37 +0200
Message-ID: <53EA31B5.4010201@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

I'm using spi-dw.c via a userspace spidev device.  I'm doing an SPI read 
access via the ioctl SPI_IOC_MESSAGE().  I would like to execute two 
messages, with the chip select staying active between the two. If I 
understand correctly, this is what the member 'cs_change' in 'struct 
spi_ioc_transfer' is suppose to provide.  What I observe, though, is 
that the chip select deactivates between messages regardless of how I 
set 'cs_change'.

Can anybody confirm that they're able to use the cs_change switch with 
this driver?

I'm using an older kernel (3.10.31-LTSI), but I've browsed the more 
recent changes to this driver and didn't see anything that obviously 
effected this feature.

thanks,
Michael

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Uwe Furtner, Erhard Meier
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
