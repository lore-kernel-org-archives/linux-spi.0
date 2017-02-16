From: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: [PATCH 0/7] spi: spi-ep93xx: cleanup and update driver to modern API
Date: Thu, 16 Feb 2017 16:48:44 -0700
Message-ID: <20170216234851.97938-1-hsweeten@visionengravers.com>
Cc: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Cleanup and update this driver to use the default master transfer queueing
mechanism provided by the core.

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
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
