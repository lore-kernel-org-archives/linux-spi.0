From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: [PATCH v2 0/2] fsl: fsl-spi: Fix CMP1 pram allocation and allow dynamic allocation
Date: Fri,  3 Oct 2014 18:49:16 +0200 (CEST)
Message-ID: <20141003164916.BA7611AAFC7@localhost.localdomain>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patchset:
1) Fix parameter ram offset setup for CPM1
2) Allow dynamic allocation of CPM1 parameter RAM

Tested on MPC885.

Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>

---
Changes from v1 to v2: using OF compatible instead of compile time option

 drivers/spi/spi-fsl-cpm.c   | 12 +++++++-----
 drivers/spi/spi-fsl-lib.c   |  2 ++
 include/linux/fsl_devices.h |  1 +
 3 files changed, 10 insertions(+), 5 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
