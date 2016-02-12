From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: checking for NULL instead of IS_ERR" to the spi tree
Date: Fri, 12 Feb 2016 23:04:16 +0000
Message-ID: <E1aUMl6-0007Fq-Fb@debutante>
References: <20160212063833.GB22756@mwanda>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160212063833.GB22756@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: checking for NULL instead of IS_ERR

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

>From 657d32efe04197736ed328a34ba659b5172c8cce Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Date: Fri, 12 Feb 2016 09:38:33 +0300
Subject: [PATCH] spi: checking for NULL instead of IS_ERR

spi_replace_transfers() returns error pointers on error, it never
returns NULL.

Fixes: d9f121227281 ('spi: core: add spi_split_transfers_maxsize')
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 34e3741504f9..801e8900898b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2262,8 +2262,8 @@ int __spi_split_transfer_maxsize(struct spi_master *master,
 
 	/* create replacement */
 	srt = spi_replace_transfers(msg, xfer, 1, count, NULL, 0, gfp);
-	if (!srt)
-		return -ENOMEM;
+	if (IS_ERR(srt))
+		return PTR_ERR(srt);
 	xfers = srt->inserted_transfers;
 
 	/* now handle each of those newly inserted spi_transfers
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
