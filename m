From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 0/5] Added support for spi-nor device pm in m25p80
Date: Fri,  3 Feb 2017 18:31:11 -0500
Message-ID: <1486164676-12912-1-git-send-email-kdasu.kdev@gmail.com>
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
        marex-ynQEQJNshbs@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The changes below implements power management support in m25p80.
m25p80 pm resume() calls newly a implemented spi_nor_pm_rescan()
function that sets up the spi-nor flash to its probed state. 
This is needed on platfroms that turn off power to the spi-nor
part on suspend, in such cases some parts might need to: 
1. remove flash protection (if applicable)
2. set the address width and/or
3. set the read mode to quad mode depending on the probed configuration

The changes use existing spi-nor framework by refactoring code a bit so
that it can be reused in scan and rescan functions. Changes also ensures
that for platforms that do not need pm support shall not be affected. 

Kamal Dasu (5):
  mtd: spi-nor: Added way to rescan spi-nor device
  mtd: m25p80: Added pm ops support
  spi: Added way to check for pm support for flash devices
  mtd: m25p80: Check if the spi flash device has pm support
  spi: bcm-qspi: Implement the master flash_pm_supported() call

 drivers/mtd/devices/m25p80.c  | 21 ++++++++++
 drivers/mtd/spi-nor/spi-nor.c | 93 +++++++++++++++++++++++++++++++++++++------
 drivers/spi/spi-bcm-qspi.c    |  6 +++
 include/linux/mtd/spi-nor.h   | 17 ++++++++
 include/linux/spi/spi.h       |  8 ++++
 5 files changed, 133 insertions(+), 12 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
