Return-Path: <SRS0=zI59=EM=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D03FC388F7
	for <linux-spi@archiver.kernel.org>; Fri,  6 Nov 2020 01:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E165D20759
	for <linux-spi@archiver.kernel.org>; Fri,  6 Nov 2020 01:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgKFBNm (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 5 Nov 2020 20:13:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7595 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732396AbgKFBNm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 20:13:42 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CS2TB1r5pzLsn7;
        Fri,  6 Nov 2020 09:13:34 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 09:13:37 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>
CC:     <kernel@pengutronix.de>, <linux-imx@nxp.com>, <festevam@gmail.com>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: mxs: fix reference leak in mxs_spi_probe
Date:   Fri, 6 Nov 2020 09:24:21 +0800
Message-ID: <20201106012421.95420-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to pm_runtime_put_noidle will result in
reference leak in mxs_spi_probe, so we should fix it.

Fixes: b7969caf41a1d ("spi: mxs: implement runtime pm")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-mxs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 918918a9e049..435309b09227 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -607,6 +607,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(ssp->dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(ssp->dev);
 		dev_err(ssp->dev, "runtime_get_sync failed\n");
 		goto out_pm_runtime_disable;
 	}
-- 
2.17.1

