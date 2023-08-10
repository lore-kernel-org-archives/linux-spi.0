Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7B1C001DB
	for <linux-spi@archiver.kernel.org>; Thu, 10 Aug 2023 08:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjHJIdI (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 10 Aug 2023 04:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjHJIdI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Aug 2023 04:33:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF87E56
        for <linux-spi@vger.kernel.org>; Thu, 10 Aug 2023 01:33:07 -0700 (PDT)
Received: from dggpemm100005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM0TW0t5mztSGG;
        Thu, 10 Aug 2023 16:29:35 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100005.china.huawei.com (7.185.36.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:33:05 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:33:04 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <geert@linux-m68k.org>, <lukas@wunner.de>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next 01/21] spi: lm70llp: switch to use modern name
Date:   Thu, 10 Aug 2023 16:29:44 +0800
Message-ID: <20230810083004.3988597-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810083004.3988597-1-yangyingliang@huawei.com>
References: <20230810083004.3988597-1-yangyingliang@huawei.com>
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

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/spi/spi-lm70llp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index ead0507c63be..e6a65b5c8c31 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -24,7 +24,7 @@
  * the SPI/Microwire bus interface. This driver specifically supports an
  * NS LM70 LLP Evaluation Board, interfacing to a PC using its parallel
  * port to bitbang an SPI-parport bridge.  Accordingly, this is an SPI
- * master controller driver.  The hwmon/lm70 driver is a "SPI protocol
+ * host controller driver.  The hwmon/lm70 driver is a "SPI protocol
  * driver", layered on top of this one and usable without the lm70llp.
  *
  * Datasheet and Schematic:
@@ -189,7 +189,7 @@ static void spi_lm70llp_attach(struct parport *p)
 {
 	struct pardevice	*pd;
 	struct spi_lm70llp	*pp;
-	struct spi_master	*master;
+	struct spi_controller	*host;
 	int			status;
 	struct pardev_cb	lm70llp_cb;
 
@@ -202,17 +202,17 @@ static void spi_lm70llp_attach(struct parport *p)
 	 * the lm70 driver could verify it, reading the manf ID.
 	 */
 
-	master = spi_alloc_master(p->physport->dev, sizeof(*pp));
-	if (!master) {
+	host = spi_alloc_host(p->physport->dev, sizeof(*pp));
+	if (!host) {
 		status = -ENOMEM;
 		goto out_fail;
 	}
-	pp = spi_master_get_devdata(master);
+	pp = spi_controller_get_devdata(host);
 
 	/*
 	 * SPI and bitbang hookup.
 	 */
-	pp->bitbang.master = master;
+	pp->bitbang.master = host;
 	pp->bitbang.chipselect = lm70_chipselect;
 	pp->bitbang.txrx_word[SPI_MODE_0] = lm70_txrx;
 	pp->bitbang.flags = SPI_3WIRE;
@@ -228,7 +228,7 @@ static void spi_lm70llp_attach(struct parport *p)
 
 	if (!pd) {
 		status = -ENOMEM;
-		goto out_free_master;
+		goto out_free_host;
 	}
 	pp->pd = pd;
 
@@ -287,8 +287,8 @@ static void spi_lm70llp_attach(struct parport *p)
 	parport_release(pp->pd);
 out_parport_unreg:
 	parport_unregister_device(pd);
-out_free_master:
-	spi_master_put(master);
+out_free_host:
+	spi_controller_put(host);
 out_fail:
 	pr_info("spi_lm70llp probe fail, status %d\n", status);
 }
@@ -309,7 +309,7 @@ static void spi_lm70llp_detach(struct parport *p)
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);
 
-	spi_master_put(pp->bitbang.master);
+	spi_controller_put(pp->bitbang.master);
 
 	lm70llp = NULL;
 }
-- 
2.25.1

