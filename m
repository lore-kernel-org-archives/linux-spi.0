Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B348EC4742C
	for <linux-spi@archiver.kernel.org>; Mon, 16 Nov 2020 14:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E7821527
	for <linux-spi@archiver.kernel.org>; Mon, 16 Nov 2020 14:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgKPOHE (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 16 Nov 2020 09:07:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7631 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbgKPOHD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 16 Nov 2020 09:07:03 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZW8k0zwkz15Kmv;
        Mon, 16 Nov 2020 22:06:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Nov 2020
 22:06:52 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <broonie@kernel.org>, <p.zabel@pengutronix.de>,
        <tudor.ambarus@microchip.com>,
        <vadivel.muruganx.ramuthevar@linux.intel.com>, <vigneshr@ti.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] spi: cadence-quadspi: Fix error return code in cqspi_probe
Date:   Mon, 16 Nov 2020 22:10:14 +0800
Message-ID: <20201116141014.2364260-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix to return the error code from
devm_reset_control_get_optional_exclusive() instaed of 0
in cqspi_probe().

Fixes: 31fb632b5d43ca ("spi: Move cadence-quadspi driver to drivers/spi/")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 40938cf3806d..22d7158edb71 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1260,12 +1260,14 @@ static int cqspi_probe(struct platform_device *pdev)
 	/* Obtain QSPI reset control */
 	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
 	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
 		dev_err(dev, "Cannot get QSPI reset.\n");
 		goto probe_reset_failed;
 	}
 
 	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
 	if (IS_ERR(rstc_ocp)) {
+		ret = PTR_ERR(rstc);
 		dev_err(dev, "Cannot get QSPI OCP reset.\n");
 		goto probe_reset_failed;
 	}
-- 
2.25.4

