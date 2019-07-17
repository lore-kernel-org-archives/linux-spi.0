From: Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: [PATCH] spi: remove redundant put_device
Date: Wed, 17 Jul 2019 18:05:44 +0800
Message-ID: <1563357944-24496-1-git-send-email-dingxiang@cmss.chinamobile.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

device_unregister will call put_device,
so remove the redundant put_device

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/spi/spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 75ac046..d753689 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2133,11 +2133,9 @@ static ssize_t spi_slave_store(struct device *dev,
 		return -EINVAL;
 
 	child = device_find_child(&ctlr->dev, NULL, match_true);
-	if (child) {
+	if (child)
 		/* Remove registered slave */
 		device_unregister(child);
-		put_device(child);
-	}
 
 	if (strcmp(name, "(null)")) {
 		/* Register new slave */
-- 
1.9.1
