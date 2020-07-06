Return-Path: <SRS0=fYXv=AR=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F4AC433E4
	for <linux-spi@archiver.kernel.org>; Mon,  6 Jul 2020 14:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C22E20724
	for <linux-spi@archiver.kernel.org>; Mon,  6 Jul 2020 14:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgGFOey (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbgGFOey (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 10:34:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F60C061755
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 07:34:54 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1jsSCn-0005DP-Dj; Mon, 06 Jul 2020 16:34:49 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH v2 09/10] spi: spi-sun6i: sun6i_spi_transfer_one(): collate write to Interrupt Control Register
Date:   Mon,  6 Jul 2020 16:34:42 +0200
Message-Id: <20200706143443.9855-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706143443.9855-1-mkl@pengutronix.de>
References: <20200706143443.9855-1-mkl@pengutronix.de>
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

In sun6i_spi_transfer_one() the Interrupt Control Register is written three
times. This patch collates the three writes into one.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/spi/spi-sun6i.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 2442006c4229..bba9843c40c5 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -119,14 +119,6 @@ static inline u32 sun6i_spi_get_tx_fifo_count(struct sun6i_spi *sspi)
 	return FIELD_GET(SUN6I_FIFO_STA_TF_CNT_MASK, reg);
 }
 
-static inline void sun6i_spi_enable_interrupt(struct sun6i_spi *sspi, u32 mask)
-{
-	u32 reg = sun6i_spi_read(sspi, SUN6I_INT_CTL_REG);
-
-	reg |= mask;
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
-}
-
 static inline void sun6i_spi_disable_interrupt(struct sun6i_spi *sspi, u32 mask)
 {
 	u32 reg = sun6i_spi_read(sspi, SUN6I_INT_CTL_REG);
@@ -310,11 +302,12 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	sun6i_spi_fill_fifo(sspi);
 
 	/* Enable the interrupts */
-	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
-	sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TC |
-					 SUN6I_INT_CTL_RF_RDY);
+	reg = SUN6I_INT_CTL_TC | SUN6I_INT_CTL_RF_RDY;
+
 	if (tx_len > sspi->fifo_depth)
-		sun6i_spi_enable_interrupt(sspi, SUN6I_INT_CTL_TF_ERQ);
+		reg |= SUN6I_INT_CTL_TF_ERQ;
+
+	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, reg);
 
 	/* Start the transfer */
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
-- 
2.27.0

