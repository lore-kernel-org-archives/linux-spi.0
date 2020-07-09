Return-Path: <SRS0=rD+8=AU=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240B7C433E1
	for <linux-spi@archiver.kernel.org>; Thu,  9 Jul 2020 07:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 006392070E
	for <linux-spi@archiver.kernel.org>; Thu,  9 Jul 2020 07:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgGIHla (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgGIHl2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jul 2020 03:41:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D3C08C5CE
        for <linux-spi@vger.kernel.org>; Thu,  9 Jul 2020 00:41:28 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jtRBM-0000FM-0d; Thu, 09 Jul 2020 09:41:24 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        Martin Sperl <kernel@martin.sperl.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 1/2] spi: bcm2835: support effective_speed_hz
Date:   Thu,  9 Jul 2020 09:41:19 +0200
Message-Id: <20200709074120.110069-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709074120.110069-1-mkl@pengutronix.de>
References: <20200709074120.110069-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Setting spi_transfer->effective_speed_hz in transfer_one so that
it can get used in cs_change_delay configured with delay as a muliple
of SPI clock cycles.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-bcm2835.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 237bd306c268..86b6510a2e32 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1084,7 +1084,7 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 				    struct spi_transfer *tfr)
 {
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
-	unsigned long spi_hz, clk_hz, cdiv, spi_used_hz;
+	unsigned long spi_hz, clk_hz, cdiv;
 	unsigned long hz_per_byte, byte_limit;
 	u32 cs = bs->prepare_cs[spi->chip_select];
 
@@ -1104,7 +1104,7 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 	} else {
 		cdiv = 0; /* 0 is the slowest we can go */
 	}
-	spi_used_hz = cdiv ? (clk_hz / cdiv) : (clk_hz / 65536);
+	tfr->effective_speed_hz = cdiv ? (clk_hz / cdiv) : (clk_hz / 65536);
 	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
 
 	/* handle all the 3-wire mode */
@@ -1124,7 +1124,7 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 	 * per 300,000 Hz of bus clock.
 	 */
 	hz_per_byte = polling_limit_us ? (9 * 1000000) / polling_limit_us : 0;
-	byte_limit = hz_per_byte ? spi_used_hz / hz_per_byte : 1;
+	byte_limit = hz_per_byte ? tfr->effective_speed_hz / hz_per_byte : 1;
 
 	/* run in polling mode for short transfers */
 	if (tfr->len < byte_limit)
-- 
2.27.0

