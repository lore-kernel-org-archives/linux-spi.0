From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev_test: Remove the whole "include" directory when make clean" to the spi tree
Date: Thu, 13 Feb 2020 13:32:26 +0000
Message-ID: <applied-1581567368-8055-4-git-send-email-yangtiezhu@loongson.cn>
References: <1581567368-8055-4-git-send-email-yangtiezhu@loongson.cn>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1581567368-8055-4-git-send-email-yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev_test: Remove the whole "include" directory when make clean

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

>From aea7afd9079f2e43b05790241d748ff0537ec917 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Date: Thu, 13 Feb 2020 12:16:08 +0800
Subject: [PATCH] spi: spidev_test: Remove the whole "include" directory when
 make clean

In the current code, it only removes "include/linux/spi/spidev.h" file
when make clean and there still exists useless "include/linux/spi/"
directory, just remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org>
Link: https://lore.kernel.org/r/1581567368-8055-4-git-send-email-yangtiezhu-cXZgJK919ebM1kAEIRd3EQ@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 tools/spi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index 5c342e655e55..2249a1546cc1 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -51,7 +51,7 @@ $(OUTPUT)spidev_fdx: $(SPIDEV_FDX_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	rm -f $(OUTPUT)include/linux/spi/spidev.h
+	rm -rf $(OUTPUT)include/
 	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
 
 install: $(ALL_PROGRAMS)
-- 
2.20.1
