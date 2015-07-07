From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: zynq: missing break statement" to the spi tree
Date: Tue, 07 Jul 2015 19:48:29 +0100
Message-ID: <E1ZCXuv-0001wA-Ox@debutante>
References: <20150624143133.GE1702@mwanda>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150624143133.GE1702@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: zynq: missing break statement

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 861a481c5ede75bf31bc118f1f7f6d1f420182b5 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Date: Wed, 24 Jun 2015 17:31:33 +0300
Subject: [PATCH] spi: zynq: missing break statement

There is a missing break statement here so selecting both only selects
upper.

Fixes: dfe11a11d523 ('spi: Add support for Zynq Ultrascale+ MPSoC GQSPI controller')
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Acked-by: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 87b20a511a6b..f23f36ebaf3d 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -214,6 +214,7 @@ static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
 	case GQSPI_SELECT_FLASH_CS_BOTH:
 		instanceptr->genfifocs = GQSPI_GENFIFO_CS_LOWER |
 			GQSPI_GENFIFO_CS_UPPER;
+		break;
 	case GQSPI_SELECT_FLASH_CS_UPPER:
 		instanceptr->genfifocs = GQSPI_GENFIFO_CS_UPPER;
 		break;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
