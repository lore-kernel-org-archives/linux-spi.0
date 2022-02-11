Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A66C4332F
	for <linux-spi@archiver.kernel.org>; Fri, 11 Feb 2022 03:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiBKDtv (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 10 Feb 2022 22:49:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbiBKDtt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Feb 2022 22:49:49 -0500
Received: from mail-m17664.qiye.163.com (mail-m17664.qiye.163.com [59.111.176.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6685F70;
        Thu, 10 Feb 2022 19:49:49 -0800 (PST)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m17664.qiye.163.com (Hmail) with ESMTPA id AA76F1401E5;
        Fri, 11 Feb 2022 11:49:47 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [RFC PATCH v1 3/6] spi: rockchip: Fix error in getting num-cs property
Date:   Fri, 11 Feb 2022 11:49:35 +0800
Message-Id: <20220211034938.25097-4-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211034938.25097-1-jon.lin@rock-chips.com>
References: <20220211034938.25097-1-jon.lin@rock-chips.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJDQhhWS0tJGB9CGkJISh
        8YVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDo6Egw*KT5LNB48GE5JDSs5
        PBkaCRZVSlVKTU9PTk5KSENDSkpJVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFJSUNCNwY+
X-HM-Tid: 0a7ee6e6bad4da2fkuwsaa76f1401e5
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Get num-cs u32 from dts of_node property rather than u16.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 1738a2611a2b..5f6a70664871 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -738,7 +738,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct resource *mem;
 	struct device_node *np = pdev->dev.of_node;
-	u32 rsd_nsecs;
+	u32 rsd_nsecs, num_cs;
 	bool slave_mode;
 
 	slave_mode = of_property_read_bool(np, "spi-slave");
@@ -848,8 +848,9 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		 * rk spi0 has two native cs, spi1..5 one cs only
 		 * if num-cs is missing in the dts, default to 1
 		 */
-		if (of_property_read_u16(np, "num-cs", &ctlr->num_chipselect))
-			ctlr->num_chipselect = 1;
+		if (of_property_read_u32(np, "num-cs", &num_cs))
+			num_cs = 1;
+		ctlr->num_chipselect = num_cs;
 		ctlr->use_gpio_descriptors = true;
 	}
 	ctlr->dev.of_node = pdev->dev.of_node;
-- 
2.17.1

