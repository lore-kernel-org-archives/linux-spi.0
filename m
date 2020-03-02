From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: spidev: fix speed setting message" to the spi tree
Date: Mon, 02 Mar 2020 16:05:14 +0000
Message-ID: <applied-20200229161841.89144-3-oleksandr.suvorov@toradex.com>
References: <20200229161841.89144-3-oleksandr.suvorov@toradex.com>
Cc: Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Oleksandr Suvorov <cryosay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200229161841.89144-3-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: spidev: fix speed setting message

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 4276fc82fc5d1aa24c6ad1a16fbaccf11fa61e02 Mon Sep 17 00:00:00 2001
From: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Date: Sat, 29 Feb 2020 18:18:41 +0200
Subject: [PATCH] spi: spidev: fix speed setting message

The message of max device speed setting is shown when
an error in spi_setup() occurs.
Instead, it should be shown when the setup call succeeds.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Link: https://lore.kernel.org/r/20200229161841.89144-3-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spidev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index c97e853dbf5c..80dd1025b953 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -454,10 +454,11 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 			spi->max_speed_hz = tmp;
 			retval = spi_setup(spi);
-			if (retval >= 0)
+			if (retval == 0) {
 				spidev->speed_hz = tmp;
-			else
-				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
+				dev_dbg(&spi->dev, "%d Hz (max)\n",
+					spidev->speed_hz);
+			}
 			spi->max_speed_hz = save;
 		}
 		break;
-- 
2.20.1
