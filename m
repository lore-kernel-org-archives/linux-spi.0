From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 2/2] spi: docbook: add missing parameter documentation
Date: Thu, 18 Feb 2016 15:53:11 +0000
Message-ID: <1455810791-3669-2-git-send-email-kernel@martin.sperl.org>
References: <1455810791-3669-1-git-send-email-kernel@martin.sperl.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455810791-3669-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Add missing docbook documentation for the gfp parameter
in function spi_replace_transfers.

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f6c76be..6889c7f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2164,6 +2164,7 @@ static void __spi_replace_transfers_release(struct spi_master *master,
  * @release:       extra release code necessary in some circumstances
  * @extradatasize: extra data to allocate (with alignment guarantees
  *                 of struct @spi_transfer)
+ * @gfp:           gfp flags
  *
  * Returns: pointer to @spi_replaced_transfers,
  *          PTR_ERR(...) in case of errors.
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
