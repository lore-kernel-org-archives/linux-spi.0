Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C21C001DF
	for <linux-spi@archiver.kernel.org>; Wed, 16 Aug 2023 09:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbjHPJnC (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 16 Aug 2023 05:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243441AbjHPJmt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:42:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E9E74
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:42:47 -0700 (PDT)
Received: from dggpemm100011.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQjmm2QVczVk8Z;
        Wed, 16 Aug 2023 17:40:40 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100011.china.huawei.com (7.185.36.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:42:45 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:42:45 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <fancer.lancer@gmail.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] spi: dw-mmio: keep old name same as documentation
Date:   Wed, 16 Aug 2023 17:39:38 +0800
Message-ID: <20230816093938.1274806-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The documentation has not use the new name(host/target),
so keep the comment words same as documentation used.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-dw-mmio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 9e041a28ed47..805264c9c65c 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -68,7 +68,7 @@ struct dw_spi_mscc {
 		((((val) << 1) | BIT(0)) << ELBA_SPICS_OFFSET(cs))
 
 /*
- * The Designware SPI controller (referred to as host in the documentation)
+ * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
  * selects then needs to be either driven as GPIOs or, for the first 4 using
  * the SPI boot controller registers. the final chip select is an OR gate
@@ -142,7 +142,7 @@ static int dw_spi_mscc_jaguar2_init(struct platform_device *pdev,
 }
 
 /*
- * The Designware SPI controller (referred to as host in the
+ * The Designware SPI controller (referred to as master in the
  * documentation) automatically deasserts chip select when the tx fifo
  * is empty. The chip selects then needs to be driven by a CS override
  * register. enable is an active low signal.
-- 
2.25.1

