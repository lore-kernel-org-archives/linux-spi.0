From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [patch] spi: checking for NULL instead of IS_ERR
Date: Fri, 12 Feb 2016 09:38:33 +0300
Message-ID: <20160212063833.GB22756@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi_replace_transfers() returns error pointers on error, it never
returns NULL.

Fixes: d9f121227281 ('spi: core: add spi_split_transfers_maxsize')
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1413a6b..d459adc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2284,8 +2284,8 @@ int __spi_split_transfer_maxsize(struct spi_master *master,
 
 	/* create replacement */
 	srt = spi_replace_transfers(msg, xfer, 1, count, NULL, 0, gfp);
-	if (!srt)
-		return -ENOMEM;
+	if (IS_ERR(srt))
+		return PTR_ERR(srt);
 	xfers = srt->inserted_transfers;
 
 	/* now handle each of those newly inserted spi_transfers
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
