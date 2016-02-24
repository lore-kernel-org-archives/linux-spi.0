From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: make xmldocs warning caused by spi.c" to the spi tree
Date: Wed, 24 Feb 2016 12:54:47 +0900
Message-ID: <E1aYQXH-0008RJ-2r@finisterre>
References: <1456140824-15744-1-git-send-email-standby24x7@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456140824-15744-1-git-send-email-standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: make xmldocs warning caused by spi.c

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

>From 3700ce951c405f748a4767cabe6ac65727cbf767 Mon Sep 17 00:00:00 2001
From: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 22 Feb 2016 20:33:44 +0900
Subject: [PATCH] spi: make xmldocs warning caused by spi.c

This patch fix following warnings while make xmldocs.

.//drivers/spi/spi.c:2354: warning: Excess function parameter
'message' description in 'spi_split_transfers_maxsize'
.//drivers/spi/spi.c:2354: warning: Excess function parameter
 'max_size' description in 'spi_split_transfers_maxsize'

Signed-off-by: Masanari Iida <standby24x7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b0c5d45641ec..96c764d7efe6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2317,8 +2317,8 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
  *                              when an individual transfer exceeds a
  *                              certain size
  * @master:    the @spi_master for this transfer
- * @message:   the @spi_message to transform
- * @max_size:  the maximum when to apply this
+ * @msg:   the @spi_message to transform
+ * @maxsize:  the maximum when to apply this
  *
  * Return: status of transformation
  */
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
