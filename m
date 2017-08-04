From: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Subject: [PATCH v2 0/7] spi: spi-ep93xx: cleanup and update driver to modern API
Date: Fri,  4 Aug 2017 12:00:16 +1200
Message-ID: <20170804000023.15624-1-chris.packham@alliedtelesis.co.nz>
Cc: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Cleanup and update this driver to use the default master transfer queueing
mechanism provided by the core.

I've been carrying these changes locally to use as a basis for other SPI work.
Mark Brown pointed out that he's simply missed seeing it, Andy Shevchenko had
some minor comment's which I've now addressed. I'm just re-sending this on
Hartley Sweeten's behalf.

H Hartley Sweeten (7):
  spi: spi-ep93xx: remove io wrappers
  spi: spi-ep93xx: use 32-bit read/write for all registers
  spi: spi-ep93xx: add spi master prepare_transfer_hardware()
  spi: spi-ep93xx: absorb the interrupt enable/disable helpers
  spi: spi-ep93xx: pass the spi_master pointer around
  spi: spi-ep93xx: remove private data 'current_msg'
  spi: spi-ep93xx: use the default master transfer queueing mechanism

 drivers/spi/spi-ep93xx.c | 501 +++++++++++++++++------------------------------
 1 file changed, 177 insertions(+), 324 deletions(-)

-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
