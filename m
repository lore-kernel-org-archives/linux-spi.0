From: stephanolbrich-Mmb7MZpHnFY@public.gmane.org
Subject: [PATCH 0/4] spi: bcm2835aux: auxiliary spi improvements
Date: Tue,  9 Feb 2016 19:10:31 +0100
Message-ID: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
Cc: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>

This patch series has some improvements and fixes for the auxiliary spi.

1. fix bitmask defines
 just fixes a typo (needed in 2.)

2. disable tx fifo empty irq
 reduces the numer of interrupts with nothing to do

3. set up spi-mode before asserting cs-gpio
 As Martin Sperl suggested this is done in the same way as in spi-bcm2835.c
 acace73df2c1913a526c1b41e4741a4a6704c863

4. fix CPOL/CPHA setting
 From what I've seen in the documentation [1] and seen on the scope this chip
 doesn't support modes with CPHA=1. With this patch spi mode 0 and 2 should
 work correctly whereas mode 1 and 3 do not. 

[1] https://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Stephan Olbrich (4):
  spi: bcm2835aux: fix bitmask defines
  spi: bcm2835aux: disable tx fifo empty irq
  spi: bcm2835aux: set up spi-mode before asserting cs-gpio
  spi: bcm2835aux: fix CPOL/CPHA setting

 drivers/spi/spi-bcm2835aux.c | 64 +++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 18 deletions(-)

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
