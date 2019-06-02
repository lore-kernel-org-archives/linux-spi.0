From: Vivek Pernamitta <pervivek@gmail.com>
Subject: [PATCH] spi: spidev: Fix for reverting spi max speed value only on failure
Date: Sun,  2 Jun 2019 19:49:59 +0530
Message-ID: <20190602141959.5616-1-pervivek@gmail.com>
Cc: pervivek@gmail.com, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When user space application request for change in spi clock
using ioctl, current value is taken back-up and new value is
assigned to spi->max_speed_hz, then spi_setup() function is
called with new value. If spi_setup() function fails, it needs
reverting to old spi_max_speed value only in failure condition.

Signed-off-by: Vivek Pernamitta <pervivek@gmail.com>
---
 drivers/spi/spidev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 30498cf25f3b..70382b642f37 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -458,9 +458,10 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			retval = spi_setup(spi);
 			if (retval >= 0)
 				spidev->speed_hz = tmp;
-			else
+			else {
 				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
-			spi->max_speed_hz = save;
+				spi->max_speed_hz = save;
+			}
 		}
 		break;
 
-- 
2.17.1
