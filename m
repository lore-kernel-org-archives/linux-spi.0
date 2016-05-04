From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Fix simple typo s/impelment/implement" to the spi tree
Date: Wed, 04 May 2016 14:56:53 +0100
Message-ID: <E1axxIL-0001gN-5Q@debutante>
References: <1462301970-27235-1-git-send-email-moritz.fischer@ettus.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	moritz.fischer.private-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462301970-27235-1-git-send-email-moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Fix simple typo s/impelment/implement

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

>From 8ba811a7d2f0f86a37bd8aaaff35ce1004633430 Mon Sep 17 00:00:00 2001
From: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Date: Tue, 3 May 2016 11:59:30 -0700
Subject: [PATCH] spi: Fix simple typo s/impelment/implement

This fixes a simple typo in one of the comments.

Signed-off-by: Moritz Fischer <moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a50f880a5036..9e54d7bf3ec3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -935,7 +935,7 @@ static int spi_map_msg(struct spi_master *master, struct spi_message *msg)
  * spi_transfer_one_message - Default implementation of transfer_one_message()
  *
  * This is a standard implementation of transfer_one_message() for
- * drivers which impelment a transfer_one() operation.  It provides
+ * drivers which implement a transfer_one() operation.  It provides
  * standard handling of delays and chip select management.
  */
 static int spi_transfer_one_message(struct spi_master *master,
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
