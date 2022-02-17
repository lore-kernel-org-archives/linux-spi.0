Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE83C433F5
	for <linux-spi@archiver.kernel.org>; Thu, 17 Feb 2022 01:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiBQBAn (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:00:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiBQBAm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Feb 2022 20:00:42 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C51279935;
        Wed, 16 Feb 2022 17:00:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V4f6lyc_1645059625;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V4f6lyc_1645059625)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Feb 2022 09:00:26 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     lhjeff911@gmail.com
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] spi: clean up some inconsistent indenting
Date:   Thu, 17 Feb 2022 09:00:24 +0800
Message-Id: <20220217010024.111904-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Eliminate the follow smatch warning:
drivers/spi/spi-sunplus-sp7021.c:379 sp7021_spi_slave_transfer_one()
warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index ade7a0fca8cb..f989f7b99296 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -376,8 +376,8 @@ static int sp7021_spi_slave_transfer_one(struct spi_controller *ctlr, struct spi
 					      xfer->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, xfer->tx_dma))
 			return -ENOMEM;
-		 ret = sp7021_spi_slave_tx(spi, xfer);
-		 dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
+		ret = sp7021_spi_slave_tx(spi, xfer);
+		dma_unmap_single(dev, xfer->tx_dma, xfer->len, DMA_TO_DEVICE);
 	} else if (xfer->rx_buf && !xfer->tx_buf) {
 		xfer->rx_dma = dma_map_single(dev, xfer->rx_buf, xfer->len,
 					      DMA_FROM_DEVICE);
-- 
2.20.1.7.g153144c

