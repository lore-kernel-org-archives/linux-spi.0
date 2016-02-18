From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: docbook: fix parsing error" to the spi tree
Date: Thu, 18 Feb 2016 20:12:29 +0000
Message-ID: <E1aWUw9-0003lS-DO@debutante>
References: <1455810791-3669-1-git-send-email-kernel@martin.sperl.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455810791-3669-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: docbook: fix parsing error

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

>From d6497816836da321a46c0e8575c4fa3d0c672bda Mon Sep 17 00:00:00 2001
From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Date: Thu, 18 Feb 2016 15:53:10 +0000
Subject: [PATCH] spi: docbook: fix parsing error

Fixes docbook parsing error because documentation
is not directly followed by the structure, but typedef
used in structure.

Reordering should solve that issue.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 include/linux/spi/spi.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 38204b584dc5..5396ee5fc51f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -586,6 +586,10 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  * SPI resource management while processing a SPI message
  */
 
+typedef void (*spi_res_release_t)(struct spi_master *master,
+				  struct spi_message *msg,
+				  void *res);
+
 /**
  * struct spi_res - spi resource management structure
  * @entry:   list entry
@@ -595,9 +599,6 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  * this is based on ideas from devres, but focused on life-cycle
  * management during spi_message processing
  */
-typedef void (*spi_res_release_t)(struct spi_master *master,
-				  struct spi_message *msg,
-				  void *res);
 struct spi_res {
 	struct list_head        entry;
 	spi_res_release_t       release;
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
