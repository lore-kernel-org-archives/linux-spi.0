From: Andrey Smirnov <andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RFC, PATCH] Add support for long SPI transfers
Date: Mon, 24 Nov 2014 09:50:22 -0800
Message-ID: <1416851423-1902-1-git-send-email-andrew.smirnov@gmail.com>
Cc: andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yurovsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

This patch is a very first, very preliminary version of the feature I
am implementing for niche usecase of SPI in a system I am working
on. It by no means contains production code and is purely RFC to "test
the water" and see if there would be any interest in including this in
mainline tree.

The system I am working with implements a lion's share of its
functionality in an extrenal FPGA connected to an ARM SoC via SPI
bus. In my use-case SPI bus used both for initial bitfile programming
of the FPGA and sending/fetching data to/from FPGA as well. Both use
cases, can benefit greatly from ability to send very long bit streams
over SPI as a single transaction during which CS line stays low the
whole time. The use-case of programming the FPGA is the most important
for me, since it is mandatory to program the FPGA before the rest of
the system can proceed to a functioning state and therefore my
"Applied power -> Functional State" time is greatly influenced by that
operation.

As things are right now both SPI subsystem and SPIDEV driver are
limited by their APIs to SPI transactions that are no longer than 255
bits and that problem is exacerbated by the fact that transction
length validity verification code does not have provisions for
anything bigger than 32 bits.

The code in this RFC deals only with the first problem, as I am not
sure what would best way to tackle the second one.

So I guess my two maing questions for this RFC are the following:

 - Is this work seem like a good fit to be included in the mainline
   kernel, or should I just keep doing it as my system specifica hack
   and not bother with upsteaming?

 - If the idea is good for upstreaming what would be a good way to
   improve length checking code? I was thinking of ditching the
   bitmask in favour of driver provided function that would take
   transfer length as an argument, are there any better options?

Thank you.

Andrey Smirnov

Andrey Smirnov (1):
  spi, spidev: Add support for long SPI transfers

 drivers/spi/spidev.c            | 7 ++++++-
 include/linux/spi/spi.h         | 4 ++--
 include/uapi/linux/spi/spidev.h | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
1.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
