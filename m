From: Frode Isaksen <fisaksen@baylibre.com>
Subject: [PATCH] spi: loopback-test: fix compile error on x86
Date: Fri, 17 Mar 2017 12:07:58 +0100
Message-ID: <1489748878-15020-1-git-send-email-fisaksen@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Frode Isaksen <fisaksen@baylibre.com>, broonie@kernel.org,
 linux-spi@vger.kernel.org
To: nsekhar@ti.com, khilman@baylibre.com, ptitiano@baylibre.com,
 linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Fix compile error caused by missing vmalloc() definition
on x86 (and maybe other platforms) by including vmalloc.h.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 drivers/spi/spi-loopback-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
index 3596051..4e7843e 100644
--- a/drivers/spi/spi-loopback-test.c
+++ b/drivers/spi/spi-loopback-test.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/printk.h>
+#include <linux/vmalloc.h>
 #include <linux/spi/spi.h>
 
 #include "spi-test.h"
-- 
2.7.4
