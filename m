Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6E5C4338F
	for <linux-spi@archiver.kernel.org>; Fri, 20 Aug 2021 08:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DA7610CF
	for <linux-spi@archiver.kernel.org>; Fri, 20 Aug 2021 08:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhHTIGx (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 20 Aug 2021 04:06:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42088 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhHTIGx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Aug 2021 04:06:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 078331A2CEA;
        Fri, 20 Aug 2021 10:06:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CD6C51A2CCC;
        Fri, 20 Aug 2021 10:06:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EB688183AD05;
        Fri, 20 Aug 2021 16:06:13 +0800 (+08)
From:   haibo.chen@nxp.com
To:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH 2/4] spi: spi-nxp-fspi: change the default lut index
Date:   Fri, 20 Aug 2021 15:44:01 +0800
Message-Id: <1629445443-10300-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
References: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The fspi dynamic lut use the last lut for all IPS operations, the
imx8ulp only supports 15 luts, so change the last lut index from
31 to 15.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 1eecf20f1dab..a764eb475aed 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -63,9 +63,9 @@
 /*
  * The driver only uses one single LUT entry, that is updated on
  * each call of exec_op(). Index 0 is preset at boot with a basic
- * read operation, so let's use the last entry (31).
+ * read operation, so let's use the last entry (15).
  */
-#define	SEQID_LUT			31
+#define	SEQID_LUT			15
 
 /* Registers used by the driver */
 #define FSPI_MCR0			0x00
-- 
2.17.1

