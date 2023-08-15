Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2AAC04A6A
	for <linux-spi@archiver.kernel.org>; Tue, 15 Aug 2023 02:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjHOCfu (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 14 Aug 2023 22:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbjHOCf1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Aug 2023 22:35:27 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF2A1737;
        Mon, 14 Aug 2023 19:35:25 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37F2YuZY067520;
        Tue, 15 Aug 2023 10:34:56 +0800 (+08)
        (envelope-from Jiansheng.Wu@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx05.spreadtrum.com [10.29.1.56])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RPwKX4BLQz2PgxhZ;
        Tue, 15 Aug 2023 10:32:48 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx05.spreadtrum.com
 (10.29.1.56) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 15 Aug
 2023 10:34:53 +0800
From:   Jiansheng Wu <jiansheng.wu@unisoc.com>
To:     Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yongzhi.chen@unisoc.com>, <xiaoqing.wu@unisoc.com>,
        <jianshengwu16@gmail.com>
Subject: [PATCH 6/8] Spi: sprd-adi: Supported adi controller on UMS9620
Date:   Tue, 15 Aug 2023 10:34:24 +0800
Message-ID: <20230815023426.15076-6-jiansheng.wu@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
References: <20230815023426.15076-1-jiansheng.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx05.spreadtrum.com (10.29.1.56)
X-MAIL: SHSQR01.spreadtrum.com 37F2YuZY067520
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Added ADI-controller on UMS9620 and reset regs on UMP9620, that is
a PMIC SoC integrated in UMS9620.

Signed-off-by: XiaoQing Wu <xiaoqing.wu@unisoc.com>
Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
---
 drivers/spi/spi-sprd-adi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index c31035fffe4c..0b20c228e119 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -111,6 +111,9 @@
 #define SC2730_CLK_EN			0x1810
 #define SC2730_WDG_BASE			0x40
 #define SC2730_RST_STATUS		0x1bac
+#define UMP9620_RST_STATUS		0x23ac
+#define UMP9620_SWRST_CTRL0             0x23f8
+#define UMP9620_SOFT_RST_HW             0x2024
 #define SC2730_SWRST_CTRL0              0x1bf8
 #define SC2730_SOFT_RST_HW              0x1824
 #define REG_RST_EN                      BIT(4)
@@ -687,6 +690,14 @@ static struct sprd_adi_data ums512_data = {
 	.softrst_base = SC2730_SOFT_RST_HW,
 };
 
+static struct sprd_adi_data ums9620_data = {
+	.slave_offset = ADI_15BIT_SLAVE_OFFSET,
+	.slave_addr_size = ADI_15BIT_SLAVE_ADDR_SIZE,
+	.rst_sts = UMP9620_RST_STATUS,
+	.swrst_base = UMP9620_SWRST_CTRL0,
+	.softrst_base = UMP9620_SOFT_RST_HW,
+};
+
 static const struct of_device_id sprd_adi_of_match[] = {
 	{
 		.compatible = "sprd,sc9860-adi",
@@ -700,6 +711,10 @@ static const struct of_device_id sprd_adi_of_match[] = {
 		.compatible = "sprd,ums512-adi",
 		.data = &ums512_data,
 	},
+	{
+		.compatible = "sprd,ums9620-adi",
+		.data = &ums9620_data,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sprd_adi_of_match);
-- 
2.17.1

