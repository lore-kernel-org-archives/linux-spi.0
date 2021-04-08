Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEB1C433ED
	for <linux-spi@archiver.kernel.org>; Thu,  8 Apr 2021 00:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4348D61205
	for <linux-spi@archiver.kernel.org>; Thu,  8 Apr 2021 00:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhDHAzD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 7 Apr 2021 20:55:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16026 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhDHAzD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Apr 2021 20:55:03 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FG2lm6jLWzNtnp;
        Thu,  8 Apr 2021 08:52:04 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 08:54:42 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>,
        "Yicong Yang" <yangyicong@hisilicon.com>
Subject: [PATCH] spi: simplify devm_spi_register_controller
Date:   Thu, 8 Apr 2021 08:55:07 +0800
Message-ID: <1617843307-53853-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2fe3c3a..b1419a3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2793,9 +2793,9 @@ int spi_register_controller(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_register_controller);
 
-static void devm_spi_unregister(struct device *dev, void *res)
+static void devm_spi_unregister(void *ctlr)
 {
-	spi_unregister_controller(*(struct spi_controller **)res);
+	spi_unregister_controller(ctlr);
 }
 
 /**
@@ -2814,22 +2814,13 @@ static void devm_spi_unregister(struct device *dev, void *res)
 int devm_spi_register_controller(struct device *dev,
 				 struct spi_controller *ctlr)
 {
-	struct spi_controller **ptr;
 	int ret;
 
-	ptr = devres_alloc(devm_spi_unregister, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
 	ret = spi_register_controller(ctlr);
-	if (!ret) {
-		*ptr = ctlr;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return devm_add_action_or_reset(dev, devm_spi_unregister, ctlr);
 }
 EXPORT_SYMBOL_GPL(devm_spi_register_controller);
 
-- 
2.7.4

