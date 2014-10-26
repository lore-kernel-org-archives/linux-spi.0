From: V JobNickname <workofv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Does spi-gpio and bitband support 3-wire Bidirectional most/miso
 share pin usage?
Date: Sun, 26 Oct 2014 15:29:10 +0800
Message-ID: <CANHbGWuE5zm859woR3HcBo3XS2q_zw1xTRj7e6K6pUgo3dyiKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I have a device use 3-wire spi which are CS,SCK,and a DATA for
read/write.( maybe a.s.k.a SISO)
The command format like as p.18 in

www.newhavendisplay.com/app_notes/NV3035C.pdf

The spi-gpio can't register miso and mosi for same GPIO pin.
Also I traced SPI-3WIRE flag it seems only support half 3-wire which
only write or only read but share ping

Does current driver can support this kind of 3wire spi format? Or I
need to do some modify to support this 3-wire spi
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
