From: Patryk Mezydlo <mezydlo.p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Slave mode for McSPI
Date: Thu, 28 Apr 2016 18:30:51 +0200
Message-ID: <20160428163051.GA1434@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi linux-spi developers,

My name is Patryk M=C4=99=C5=BCyd=C5=82o and I=E2=80=99m a student part=
icipating in GSOC 2016.

My project is to create SPI slave driver for McSPI controller. I would
like to have my code added to the mainline, so I'd like to ask about a
few details.

Implementation for master is located in spi-oma2-mcspi.c I could add a
patch which implements slave mode to spi-oma2-mcspi.c, but I think that
using a separate driver would allow it to be cleaner.

Moreover, I would like to place the implementation of the driver=E2=80=99=
s
higher level, which communicates with userspace, in the implementation
of the lower layer, which communicates with McSPI controller. Thanks to
this, I could create a compact driver enabling operation McSPI in slave
mode.

I would like to get some feedback about my idea. What is in your view
the best possible solution?

Thanks,

Patryk
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
