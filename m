Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E7C433EF
	for <linux-spi@archiver.kernel.org>; Wed, 13 Jul 2022 02:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiGMCrh (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 12 Jul 2022 22:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGMCrg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Jul 2022 22:47:36 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F5FCC03D;
        Tue, 12 Jul 2022 19:47:36 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LjMRJ060Jz1L92R;
        Wed, 13 Jul 2022 10:45:00 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 10:47:34 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Jul
 2022 10:47:33 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     <conor.dooley@microchip.com>, <daire.mcnamara@microchip.com>,
        <broonie@kernel.org>
Subject: [PATCH -next v2 1/3] spi: microchip-core: fix UAF in mchp_corespi_remove()
Date:   Wed, 13 Jul 2022 10:56:55 +0800
Message-ID: <20220713025657.3524506-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713025657.3524506-1-yangyingliang@huawei.com>
References: <20220713025657.3524506-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

When using devm_spi_register_master(), the unregister function will
be called in devres_release_all() which is called after ->remove(),
so remove spi_unregister_master() andspi_master_put().

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-microchip-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index b3083075cd36..c26767343176 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -595,8 +595,6 @@ static int mchp_corespi_remove(struct platform_device *pdev)
 	struct mchp_corespi *spi = spi_master_get_devdata(master);
 
 	mchp_corespi_disable_ints(spi);
-	spi_unregister_master(master);
-	spi_master_put(master);
 	clk_disable_unprepare(spi->clk);
 	mchp_corespi_disable(spi);
 
-- 
2.25.1

