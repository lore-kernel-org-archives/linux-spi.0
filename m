From: Ran Shalit <ranshalit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Unhandled fault: external abort on non-linefetch (0x1028)
Date: Sun, 17 Jul 2016 11:24:53 +0300
Message-ID: <CAJ2oMh+KWGMqW6dMqRYVt_Ri_Q13=RoG44vw5WbC32ZS8aiPjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

I am trying to understand how I can enable pm runtime with mcspi.
spi with omap is implemented only for 4-wire device, while we use 3-wire device.
So, I had to implement it myself.
I try to do some porting of code (instaed of modification in current
spi driver),

But - I keep getting exception when accsessing spi status register
(you can find the complete log below).

ioaddr = ioremap_nocache(0x4809A000, SZ_4K);
     *(( unsigned int*) (ioaddr+0)) = 0x12;
    val =  *(( unsigned int*) (ioaddr + 0x34));
printk("mymem 0x%x\n",val); <<--- exception when reading from 0x4809a034

using: omap3530, kernel 2.6.37, custom spi driver
Is there any idea what can be wrong here ?

Thanks,
Ran
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
