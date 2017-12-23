From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH v3 02/27] spi: replace devm_ioremap_nocache with devm_ioremap
Date: Sat, 23 Dec 2017 18:56:42 +0800
Message-ID: <1514026602-32680-1-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <ysxie@foxmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
To: <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Default ioremap is ioremap_nocache, so devm_ioremap has the same
function with devm_ioremap_nocache, which can just be killed to
save the size of devres.o.

This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
which should not have any function change but prepare for killing
devm_ioremap_nocache.

Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/spi/spi-jcore.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index cebfea5..32f538e 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -169,8 +169,7 @@ static int jcore_spi_probe(struct platform_device *pdev)
 	if (!devm_request_mem_region(&pdev->dev, res->start,
 				     resource_size(res), pdev->name))
 		goto exit_busy;
-	hw->base = devm_ioremap_nocache(&pdev->dev, res->start,
-					resource_size(res));
+	hw->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!hw->base)
 		goto exit_busy;
 
-- 
1.8.3.1
