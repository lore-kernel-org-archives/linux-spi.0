Return-Path: <SRS0=2vyr=EJ=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D99C388F9
	for <linux-spi@archiver.kernel.org>; Tue,  3 Nov 2020 14:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A788422264
	for <linux-spi@archiver.kernel.org>; Tue,  3 Nov 2020 14:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgKCODH (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:03:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7043 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgKCODG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 09:03:06 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQWhR008GzhZqY;
        Tue,  3 Nov 2020 22:03:02 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 22:03:01 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>
CC:     <ldewangan@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: tegra20-slink: fix reference leak in slink ops of tegra20
Date:   Tue, 3 Nov 2020 22:13:45 +0800
Message-ID: <20201103141345.6188-1-zhangqilong3@huawei.com>
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
reference leak in two callers(tegra_slink_setup and
tegra_slink_resume), so we should fix it.

Fixes: dc4dc36056392 ("spi: tegra: add spi driver for SLINK controller")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-tegra20-slink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index a0810765d4e5..f7c832fd4003 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -751,6 +751,7 @@ static int tegra_slink_setup(struct spi_device *spi)
 
 	ret = pm_runtime_get_sync(tspi->dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(tspi->dev);
 		dev_err(tspi->dev, "pm runtime failed, e = %d\n", ret);
 		return ret;
 	}
@@ -1188,6 +1189,7 @@ static int tegra_slink_resume(struct device *dev)
 
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
 		dev_err(dev, "pm runtime failed, e = %d\n", ret);
 		return ret;
 	}
-- 
2.17.1

