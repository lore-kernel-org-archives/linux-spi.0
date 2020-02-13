From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev_test: Remove break after exit statement" to the spi tree
Date: Thu, 13 Feb 2020 13:32:33 +0000
Message-ID: <applied-1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
References: <1581567368-8055-1-git-send-email-yangtiezhu@loongson.cn>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581567368-8055-1-git-send-email-yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev_test: Remove break after exit statement

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

>From 020bd6c48ebd864d42b5b551a87a323e443918a6 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Date: Thu, 13 Feb 2020 12:16:05 +0800
Subject: [PATCH] spi: spidev_test: Remove break after exit statement

When call print_usage() in parse_opts(), it will exit directly.
Since break is not useful after exit statement, remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Link: https://lore.kernel.org/r/1581567368-8055-1-git-send-email-yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 tools/spi/spidev_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 3559e7646256..113b1e1d62ca 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -283,7 +283,6 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		default:
 			print_usage(argv[0]);
-			break;
 		}
 	}
 	if (mode & SPI_LOOP) {
-- 
2.20.1
