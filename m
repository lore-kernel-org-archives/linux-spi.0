From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Fix htmldocs build error due struct spi_replaced_transfers" to the spi tree
Date: Fri, 11 Mar 2016 14:25:23 +0700
Message-ID: <E1aeHRr-00031b-CD@finisterre>
References: <1457632874-11250-2-git-send-email-javier@osg.samsung.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457632874-11250-2-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Fix htmldocs build error due struct spi_replaced_transfers

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

>From c76d9ae415f1a80489a76ea41620c3f17383b7fb Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Date: Thu, 10 Mar 2016 15:01:13 -0300
Subject: [PATCH] spi: Fix htmldocs build error due struct
 spi_replaced_transfers

The kernel-doc has to be just before the structure definition but the one
for struct spi_replaced_transfers was before a structure declaration and
that confuses kernel-doc which complains with the following build error:

.//include/linux/spi/spi.h:933: error: Cannot parse struct or union!

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 3c02b4d06268..1fc33db4347f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -898,6 +898,10 @@ spi_max_transfer_size(struct spi_device *spi)
 
 /* SPI transfer replacement methods which make use of spi_res */
 
+struct spi_replaced_transfers;
+typedef void (*spi_replaced_release_t)(struct spi_master *master,
+				       struct spi_message *msg,
+				       struct spi_replaced_transfers *res);
 /**
  * struct spi_replaced_transfers - structure describing the spi_transfer
  *                                 replacements that have occurred
@@ -917,10 +921,6 @@ spi_max_transfer_size(struct spi_device *spi)
  * if some extra allocation is requested, so alignment will be the same
  * as for spi_transfers
  */
-struct spi_replaced_transfers;
-typedef void (*spi_replaced_release_t)(struct spi_master *master,
-				       struct spi_message *msg,
-				       struct spi_replaced_transfers *res);
 struct spi_replaced_transfers {
 	spi_replaced_release_t release;
 	void *extradata;
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
