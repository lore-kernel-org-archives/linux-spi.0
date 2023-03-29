Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C076C6FD18
	for <linux-spi@archiver.kernel.org>; Wed, 29 Mar 2023 06:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjC2GY6 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 29 Mar 2023 02:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2GY5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Mar 2023 02:24:57 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740DF10A;
        Tue, 28 Mar 2023 23:24:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VevlojM_1680071091;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VevlojM_1680071091)
          by smtp.aliyun-inc.com;
          Wed, 29 Mar 2023 14:24:51 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org, tudor.ambarus@linaro.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next v2] spi: rockchip-sfc: Use devm_platform_ioremap_resource()
Date:   Wed, 29 Mar 2023 14:24:50 +0800
Message-Id: <20230329062450.58924-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_ioremap_resource(), as this is exactly what this
function does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

change in v2:
--According to Tudor's suggestion, use devm_platform_ioremap_resource() and
  get rid of the local variable too.

 drivers/spi/spi-rockchip-sfc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 4fabd2e0439f..b370aade11b4 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -558,7 +558,6 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct spi_master *master;
-	struct resource *res;
 	struct rockchip_sfc *sfc;
 	int ret;
 
@@ -576,8 +575,7 @@ static int rockchip_sfc_probe(struct platform_device *pdev)
 	sfc = spi_master_get_devdata(master);
 	sfc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sfc->regbase = devm_ioremap_resource(dev, res);
+	sfc->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sfc->regbase))
 		return PTR_ERR(sfc->regbase);
 
-- 
2.20.1.7.g153144c

