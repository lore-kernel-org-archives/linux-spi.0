From: maxim maxim <look2004il-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: mcspi
Date: Sat, 5 Apr 2014 16:05:20 +0300
Message-ID: <CAL22ZLJ7qe-=1iH0w1b+G10i9_ERFnFF2oRB7gOatk3k_AhdjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

 Hi guys,
 I'm working with omap 3 spi driver, in the base I have mcspi driver
for tach device(http://processors.wiki.ti.com/index.php/AM335x_McSPI_Driver's_Guide),
I want to add my insmod driver for ublox 6(gps device). From ublox6
datasheet I saw what I need some initial delay between chip select
activation and data sending, I didn't find a way how to do it from
Linux SPI Framework, because of this I tried to write directly to some
registers what mapped in mcspi driver I can accept their mapped
address from contoller_data , but unfortunately it didn't work, may be
here you could give me some avices how I can do it.

Thanks ,
Kol
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
