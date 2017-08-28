From: Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/2] SPI NOR - force 3byte addressing mode
Date: Mon, 28 Aug 2017 23:14:12 +0200
Message-ID: <1503954854-30963-1-git-send-email-mw@semihalf.com>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org,
        cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
        neta-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, hannah-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
        mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, jaz-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

This very short patchset introduces optional forcing via DT
3byte addressing mode for accessing the SPI flash, whose
size exceeds 16MiB.

It can be used in case the device does not support
SPI_NOR_4B_OPCODES and helps overcome an issue, when
the Boot ROM cannot handle non-default settings
that could be enabled in the kernel and remain after soft reset.

I'm looking forward to any comments or remarks.

Best regards,
Marcin

Marcin Wojtas (2):
  mtd: spi-nor: add an option to force 3byte adressing mode
  arm64: dts: marvell: Force 3byte addressing mode for SPI on A7040 DB

 Documentation/devicetree/bindings/spi/spi-bus.txt |  2 ++
 arch/arm64/boot/dts/marvell/armada-7040-db.dts    |  1 +
 drivers/mtd/spi-nor/spi-nor.c                     | 12 +++++++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
