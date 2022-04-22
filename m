Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2595C433F5
	for <linux-spi@archiver.kernel.org>; Fri, 22 Apr 2022 19:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiDVTcV (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 22 Apr 2022 15:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiDVTcR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Apr 2022 15:32:17 -0400
Received: from out28-196.mail.aliyun.com (out28-196.mail.aliyun.com [115.124.28.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CABB263CA2;
        Fri, 22 Apr 2022 12:10:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07683901|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00422385-0.000511306-0.995265;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.NVyzemb_1650654596;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NVyzemb_1650654596)
          by smtp.aliyun-inc.com(33.37.68.185);
          Sat, 23 Apr 2022 03:09:57 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        contact@artur-rojek.eu, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v2 1/3] SPI: Ingenic: Add support for use GPIO as chip select line.
Date:   Sat, 23 Apr 2022 03:09:41 +0800
Message-Id: <1650654583-89933-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650654583-89933-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650654583-89933-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for using GPIOs as chip select lines on Ingenic SoCs.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v1->v2:
    Use "device_property_read_u32()" instead
    "of_property_read_u32()" as Paul Cercueil's suggestion.

 drivers/spi/spi-ingenic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-ingenic.c b/drivers/spi/spi-ingenic.c
index 03077a7..bb512ca 100644
--- a/drivers/spi/spi-ingenic.c
+++ b/drivers/spi/spi-ingenic.c
@@ -380,7 +380,7 @@ static int spi_ingenic_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct ingenic_spi *priv;
 	void __iomem *base;
-	int ret;
+	int num_cs, ret;
 
 	pdata = of_device_get_match_data(dev);
 	if (!pdata) {
@@ -416,6 +416,11 @@ static int spi_ingenic_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->flen_field))
 		return PTR_ERR(priv->flen_field);
 
+	if (device_property_read_u32(dev, "num-cs", &num_cs)) {
+		dev_warn(dev, "Number of chip select lines not specified.\n");
+		num_cs = 2;
+	}
+
 	platform_set_drvdata(pdev, ctlr);
 
 	ctlr->prepare_transfer_hardware = spi_ingenic_prepare_hardware;
@@ -429,7 +434,9 @@ static int spi_ingenic_probe(struct platform_device *pdev)
 	ctlr->bits_per_word_mask = pdata->bits_per_word_mask;
 	ctlr->min_speed_hz = 7200;
 	ctlr->max_speed_hz = 54000000;
-	ctlr->num_chipselect = 2;
+	ctlr->use_gpio_descriptors = true;
+	ctlr->max_native_cs = 2;
+	ctlr->num_chipselect = num_cs;
 	ctlr->dev.of_node = pdev->dev.of_node;
 
 	if (spi_ingenic_request_dma(ctlr, dev))
-- 
2.7.4

