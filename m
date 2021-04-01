Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857EEC433ED
	for <linux-spi@archiver.kernel.org>; Thu,  1 Apr 2021 06:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B73161055
	for <linux-spi@archiver.kernel.org>; Thu,  1 Apr 2021 06:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhDAGYc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:24:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15061 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhDAGY0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Apr 2021 02:24:26 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F9tPK1tB2zPnFj;
        Thu,  1 Apr 2021 14:21:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 14:24:18 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: orion: Use device_get_match_data() helper
Date:   Thu, 1 Apr 2021 14:24:48 +0800
Message-ID: <1617258288-1490-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use the device_get_match_data() helper instead of open coding.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/spi/spi-orion.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 68ed7fd..d02c5c9 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -634,7 +634,6 @@ MODULE_DEVICE_TABLE(of, orion_spi_of_match_table);
 
 static int orion_spi_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	const struct orion_spi_dev *devdata;
 	struct spi_master *master;
 	struct orion_spi *spi;
@@ -676,9 +675,8 @@ static int orion_spi_probe(struct platform_device *pdev)
 	spi->master = master;
 	spi->dev = &pdev->dev;
 
-	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
-	devdata = (of_id) ? of_id->data : &orion_spi_dev_data;
-	spi->devdata = devdata;
+	devdata = device_get_match_data(&pdev->dev);
+	spi->devdata = devdata ? devdata : &orion_spi_dev_data;
 
 	spi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
-- 
2.7.4

