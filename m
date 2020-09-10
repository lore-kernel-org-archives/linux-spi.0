Return-Path: <SRS0=JLJD=CT=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43FFC43461
	for <linux-spi@archiver.kernel.org>; Thu, 10 Sep 2020 10:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AF820BED
	for <linux-spi@archiver.kernel.org>; Thu, 10 Sep 2020 10:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgIJKFz (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:05:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729971AbgIJKFy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 10 Sep 2020 06:05:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7833CB3A85C709A2DE57;
        Thu, 10 Sep 2020 18:05:52 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.19) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Sep 2020 18:05:41 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <linux-spi@vger.kernel.org>, <broonie@kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH] spi: spi-qcom-qspi: replace spin_lock_irqsave by spin_lock in hard IRQ
Date:   Thu, 10 Sep 2020 22:02:46 +1200
Message-ID: <20200910100246.32696-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.19]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It is redundant to do irqsave and irqrestore in hardIRQ context.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/spi/spi-qcom-qspi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index b8857a97f40a..9a361de5e240 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -421,9 +421,8 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
 	u32 int_status;
 	struct qcom_qspi *ctrl = dev_id;
 	irqreturn_t ret = IRQ_NONE;
-	unsigned long flags;
 
-	spin_lock_irqsave(&ctrl->lock, flags);
+	spin_lock(&ctrl->lock);
 
 	int_status = readl(ctrl->base + MSTR_INT_STATUS);
 	writel(int_status, ctrl->base + MSTR_INT_STATUS);
@@ -451,7 +450,7 @@ static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
 		spi_finalize_current_transfer(dev_get_drvdata(ctrl->dev));
 	}
 
-	spin_unlock_irqrestore(&ctrl->lock, flags);
+	spin_unlock(&ctrl->lock);
 	return ret;
 }
 
-- 
2.25.1


