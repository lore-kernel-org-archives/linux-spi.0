From: "Lad, Prabhakar" <prabhakar.csengg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Suggestion Needed on Demuxer to Select Slave Devices
Date: Tue, 22 Aug 2017 12:06:55 +0100
Message-ID: <CA+V-a8tXatbmx4F0uHOjE6dMyb2n0gBVLpn3hjW-reT6gFykOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Folks,

I am writing a Linux SPI slave driver, on the latest kernel, and
wanted a suggestion on how the driver could fit in the latest kernel
with DT.

I have SPI controller which is connected to decoder [1], the SPI
controller has 2 chip selects, but only one (cs0) is connected to the
decoder.
The decoder has 8 slave devices connected to it, which can be can be
selected by gpios from the muxer.

Is there something existing in the drivers for such demuxers that I am missing.


[1] http://www.ti.com/lit/ds/symlink/sn74ahc138.pdf

Cheers,
--Prabhakar
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
