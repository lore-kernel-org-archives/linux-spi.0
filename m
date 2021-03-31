Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832CBC433C1
	for <linux-spi@archiver.kernel.org>; Wed, 31 Mar 2021 00:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C50A61864
	for <linux-spi@archiver.kernel.org>; Wed, 31 Mar 2021 00:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhCaA6p (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 30 Mar 2021 20:58:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15829 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhCaA6O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 20:58:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F97D64K09z9tqV;
        Wed, 31 Mar 2021 08:56:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 31 Mar 2021 08:58:08 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <broonie@kernel.org>, <festevam@gmail.com>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH v3] spi: davinci: Use device_get_match_data() helper
Date:   Wed, 31 Mar 2021 08:58:39 +0800
Message-ID: <1617152319-17701-1-git-send-email-tiantao6@hisilicon.com>
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
Suggested-by: Fabio Estevam <festevam@gmail.com>
---
v2: Removed forced type conversions.

v3: Use the device_get_match_data() instead of of_the device_get_match_data()
and update the commit message and patch name.
---
 drivers/spi/spi-davinci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 7453a1d..e114e6fe 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -817,18 +817,13 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 			struct davinci_spi *dspi)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct davinci_spi_of_data *spi_data;
+	const struct davinci_spi_of_data *spi_data;
 	struct davinci_spi_platform_data *pdata;
 	unsigned int num_cs, intr_line = 0;
-	const struct of_device_id *match;
 
 	pdata = &dspi->pdata;
 
-	match = of_match_device(davinci_spi_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
-	spi_data = (struct davinci_spi_of_data *)match->data;
+	spi_data = device_get_match_data(&pdev->dev);
 
 	pdata->version = spi_data->version;
 	pdata->prescaler_limit = spi_data->prescaler_limit;
-- 
2.7.4

