From: root <alex-eB7nCxF232ATle0oOhCeeA@public.gmane.org>
Subject: SPI device sniffing/mirror feature
Date: Sat, 16 Jul 2016 15:27:39 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1607161525430.10952@Test5>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi everyone,

I'm dealing with an embedded Linux, where an application opens the 
/dev/spidev1.0 device and constantly talks through with another MCU.
Now if I I try to look at what exchanges (that's what I'd need), doing
a hexdump /dev/spidev1.0 shows something in the beginning but causes 
the application to crash. The app is very sensitive and I think it crashes 
because the app uses and it can't be used for viewing simultaneously.

Would there be a way to create an alias, or something like a mirror of 
this device if I write some extra code/driver? Or is there no chance for 
me to sniff the traffic like that (in software) ?

Many thanks in advance!
Alex

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
