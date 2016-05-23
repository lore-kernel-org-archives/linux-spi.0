From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Add file patterns for spi device tree bindings" to the spi tree
Date: Mon, 23 May 2016 18:51:02 +0100
Message-ID: <E1b4u0M-0006nC-EE@debutante>
References: <1463907991-7916-45-git-send-email-geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463907991-7916-45-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Add file patterns for spi device tree bindings

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

>From c876fec76e3719734f8a055b799c8c4c1930fcfc Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 22 May 2016 11:06:21 +0200
Subject: [PATCH] spi: Add file patterns for spi device tree bindings

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c567a431d8d..3aaea9f66eae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10511,6 +10511,7 @@ L:	linux-spi@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 Q:	http://patchwork.kernel.org/project/spi-devel-general/list/
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/
 F:	Documentation/spi/
 F:	drivers/spi/
 F:	include/linux/spi/
-- 
2.8.1
