Return-Path: <SRS0=yiGS=CS=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630D8C433E2
	for <linux-spi@archiver.kernel.org>; Wed,  9 Sep 2020 06:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A05208FE
	for <linux-spi@archiver.kernel.org>; Wed,  9 Sep 2020 06:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgIIGKv (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:10:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11273 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbgIIGKv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 02:10:51 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2709069676AC6DE7B2DB;
        Wed,  9 Sep 2020 14:10:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Sep 2020 14:10:42 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <huangdaode@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH] spi: spidev: Remove redundant initialization of variable status
Date:   Wed, 9 Sep 2020 14:08:24 +0800
Message-ID: <1599631704-53232-1-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In spidev_read() and spidev_write(), the variable status is being
initialized with a value that is never read and it is being updated
later with a new value. The initialization is redundant and can be
removed.

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spidev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 455e99c..859910e 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -146,7 +146,7 @@ static ssize_t
 spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
 {
 	struct spidev_data	*spidev;
-	ssize_t			status = 0;
+	ssize_t			status;
 
 	/* chipselect only toggles at start or end of operation */
 	if (count > bufsiz)
@@ -176,7 +176,7 @@ spidev_write(struct file *filp, const char __user *buf,
 		size_t count, loff_t *f_pos)
 {
 	struct spidev_data	*spidev;
-	ssize_t			status = 0;
+	ssize_t			status;
 	unsigned long		missing;
 
 	/* chipselect only toggles at start or end of operation */
-- 
2.7.4

