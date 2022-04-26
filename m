Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE27C433F5
	for <linux-spi@archiver.kernel.org>; Tue, 26 Apr 2022 08:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiDZIwQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346322AbiDZIot (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Apr 2022 04:44:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C0887A9
        for <linux-spi@vger.kernel.org>; Tue, 26 Apr 2022 01:34:36 -0700 (PDT)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KnZtQ3dB2zhYpM;
        Tue, 26 Apr 2022 16:34:22 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 16:34:34 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 16:34:34 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: sh-msiof: Fix potential NULL dereference in sh_msiof_request_dma
Date:   Tue, 26 Apr 2022 16:36:35 +0800
Message-ID: <20220426083635.112852-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

platform_get_resource() may return NULL, add proper check to
avoid potential NULL dereferencing.

Fixes: b0d0ce8b6b91a ("spi: sh-msiof: Add DMA support")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/spi/spi-sh-msiof.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index d0012b30410c..9d2754cc72b4 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1191,6 +1191,9 @@ static int sh_msiof_request_dma(struct sh_msiof_spi_priv *p)
 	if (!res)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
+	if (!res)
+		return -ENOENT;
+
 	ctlr = p->ctlr;
 	ctlr->dma_tx = sh_msiof_request_dma_chan(dev, DMA_MEM_TO_DEV,
 						 dma_tx_id, res->start + SITFDR);
-- 
2.17.1

