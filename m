From: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 0/6] Enable DMA for daVinci SPI controller
Date: Thu, 23 Feb 2017 19:01:55 +0100
Message-ID: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Enable DMA for the daVinci SPI using the SPI framework DMA mapping
function. 
Add fixes caused by large number of SG entries.
Do not allow vmalloc'ed buffers for DMA.
Also, add some extra options to the spi-loopback-test
module to catch errors caused by many SG entries
and VIVT cache.
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

v3 changes:
- Disable DMA for vmalloc'ed buffers.
- Reworked 'can_dma' function.
- Add option to skip a check in spi-loopback-test to catch VIVT
cache errors.

Thanks,
Frode


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
