Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF77C6FA82
	for <linux-spi@archiver.kernel.org>; Mon, 26 Sep 2022 15:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbiIZPh4 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiIZPfw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 11:35:52 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F88323
        for <linux-spi@vger.kernel.org>; Mon, 26 Sep 2022 07:23:14 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MblGp3L69zHtmq;
        Mon, 26 Sep 2022 22:18:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 22:23:12 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 26 Sep
 2022 22:23:12 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <lukas@wunner.de>, <yangyingliang@huawei.com>
Subject: [PATCH -next 1/2] spi: introduce devm_spi_alloc_controller()
Date:   Mon, 26 Sep 2022 22:29:32 +0800
Message-ID: <20220926142933.2299460-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce devm_spi_alloc_controller() to wrap __devm_spi_alloc_controller(),
with this wrapper, the drivers can use it to update to the modern naming.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/linux/spi/spi.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6ea889df0813..32dd736ebe2e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -778,6 +778,12 @@ static inline struct spi_controller *devm_spi_alloc_slave(struct device *dev,
 	return __devm_spi_alloc_controller(dev, size, true);
 }
 
+static inline struct spi_controller *devm_spi_alloc_controller(struct device *dev,
+							       unsigned int size)
+{
+	return __devm_spi_alloc_controller(dev, size, false);
+}
+
 extern int spi_register_controller(struct spi_controller *ctlr);
 extern int devm_spi_register_controller(struct device *dev,
 					struct spi_controller *ctlr);
-- 
2.25.1

