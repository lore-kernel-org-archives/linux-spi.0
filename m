From: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] spi: spidev: fix speed setting message
Date: Sat, 29 Feb 2020 18:18:41 +0200
Message-ID: <20200229161841.89144-3-oleksandr.suvorov@toradex.com>
References: <20200229161841.89144-1-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Oleksandr Suvorov <cryosay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200229161841.89144-1-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The message of max device speed setting is shown when
an error in spi_setup() occurs.
Instead, it should be shown when the setup call succeeds.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
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
2.24.1
