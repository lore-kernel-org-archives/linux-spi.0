From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 0/2]  Added support for spi-nor device pm in m25p80
Date: Fri, 10 Feb 2017 16:49:27 -0500
Message-ID: <1486763369-31969-1-git-send-email-kdasu.kdev@gmail.com>
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
        marex-ynQEQJNshbs@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The V3 changes below implements power management support in m25p80 driver.
m25p80 pm resume() calls newly a implemented spi_nor_init() function
that sets up the spi-nor flash to its probed state. This is needed on
platfroms that turn off power to the spi-nor flash on pm suspend.
The code has been rebased to git://github.com/spi-nor/linux.git next
branch.

Kamal Dasu (2):
  mtd: spi-nor: Added spi-nor reset function
  mtd: m25p80: Added pm ops support

 drivers/mtd/devices/m25p80.c  | 16 ++++++++++
 drivers/mtd/spi-nor/spi-nor.c | 72 +++++++++++++++++++++++++++----------------
 include/linux/mtd/spi-nor.h   | 21 ++++++++++++-
 3 files changed, 81 insertions(+), 28 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
