From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Add gfp parameter to kernel-doc to fix build warning" to the spi tree
Date: Fri, 11 Mar 2016 14:25:20 +0700
Message-ID: <E1aeHRo-000317-P3@finisterre>
References: <1457632874-11250-3-git-send-email-javier@osg.samsung.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457632874-11250-3-git-send-email-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Add gfp parameter to kernel-doc to fix build warning

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

>From 10f11a2238d4d66e74438b629214b530a77db8e1 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Date: Thu, 10 Mar 2016 15:01:14 -0300
Subject: [PATCH] spi: Add gfp parameter to kernel-doc to fix build warning

The spi_split_transfers_maxsize() gfp parameter is missing in the
function kernel-doc so building gives the following warning:

.//drivers/spi/spi.c:2359: warning: No description found for parameter 'gfp'

Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 96c764d7efe6..c881493974d8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2319,6 +2319,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
  * @master:    the @spi_master for this transfer
  * @msg:   the @spi_message to transform
  * @maxsize:  the maximum when to apply this
+ * @gfp: GFP allocation flags
  *
  * Return: status of transformation
  */
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
