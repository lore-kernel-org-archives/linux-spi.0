From: maxim maxim <look2004il-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: init time between CS to data sending
Date: Sun, 30 Mar 2014 11:33:23 +0300
Message-ID: <CAL22ZLLzQcvMpq5v=UNwNn5WQpXBkfUU6rWEf_OYwet_SxwNoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,

I need to build spi driver fo NEO 6( ublox 6), my processor is OMAP2
(ARM architecture), I want to use with existing linux kernel
workaround for spi, for me OMAP2 is a master and GPS is a slave, I
want to send configuration message to the slave, in the data sheet of
the ublox 6 I saw that this device need some init time(= the time that
passed from activation of chip select to sending of data in MOSI). My
question is how I can set this time in existing kernel spi workaround
for spi driver?

Thanks,

Maxim
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
