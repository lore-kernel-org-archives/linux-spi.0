From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: core: Use %zu for printing 'size_t' type" to the spi tree
Date: Wed, 17 Feb 2016 19:18:29 +0000
Message-ID: <E1aW7cL-0002p5-37@debutante>
References: <1455722424-15490-1-git-send-email-fabio.estevam@nxp.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455722424-15490-1-git-send-email-fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: core: Use %zu for printing 'size_t' type

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

>From 7d62f51e74c62afc79f63c70ae48f1b8de57f5d4 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Date: Wed, 17 Feb 2016 15:42:27 -0200
Subject: [PATCH] spi: core: Use %zu for printing 'size_t' type

Use %zu for printing 'size_t' type in order to fix the following
build warning on ARM64:

drivers/spi/spi.c: In function '__spi_split_transfer_maxsize':
drivers/spi/spi.c:2278:2: warning: format '%i' expects argument of type 'int', but argument 4 has type 'size_t' [-Wformat=]

Signed-off-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Acked-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9490273ed811..9ae199db171b 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2254,7 +2254,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
 
 	/* warn once about this fact that we are splitting a transfer */
 	dev_warn_once(&msg->spi->dev,
-		      "spi_transfer of length %i exceed max length of %i - needed to split transfers\n",
+		      "spi_transfer of length %i exceed max length of %zu - needed to split transfers\n",
 		      xfer->len, maxsize);
 
 	/* calculate how many we have to replace */
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
