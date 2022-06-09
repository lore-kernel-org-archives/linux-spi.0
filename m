Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F554C433EF
	for <linux-spi@archiver.kernel.org>; Thu,  9 Jun 2022 05:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbiFIFzo (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 9 Jun 2022 01:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiFIFzo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jun 2022 01:55:44 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4906141;
        Wed,  8 Jun 2022 22:55:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VFrCFzQ_1654754137;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0VFrCFzQ_1654754137)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 13:55:38 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     broonie@kernel.org
Cc:     conor.dooley@microchip.com, lewis.hanly@microchip.com,
        linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] spi: Remove unnecessary print function dev_err()
Date:   Thu,  9 Jun 2022 13:55:33 +0800
Message-Id: <20220609055533.95866-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220609055533.95866-1-yang.lee@linux.alibaba.com>
References: <20220609055533.95866-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The function platform_get_irq() never returns 0, and the print function
dev_err() is redundant because platform_get_irq() already prints an error.

Eliminate the follow coccicheck warning:
./drivers/spi/spi-microchip-core.c:543:2-9: line 543 is redundant
because platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/spi/spi-microchip-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 3bd285dd4964..d8ae25ccffa8 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -539,8 +539,7 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	}
 
 	spi->irq = platform_get_irq(pdev, 0);
-	if (spi->irq <= 0) {
-		dev_err(&pdev->dev, "invalid IRQ %d for SPI controller\n", spi->irq);
+	if (spi->irq < 0) {
 		ret = spi->irq;
 		goto error_release_master;
 	}
-- 
2.20.1.7.g153144c

