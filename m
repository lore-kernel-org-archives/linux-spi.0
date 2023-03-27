Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E26C77B61
	for <linux-spi@archiver.kernel.org>; Mon, 27 Mar 2023 06:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjC0GFX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 27 Mar 2023 02:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0GFX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Mar 2023 02:05:23 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F49420A;
        Sun, 26 Mar 2023 23:05:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Veh7Qp9_1679897117;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Veh7Qp9_1679897117)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 14:05:17 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/2] spi: sprd-adi: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 27 Mar 2023 14:05:15 +0800
Message-Id: <20230327060516.93509-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

According to commit 890cc39a8799 ("drivers: provide
devm_platform_get_and_ioremap_resource()"), convert
platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/spi/spi-sprd-adi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 3b158124d79f..22e39c4c12c4 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -541,8 +541,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, ctlr);
 	sadi = spi_controller_get_devdata(ctlr);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sadi->base = devm_ioremap_resource(&pdev->dev, res);
+	sadi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(sadi->base)) {
 		ret = PTR_ERR(sadi->base);
 		goto put_ctlr;
-- 
2.20.1.7.g153144c

