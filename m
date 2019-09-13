From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH 2/3] spi: dw: Add basic runtime PM support
Date: Fri, 13 Sep 2019 13:11:59 +0100
Message-ID: <1568376720-7402-3-git-send-email-gareth.williams.jx@renesas.com>
References: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568376720-7402-1-git-send-email-gareth.williams.jx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Phil Edworthy <phil.edworthy@renesas.com>

Enable runtime PM so that the clock used to access the registers in the
peripheral is turned on using a clock domain.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
---
 drivers/spi/spi-dw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9a49e07..593bbb0 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/delay.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 
@@ -497,6 +498,9 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	if (dws->set_cs)
 		master->set_cs = dws->set_cs;
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
 
-- 
2.7.4
