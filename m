Return-Path: <SRS0=Nu9C=62=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8003C54E4A
	for <linux-spi@archiver.kernel.org>; Tue, 12 May 2020 11:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA073206A3
	for <linux-spi@archiver.kernel.org>; Tue, 12 May 2020 11:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgELLDU (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 12 May 2020 07:03:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:37331 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729413AbgELLDU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 12 May 2020 07:03:20 -0400
IronPort-SDR: hp8pXRrZ6Ckp9TbssuJGv30ZP9TG+VJ1ys+xkVLd6ig4mpaAu0qEkhDolUjM5es57wFSydoHzh
 F+6EZiDoPe8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 04:03:19 -0700
IronPort-SDR: +PDkrxsIjc5ZVJ/Fac1IqXB4GhQjopbOIbTASrjxWtsjB1Bl+uCtyhbZ+GMw0o9kw+VuEYuIBP
 v43fdWFgBjbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="437060687"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2020 04:03:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1DB5EE1; Tue, 12 May 2020 14:03:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] spi: dw: Drop duplicate error message when remap resource
Date:   Tue, 12 May 2020 14:03:15 +0300
Message-Id: <20200512110315.58845-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

devm_platform_ioremap_resource() will issue a message in the error case.
Thus, no need to duplicate in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw-mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index bef76e210e091b..d8487209beb818 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -148,10 +148,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	/* Get basic io resource and map it */
 	dws->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(dws->regs)) {
-		dev_err(&pdev->dev, "SPI region map failed\n");
+	if (IS_ERR(dws->regs))
 		return PTR_ERR(dws->regs);
-	}
 
 	dws->irq = platform_get_irq(pdev, 0);
 	if (dws->irq < 0)
-- 
2.26.2

