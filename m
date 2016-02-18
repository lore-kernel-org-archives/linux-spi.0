From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 1/2] spi: docbook: fix parsing error
Date: Thu, 18 Feb 2016 15:53:10 +0000
Message-ID: <1455810791-3669-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Fixes docbook parsing error because documentation
is not directly followed by the structure, but typedef
used in structure.

Reordering should solve that issue.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 include/linux/spi/spi.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ceac606..520a23d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -604,6 +604,10 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
  * SPI resource management while processing a SPI message
  */
 
+typedef void (*spi_res_release_t)(struct spi_master *master,
+				  struct spi_message *msg,
+				  void *res);
+
 /**
  * struct spi_res - spi resource management structure
  * @entry:   list entry
@@ -613,9 +617,6 @@ extern struct spi_master *spi_busnum_to_master(u16 busnum);
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
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
