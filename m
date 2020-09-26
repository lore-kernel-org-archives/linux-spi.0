Return-Path: <SRS0=fJD8=DD=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C5DC4727C
	for <linux-spi@archiver.kernel.org>; Sat, 26 Sep 2020 00:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B45206FB
	for <linux-spi@archiver.kernel.org>; Sat, 26 Sep 2020 00:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725272AbgIZATl (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 25 Sep 2020 20:19:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14282 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgIZATj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Sep 2020 20:19:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0861130BBAA3FB6B0D4B;
        Sat, 26 Sep 2020 08:19:37 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.248) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Sat, 26 Sep 2020 08:19:27 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 2/2] spi: spi-stm32: remove redundant irqsave and irqrestore in hardIRQ
Date:   Sat, 26 Sep 2020 12:16:16 +1200
Message-ID: <20200926001616.21292-2-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20200926001616.21292-1-song.bao.hua@hisilicon.com>
References: <20200926001616.21292-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.248]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Running in hardIRQ, disabling IRQ is redundant.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/spi/spi-stm32.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 3056428b09f3..caf44836f4bb 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -804,10 +804,9 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 	struct spi_master *master = dev_id;
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 	u32 sr, mask = 0;
-	unsigned long flags;
 	bool end = false;
 
-	spin_lock_irqsave(&spi->lock, flags);
+	spin_lock(&spi->lock);
 
 	sr = readl_relaxed(spi->base + STM32F4_SPI_SR);
 	/*
@@ -833,7 +832,7 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 
 	if (!(sr & mask)) {
 		dev_dbg(spi->dev, "spurious IT (sr=0x%08x)\n", sr);
-		spin_unlock_irqrestore(&spi->lock, flags);
+		spin_unlock(&spi->lock);
 		return IRQ_NONE;
 	}
 
@@ -875,11 +874,11 @@ static irqreturn_t stm32f4_spi_irq_event(int irq, void *dev_id)
 					STM32F4_SPI_CR2_TXEIE |
 					STM32F4_SPI_CR2_RXNEIE |
 					STM32F4_SPI_CR2_ERRIE);
-		spin_unlock_irqrestore(&spi->lock, flags);
+		spin_unlock(&spi->lock);
 		return IRQ_WAKE_THREAD;
 	}
 
-	spin_unlock_irqrestore(&spi->lock, flags);
+	spin_unlock(&spi->lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.25.1

