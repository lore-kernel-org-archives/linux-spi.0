From: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/6] Enable DMA for daVinci SPI controller
Date: Fri, 17 Feb 2017 11:38:18 +0100
Message-ID: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Enable DMA for the daVinci SPI using the SPI framework DMA mapping
function. Add fixes caused by large numer of SG entries
and VIVT cache.
Also, add some extra options to the spi-loopback-test
module to catch errors caused by many SG entries.
This has been tested using spidev_test, spi-loopback-test and
mounting and read/write UBIFS volume over SPI flash.

v2 changes:
- Use SPI_MASTER_MUST_ flag(s) for dummy buffer allocation (thanks
Mark Brown).
- For rx-only transfers, use rx buffer as dummy tx buffer to avoid
errors with more than 20 SG entries.
- Improved comments and use #define for contants.
- Abandon patches to set loopback and limit transfer size in
spi-loopback-test.

Thanks,
Frode

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
