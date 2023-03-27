Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A53C761AF
	for <linux-spi@archiver.kernel.org>; Mon, 27 Mar 2023 06:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjC0GFZ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 27 Mar 2023 02:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjC0GFY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Mar 2023 02:05:24 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3194221;
        Sun, 26 Mar 2023 23:05:22 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Veh7QpZ_1679897119;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Veh7QpZ_1679897119)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 14:05:19 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 2/2] spi: sprd: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 27 Mar 2023 14:05:16 +0800
Message-Id: <20230327060516.93509-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20230327060516.93509-1-yang.lee@linux.alibaba.com>
References: <20230327060516.93509-1-yang.lee@linux.alibaba.com>
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
 drivers/spi/spi-sprd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 702acaeebab2..518c7eaca84e 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -929,8 +929,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ss = spi_controller_get_devdata(sctlr);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	ss->base = devm_ioremap_resource(&pdev->dev, res);
+	ss->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(ss->base)) {
 		ret = PTR_ERR(ss->base);
 		goto free_controller;
-- 
2.20.1.7.g153144c

