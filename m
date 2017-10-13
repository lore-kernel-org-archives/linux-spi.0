From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers" to the spi tree
Date: Fri, 13 Oct 2017 18:22:52 +0100
Message-ID: <E1e33fg-0002WT-Po@debutante>
References: <20171013155946.1486-1-l.stach@pengutronix.de>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        patchwork-lst-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171013155946.1486-1-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers

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

>From 9ce70d49fa80b95a029c16432270f4edbbd2a953 Mon Sep 17 00:00:00 2001
From: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Fri, 13 Oct 2017 17:59:46 +0200
Subject: [PATCH] spi: fix IDR collision on systems with both fixed and dynamic
 SPI bus numbers

On systems where some controllers get a dynamic ID assigned and some have
a fixed number from DT, the current implemention might run into an IDR
collision if the dynamic controllers gets probed first and get an IDR number,
which is later requested by the controller with the fixed numbering. When
this happens the fixed controller will fail to register with the SPI core.

Fix this by skipping all known alias numbers when assigning the dynamic IDs.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
Signed-off-by: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6e65524cbfd9..0483410e7cb3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -45,7 +45,6 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/spi.h>
-#define SPI_DYN_FIRST_BUS_NUM 0
 
 static DEFINE_IDR(spi_master_idr);
 
@@ -2117,8 +2116,9 @@ int spi_register_controller(struct spi_controller *ctlr)
 	}
 	if (ctlr->bus_num < 0) {
 		mutex_lock(&board_lock);
-		id = idr_alloc(&spi_master_idr, ctlr, SPI_DYN_FIRST_BUS_NUM, 0,
-			       GFP_KERNEL);
+		id = idr_alloc(&spi_master_idr, ctlr,
+			       of_alias_get_highest_id("spi") + 1,
+			       0, GFP_KERNEL);
 		mutex_unlock(&board_lock);
 		if (WARN(id < 0, "couldn't get idr"))
 			return id;
-- 
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
