Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B87C433DB
	for <linux-spi@archiver.kernel.org>; Wed, 24 Mar 2021 06:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE37619E1
	for <linux-spi@archiver.kernel.org>; Wed, 24 Mar 2021 06:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhCXGRJ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 24 Mar 2021 02:17:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14515 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbhCXGQ2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4yc31ltSzPlfv;
        Wed, 24 Mar 2021 14:13:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:16 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 10/11] spi: rockchip: Fix code indent should use tabs where possible
Date:   Wed, 24 Mar 2021 14:16:41 +0800
Message-ID: <1616566602-13894-11-git-send-email-f.fangjian@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
References: <1616566602-13894-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix checkpatch errors:

  ERROR: code indent should use tabs where possible
  #484: FILE: spi-rockchip.c:484:
  +^I        | CR0_BHT_8BIT << CR0_BHT_OFFSET$
  ERROR: code indent should use tabs where possible
  #485: FILE: spi-rockchip.c:485:
  +^I        | CR0_SSD_ONE  << CR0_SSD_OFFSET$
  ERROR: code indent should use tabs where possible
  #486: FILE: spi-rockchip.c:486:
  +^I        | CR0_EM_BIG   << CR0_EM_OFFSET;$

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-rockchip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 936ef54..e6bc9c2 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -481,9 +481,9 @@ static void rockchip_spi_config(struct rockchip_spi *rs,
 		bool use_dma, bool slave_mode)
 {
 	u32 cr0 = CR0_FRF_SPI  << CR0_FRF_OFFSET
-	        | CR0_BHT_8BIT << CR0_BHT_OFFSET
-	        | CR0_SSD_ONE  << CR0_SSD_OFFSET
-	        | CR0_EM_BIG   << CR0_EM_OFFSET;
+		| CR0_BHT_8BIT << CR0_BHT_OFFSET
+		| CR0_SSD_ONE  << CR0_SSD_OFFSET
+		| CR0_EM_BIG   << CR0_EM_OFFSET;
 	u32 cr1;
 	u32 dmacr = 0;
 
-- 
2.7.4

