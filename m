From: Stefan Roese <sr@denx.de>
Subject: [PATCH 2/9 v3] staging: spi: mt7621: Clean up excessive header usage
Date: Fri,  1 Feb 2019 11:17:08 +0100
Message-ID: <20190201101715.3760-2-sr@denx.de>
References: <20190201101715.3760-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sankalp Negi <sankalpnegi2310@gmail.com>, Mark Brown <broonie@kernel.org>,
 John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>
To: linux-spi@vger.kernel.org,
	devel@driverdev.osuosl.org
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190201101715.3760-1-sr@denx.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org

This patch removes unnecessary header includes and sorts the remaining
ones alphabetically.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: NeilBrown <neil@brown.name>
Cc: Sankalp Negi <sankalpnegi2310@gmail.com>
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: John Crispin <john@phrozen.org>
---
v3:
- New patch, changes spilt into separate patches

 drivers/staging/mt7621-spi/spi-mt7621.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index c2f6f9ce52a2..440c3f77fde8 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -11,19 +11,13 @@
  *   Copyright (C) 2007-2008 Marvell Ltd.
  */
 
-#include <linux/init.h>
-#include <linux/module.h>
 #include <linux/clk.h>
-#include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
-#include <linux/of_device.h>
-#include <linux/platform_device.h>
-#include <linux/swab.h>
-
-#include <ralink_regs.h>
 
 #define SPI_BPW_MASK(bits) BIT((bits) - 1)
 
-- 
2.20.1
