Return-Path: <SRS0=13QO=EO=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE25C388F9
	for <linux-spi@archiver.kernel.org>; Sun,  8 Nov 2020 22:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA767206DB
	for <linux-spi@archiver.kernel.org>; Sun,  8 Nov 2020 22:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgKHWnD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 8 Nov 2020 17:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgKHWnD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 8 Nov 2020 17:43:03 -0500
X-Greylist: delayed 116 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Nov 2020 14:43:03 PST
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F117C0613CF
        for <linux-spi@vger.kernel.org>; Sun,  8 Nov 2020 14:43:03 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id 513B5103D9C67;
        Sun,  8 Nov 2020 23:43:01 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id C0009603DAD2;
        Sun,  8 Nov 2020 23:43:01 +0100 (CET)
X-Mailbox-Line: From 8f8dc2815aa97b2378528f08f923bf81e19611f0 Mon Sep 17 00:00:00 2001
Message-Id: <8f8dc2815aa97b2378528f08f923bf81e19611f0.1604874488.git.lukas@wunner.de>
In-Reply-To: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
References: <dd060534490eca5e946eb9165916542b01a9358d.1604874488.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sun, 8 Nov 2020 23:41:00 +0100
Subject: [PATCH] spi: atmel-quadspi: Disable clock in probe error path
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If the call to of_device_get_match_data() fails on probe of the Atmel
QuadSPI driver, the clock "aq->pclk" is erroneously not unprepared and
disabled.  Fix it.

Fixes: 2e5c88887358 ("spi: atmel-quadspi: add support for sam9x60 qspi controller")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.1+
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 8c009c175f2c..b44521d4a245 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -594,7 +594,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (!aq->caps) {
 		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
 		err = -EINVAL;
-		goto exit;
+		goto disable_pclk;
 	}
 
 	if (aq->caps->has_qspick) {
-- 
2.28.0

