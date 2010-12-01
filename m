From: Bernhard Walle <walle@corscience.de>
Subject: [PATCH] spi: spidev: Add 32 bit compat ioctl()
Date: Wed,  1 Dec 2010 11:51:14 +0100
Message-ID: <1291200674-25630-1-git-send-email-walle@corscience.de>
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: dbrownell@users.sourceforge.net, grant.likely@secretlab.ca
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add the compat_ioctl for operations on /dev/spi* so that 32 bit
userspace applications can access SPI. As far as I can see all data
structure are already prepared for that, so no additional conversion has
to be done.

My use case is MIPS with N32 userspace ABI and toolchain, and that was
also the platform where I tested it successfully (Cavium Octeon).

Signed-off-by: Bernhard Walle <walle@corscience.de>
---
 drivers/spi/spidev.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index ea1bec3..d3d1155 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -543,6 +543,7 @@ static const struct file_operations spidev_fops = {
 	.write =	spidev_write,
 	.read =		spidev_read,
 	.unlocked_ioctl = spidev_ioctl,
+	.compat_ioctl = spidev_ioctl,
 	.open =		spidev_open,
 	.release =	spidev_release,
 };
-- 
1.7.1
