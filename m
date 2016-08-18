From: Jonatan Magnusson <jonatan.magnusson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: omap2-mcspi, invalid SPI data received
Date: Thu, 18 Aug 2016 13:47:56 +0200
Message-ID: <B4201E8C-196E-47A9-8AD5-97109CE5A991@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, samuel.ortiz-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org,
	juha.yrjola-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi,

I have this problem that originally started when I tried to use an =
ENC28J60 device on a Beaglebone (Beaglebone Green Wireless). I noted =
that while reading one register on the device (EREVID) the value was =
0x3C. That register holds the hardware revision and should not be higher =
than 6 or possibly 7. So I started investigating the code and to make a =
long story short I ended up writing this silly loop that continuously =
reads and prints out EREVID:

for(;;) {
  printk(KERN_ALERT "REV: 0x%02x\n", nolock_regb_read(priv, EREVID));
}

It reports 0x3C every time so it=E2=80=99s not completely random. If I =
force the pin to 0V i get 0x00 instead, and 0xFF if I force the pin to =
3.3V. That should mean that the hardware config and pinmux is correct, =
since otherwise it would not change anything if I manipulate the pin.

With this loop active I could investigate what happens with a scope and =
to my surprise both the sent byte and the received byte are what to be =
expected: 0x12 and 0x06.  But somehow the SPI driver still reads 0x3C =
instead of 0x06.

Here=E2=80=99s two screenshots from the scope: =
https://dl.dropboxusercontent.com/u/176615/erevid.png

The first shows clock and mosi, the second clock and miso.

I=E2=80=99ve tried to track the error and got as far as =
drivers/spi/spi-omap2-mcspi.c, function omap2_mcspi_txrx_pio. Around =
line 715, readl_relaxed returns 0x3C.

Any ideas?


Best regards,
Jonatan Magnusson

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
