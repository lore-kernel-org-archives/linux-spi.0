From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Subject: [PATCH v2 0/2] spi: bcm2835aux: auxiliary spi improvements
Date: Sun, 14 Feb 2016 11:04:27 +0100
Message-ID: <1455444269-4797-1-git-send-email-stephanolbrich@gmx.de>
Cc: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>

This patch series has some improvements and fixes for the auxiliary spi.

since v1:
- the first two patches "fix bitmask defines" and "disable tx fifo empty irq"
  were picked up by Mark Brown and applied to his spi tree so I don't post
  them again.
- speed bits are now reset before setting the new speed in case the speed
  changes between transfers
- remove CPHA from master->mode_bits
- rename CPHA bit mask to RISING to make it more clear why things are done
  that way

1. set up spi-mode before asserting cs-gpio
 As Martin Sperl suggested this is done in the same way as in spi-bcm2835.c
 acace73df2c1913a526c1b41e4741a4a6704c863

2. fix CPOL/CPHA setting
 From what I've seen in the documentation [1] and seen on the scope this chip
 doesn't support modes with CPHA=1. With this patch spi mode 0 and 2 should
 work correctly whereas mode 1 and 3 are not supported. 
                                                                                                                                                                                                            
Stephan Olbrich (2):
  spi: bcm2835aux: set up spi-mode before asserting cs-gpio
  spi: bcm2835aux: fix CPOL/CPHA setting

 drivers/spi/spi-bcm2835aux.c | 66 +++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 22 deletions(-)

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
