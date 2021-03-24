Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2351C433C1
	for <linux-spi@archiver.kernel.org>; Wed, 24 Mar 2021 06:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD5619C7
	for <linux-spi@archiver.kernel.org>; Wed, 24 Mar 2021 06:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhCXGRC (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 24 Mar 2021 02:17:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14518 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbhCXGQ2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 02:16:28 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F4yc31QPJzPld4;
        Wed, 24 Mar 2021 14:13:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 14:16:16 +0800
From:   Jay Fang <f.fangjian@huawei.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <huangdaode@huawei.com>
Subject: [PATCH 08/11] spi: jcore: Fix trailing statements should be on next line
Date:   Wed, 24 Mar 2021 14:16:39 +0800
Message-ID: <1616566602-13894-9-git-send-email-f.fangjian@huawei.com>
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

  ERROR: trailing statements should be on next line
  #85: FILE: spi-jcore.c:85:
  +	if (speed == hw->speed_hz) return;

Signed-off-by: Jay Fang <f.fangjian@huawei.com>
---
 drivers/spi/spi-jcore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index bba10f0..74c8319 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -82,7 +82,8 @@ static void jcore_spi_chipsel(struct spi_device *spi, bool value)
 
 static void jcore_spi_baudrate(struct jcore_spi *hw, int speed)
 {
-	if (speed == hw->speed_hz) return;
+	if (speed == hw->speed_hz)
+		return;
 	hw->speed_hz = speed;
 	if (speed >= hw->clock_freq / 2)
 		hw->speed_reg = 0;
-- 
2.7.4

