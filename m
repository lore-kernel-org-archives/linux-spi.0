Return-Path: <SRS0=+Fl2=C7=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B91AC4727D
	for <linux-spi@archiver.kernel.org>; Tue, 22 Sep 2020 09:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1139F23A34
	for <linux-spi@archiver.kernel.org>; Tue, 22 Sep 2020 09:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIVJc4 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 22 Sep 2020 05:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgIVJc4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Sep 2020 05:32:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EACAC061755
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2020 02:32:56 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKef0-0004VE-Vf; Tue, 22 Sep 2020 11:32:30 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kKef0-0000WJ-33; Tue, 22 Sep 2020 11:32:30 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Daniel Mack <daniel@zonque.org>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/6] spi: bcm2835: Use devm_spi_register_controller()
Date:   Tue, 22 Sep 2020 11:32:25 +0200
Message-Id: <20200922093228.24917-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922093228.24917-1-s.hauer@pengutronix.de>
References: <20200922093228.24917-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Calling spi_unregister_controller() during driver remove results in
freeing the SPI controller and the associated driver data. Using it
later in bcm2835_spi_remove() is a use-after-free bug. Register the
controller with devm_spi_register_controller() instead which makes
calling spi_unregister_controller() unnecessary.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-bcm2835.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index c45d76c848c8..d22103f7beeb 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1350,7 +1350,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		goto out_dma_release;
 	}
 
-	err = spi_register_controller(ctlr);
+	err = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI controller: %d\n",
 			err);
@@ -1377,8 +1377,6 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 
 	bcm2835_debugfs_remove(bs);
 
-	spi_unregister_controller(ctlr);
-
 	bcm2835_dma_release(ctlr, bs);
 
 	/* Clear FIFOs, and disable the HW block */
-- 
2.28.0

