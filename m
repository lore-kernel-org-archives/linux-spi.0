Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F4C001DE
	for <linux-spi@archiver.kernel.org>; Wed,  2 Aug 2023 09:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbjHBJo4 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 2 Aug 2023 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHBJoz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Aug 2023 05:44:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630FB1BFD
        for <linux-spi@vger.kernel.org>; Wed,  2 Aug 2023 02:44:39 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RG6Vb3w52z1GDFG;
        Wed,  2 Aug 2023 17:43:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 17:44:37 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <broonie@kernel.org>, <michal.simek@amd.com>,
        <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] spi: spi-zynq: Do not check for 0 return after calling platform_get_irq()
Date:   Wed, 2 Aug 2023 17:43:57 +0800
Message-ID: <20230802094357.981100-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It is not possible for platform_get_irq() to return 0. Use the
return value from platform_get_irq().

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/spi/spi-zynq-qspi.c    | 4 ++--
 drivers/spi/spi-zynqmp-gqspi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index ee1995b91287..0db69a2a72ff 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -679,8 +679,8 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	}
 
 	xqspi->irq = platform_get_irq(pdev, 0);
-	if (xqspi->irq <= 0) {
-		ret = -ENXIO;
+	if (xqspi->irq < 0) {
+		ret = xqspi->irq;
 		goto clk_dis_all;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index ed23c15cf7d8..9a46b2478f4e 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1293,8 +1293,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	zynqmp_qspi_init_hw(xqspi);
 
 	xqspi->irq = platform_get_irq(pdev, 0);
-	if (xqspi->irq <= 0) {
-		ret = -ENXIO;
+	if (xqspi->irq < 0) {
+		ret = xqspi->irq;
 		goto clk_dis_all;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynqmp_qspi_irq,
-- 
2.34.1

