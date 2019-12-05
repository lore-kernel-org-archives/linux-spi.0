From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] spi: dw: Avoid BUG_ON() in case of host failure
Date: Thu,  5 Dec 2019 17:14:21 -0600
Message-ID: <20191205231421.9333-1-pakki001@umn.edu>
Cc: kjlu@umn.edu, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: pakki001@umn.edu
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If dws is NULL in dw_spi_host_add(), we return the error to the
upper callers instead of crashing. The patch replaces BUG_ON by
returning -EINVAL to the caller.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5cd4fbe..a160d9a141ea 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -460,7 +460,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	struct spi_controller *master;
 	int ret;
 
-	BUG_ON(dws == NULL);
+	if (!dws)
+		return -EINVAL;
 
 	master = spi_alloc_master(dev, 0);
 	if (!master)
-- 
2.17.1
