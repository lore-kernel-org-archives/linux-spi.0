Return-Path: <SRS0=Zlro=6V=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81393C38A24
	for <linux-spi@archiver.kernel.org>; Thu,  7 May 2020 11:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6337220735
	for <linux-spi@archiver.kernel.org>; Thu,  7 May 2020 11:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgEGLv7 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 7 May 2020 07:51:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3890 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbgEGLv7 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 7 May 2020 07:51:59 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E6D67E114F2976A781C1;
        Thu,  7 May 2020 19:51:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 7 May 2020 19:51:47 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-spi@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] spi: spi-amd: Remove spi_master_put in amd_spi_remove()
Date:   Thu, 7 May 2020 11:55:50 +0000
Message-ID: <20200507115550.139457-1-weiyongjun1@huawei.com>
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

The call to spi_master_put() in amd_spi_remove() is redundant and
may causes user after free since the master have been freed by
spi_unregister_master(), so remove it.

Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/spi-amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index c7cfc3dc20b1..e5e767ba5823 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -304,7 +304,6 @@ static int amd_spi_remove(struct platform_device *pdev)
 	struct amd_spi *amd_spi = platform_get_drvdata(pdev);
 
 	spi_unregister_master(amd_spi->master);
-	spi_master_put(amd_spi->master);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;



