Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076C7CCA473
	for <linux-spi@archiver.kernel.org>; Thu,  9 Jun 2022 07:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiFIHM7 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 9 Jun 2022 03:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiFIHM6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jun 2022 03:12:58 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2160E2428ED;
        Thu,  9 Jun 2022 00:12:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VFrcIPJ_1654758771;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VFrcIPJ_1654758771)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 15:12:52 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     andi@etezian.org, broonie@kernel.org, alim.akhtar@samsung.com,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next v2] spi: Return true/false (not 1/0) from bool function
Date:   Thu,  9 Jun 2022 15:12:50 +0800
Message-Id: <20220609071250.59509-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Return boolean values ("true" or "false") instead of 1 or 0 from bool
function.

As reported by coccicheck:
./drivers/spi/spi-s3c64xx.c:385:9-10: WARNING: return of 0/1 in function
's3c64xx_spi_can_dma' with return type bool

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 82558e37c735..28e7b7cb68a7 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -382,7 +382,7 @@ static bool s3c64xx_spi_can_dma(struct spi_master *master,
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		return xfer->len > (FIFO_LVL_MASK(sdd) >> 1) + 1;
 	} else {
-		return 0;
+		return false;
 	}
 
 }
-- 
2.20.1.7.g153144c

