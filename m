Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218CEC77B6D
	for <linux-spi@archiver.kernel.org>; Mon, 27 Mar 2023 05:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC0FyC (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 27 Mar 2023 01:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjC0Fxy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Mar 2023 01:53:54 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA42420F;
        Sun, 26 Mar 2023 22:53:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VefjAra_1679896427;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VefjAra_1679896427)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 13:53:47 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next 1/3] spi: omap2-mcspi: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 27 Mar 2023 13:53:44 +0800
Message-Id: <20230327055346.76625-1-yang.lee@linux.alibaba.com>
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
 drivers/spi/spi-omap2-mcspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d95f0ae033ca..8331e247bf5c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1477,8 +1477,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		master->max_transfer_size = omap2_mcspi_max_xfer_size;
 	}
 
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mcspi->base = devm_ioremap_resource(&pdev->dev, r);
+	mcspi->base = devm_platform_get_and_ioremap_resource(pdev, 0, &r);
 	if (IS_ERR(mcspi->base)) {
 		status = PTR_ERR(mcspi->base);
 		goto free_master;
-- 
2.20.1.7.g153144c

