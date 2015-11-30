From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: tools: move spidev_test metadata" to the spi tree
Date: Mon, 30 Nov 2015 12:25:45 +0000
Message-ID: <E1a3NWb-0003W0-F9@debutante>
References: <1448746103-9809-1-git-send-email-stillcompiling@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448746103-9809-1-git-send-email-stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: tools: move spidev_test metadata

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

>From de2c6e58554c7df3db70c68e52f982e558895ecf Mon Sep 17 00:00:00 2001
From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sat, 28 Nov 2015 13:28:18 -0800
Subject: [PATCH] spi: tools: move spidev_test metadata

Now that spidev_test and spidev_fdx have been moved, remove them
from the Documentation index and move their .gitignore file.

Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/spi/00-INDEX              | 4 ----
 {Documentation => tools}/spi/.gitignore | 0
 2 files changed, 4 deletions(-)
 rename {Documentation => tools}/spi/.gitignore (100%)

diff --git a/Documentation/spi/00-INDEX b/Documentation/spi/00-INDEX
index a128fa835512..4644bf0d9832 100644
--- a/Documentation/spi/00-INDEX
+++ b/Documentation/spi/00-INDEX
@@ -10,13 +10,9 @@ pxa2xx
 	- PXA2xx SPI master controller build by spi_message fifo wq
 spidev
 	- Intro to the userspace API for spi devices
-spidev_fdx.c
-	- spidev example file
 spi-lm70llp
 	- Connecting an LM70-LLP sensor to the kernel via the SPI subsys.
 spi-sc18is602
 	- NXP SC18IS602/603 I2C-bus to SPI bridge
 spi-summary
 	- (Linux) SPI overview. If unsure about SPI or SPI in Linux, start here.
-spidev_test.c
-	- SPI testing utility.
diff --git a/Documentation/spi/.gitignore b/tools/spi/.gitignore
similarity index 100%
rename from Documentation/spi/.gitignore
rename to tools/spi/.gitignore
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
