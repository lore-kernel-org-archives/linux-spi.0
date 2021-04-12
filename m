Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DDAC43460
	for <linux-spi@archiver.kernel.org>; Mon, 12 Apr 2021 12:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F9B6121E
	for <linux-spi@archiver.kernel.org>; Mon, 12 Apr 2021 12:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240733AbhDLMBc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:01:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16448 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbhDLMBc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 12 Apr 2021 08:01:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FJnMP54yKzqTRb;
        Mon, 12 Apr 2021 19:58:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 20:01:05 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH v2 1/2] spi: hisi-sfc-v3xx: fix potential irq race condition
Date:   Mon, 12 Apr 2021 19:58:27 +0800
Message-ID: <1618228708-37949-2-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618228708-37949-1-git-send-email-yangyicong@hisilicon.com>
References: <1618228708-37949-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

We mask the irq when the command completion is timeout. This won't
stop the already running irq handler. Use sychronize_irq() after
we mask the irq, to make sure there is no running handler.

Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 385eb7b..0d9e103 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -342,6 +342,7 @@ static int hisi_sfc_v3xx_generic_exec_op(struct hisi_sfc_v3xx_host *host,
 			ret = 0;
 
 		hisi_sfc_v3xx_disable_int(host);
+		synchronize_irq(host->irq);
 		host->completion = NULL;
 	} else {
 		ret = hisi_sfc_v3xx_wait_cmd_idle(host);
-- 
2.8.1

