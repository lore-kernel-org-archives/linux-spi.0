Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B01BC433E2
	for <linux-spi@archiver.kernel.org>; Wed, 24 Mar 2021 06:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB93619C7
	for <linux-spi@archiver.kernel.org>; Wed, 24 Mar 2021 06:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhCXGQc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 24 Mar 2021 02:16:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14446 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhCXGQ0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F4yd02vgczkdg7;
        Wed, 24 Mar 2021 14:14:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:13 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 01/11] spi: spi-topcliff-pch: Fix checkpatch spacing error
Date:   Wed, 24 Mar 2021 14:16:32 +0800
Message-ID: <1616566602-13894-2-git-send-email-f.fangjian@huawei.com>
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

Fix checkpatch error:

  ERROR: space prohibited before that '++' (ctx:WxB)
  #1204: FILE: spi-topcliff-pch.c:1204:
  +			for (i = 0; i < cnt; i ++) {
 			                       ^

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-topcliff-pch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index b459e36..b887078 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1201,7 +1201,8 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 		if (data->use_dma) {
 			int i;
 			char *save_rx_buf = data->cur_trans->rx_buf;
-			for (i = 0; i < cnt; i ++) {
+
+			for (i = 0; i < cnt; i++) {
 				pch_spi_handle_dma(data, &bpw);
 				if (!pch_spi_start_transfer(data)) {
 					data->transfer_complete = true;
-- 
2.7.4

