Return-Path: <SRS0=jmqa=6N=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37503C83003
	for <linux-spi@archiver.kernel.org>; Wed, 29 Apr 2020 07:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5D62076B
	for <linux-spi@archiver.kernel.org>; Wed, 29 Apr 2020 07:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgD2H5x (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:57:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbgD2H5x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Apr 2020 03:57:53 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C0607939E7E81C5643B7;
        Wed, 29 Apr 2020 15:57:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Apr 2020 15:57:41 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] spi: uniphier: fix error return code in uniphier_spi_probe()
Date:   Wed, 29 Apr 2020 07:58:55 +0000
Message-ID: <20200429075855.104487-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix to return negative error code -EPROBE_DEFER from the DMA probe defer
error handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/spi-uniphier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 0fa50979644d..0457d3376873 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -716,8 +716,10 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	master->dma_tx = dma_request_chan(&pdev->dev, "tx");
 	if (IS_ERR_OR_NULL(master->dma_tx)) {
-		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER)
+		if (PTR_ERR(master->dma_tx) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
 			goto out_disable_clk;
+		}
 		master->dma_tx = NULL;
 		dma_tx_burst = INT_MAX;
 	} else {
@@ -732,8 +734,10 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	master->dma_rx = dma_request_chan(&pdev->dev, "rx");
 	if (IS_ERR_OR_NULL(master->dma_rx)) {
-		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER)
+		if (PTR_ERR(master->dma_rx) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
 			goto out_disable_clk;
+		}
 		master->dma_rx = NULL;
 		dma_rx_burst = INT_MAX;
 	} else {



