Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718FCC25B5E
	for <linux-spi@archiver.kernel.org>; Wed, 16 Aug 2023 09:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbjHPJnm (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 16 Aug 2023 05:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243465AbjHPJnd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Aug 2023 05:43:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA7626A4
        for <linux-spi@vger.kernel.org>; Wed, 16 Aug 2023 02:43:32 -0700 (PDT)
Received: from dggpemm500018.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQjnc6LWYzVjy9;
        Wed, 16 Aug 2023 17:41:24 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500018.china.huawei.com (7.185.36.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:43:30 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:43:29 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 24/24] spi: spi-sn-f-ospi: switch to use modern name
Date:   Wed, 16 Aug 2023 17:40:13 +0800
Message-ID: <20230816094013.1275068-25-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816094013.1275068-1-yangyingliang@huawei.com>
References: <20230816094013.1275068-1-yangyingliang@huawei.com>
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-sn-f-ospi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 85e4a01bc8b0..a7c3b3923b4a 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -501,7 +501,7 @@ static int f_ospi_indir_write(struct f_ospi *ospi, struct spi_mem *mem,
 
 static int f_ospi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	struct f_ospi *ospi = spi_controller_get_devdata(mem->spi->master);
+	struct f_ospi *ospi = spi_controller_get_devdata(mem->spi->controller);
 	int err = 0;
 
 	switch (op->data.dir) {
@@ -606,7 +606,7 @@ static int f_ospi_probe(struct platform_device *pdev)
 	u32 num_cs = OSPI_NUM_CS;
 	int ret;
 
-	ctlr = spi_alloc_master(dev, sizeof(*ospi));
+	ctlr = spi_alloc_host(dev, sizeof(*ospi));
 	if (!ctlr)
 		return -ENOMEM;
 
-- 
2.25.1

