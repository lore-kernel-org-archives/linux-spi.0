From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: spi: i.MX: Some cleanup patches
Date: Fri,  2 Jun 2017 07:37:58 +0200
Message-ID: <20170602053804.3238-1-s.hauer@pengutronix.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series contains some drive-by cleanup patches I came up with
while reviewing other patches for this driver, Jiada, please consider
basing your next round of patches on this when Mark signals he is
ok with this series.

Sascha

----------------------------------------------------------------
Sascha Hauer (6):
      spi: imx: Nothing to do in setupxfer when transfer is NULL
      spi: imx: Drop unnecessary check
      spi: imx: put struct spi_imx_config members into driver private struct
      spi: imx: drop bogus unnecessary dma config
      spi: imx: remove bytes_per_word from private driver struct
      spi: imx: rename 'bpw' variables

 drivers/spi/spi-imx.c | 86 ++++++++++++++++++++-------------------------------
 1 file changed, 33 insertions(+), 53 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
