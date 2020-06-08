Return-Path: <SRS0=5tyO=7V=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C9FC433E1
	for <linux-spi@archiver.kernel.org>; Mon,  8 Jun 2020 10:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F612206C3
	for <linux-spi@archiver.kernel.org>; Mon,  8 Jun 2020 10:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgFHKEr (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgFHKEr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 8 Jun 2020 06:04:47 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B7AC08C5C4
        for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2020 03:04:47 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:c85f:a5bf:b1bd:702b])
        by laurent.telenet-ops.be with bizsmtp
        id oZzi2200P0R8aca01Zzis9; Mon, 08 Jun 2020 11:59:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007P6-D9; Mon, 08 Jun 2020 11:59:42 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jiEZC-0007xC-Be; Mon, 08 Jun 2020 11:59:42 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/8] spi: rspi: Clean up Bit Rate Division Setting handling
Date:   Mon,  8 Jun 2020 11:59:35 +0200
Message-Id: <20200608095940.30516-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608095940.30516-1-geert+renesas@glider.be>
References: <20200608095940.30516-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a macro for configuring the Bit Rate Division Setting field in
Command Registers, instead of open-coding the same operation using a
hardcoded shift.
Rename "div" to "brdv", as it is not a plain divider value, but controls
a power-of-two divider.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 1b635d6b7881f5b9..450a42ec2141a895 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -161,6 +161,7 @@
 #define SPCMD_SPRW		0x0010	/* SPI Read/Write Access (Dual/Quad) */
 #define SPCMD_SSLA(i)		((i) << 4)	/* SSL Assert Signal Setting */
 #define SPCMD_BRDV_MASK		0x000c	/* Bit Rate Division Setting */
+#define SPCMD_BRDV(brdv)	((brdv) << 2)
 #define SPCMD_CPOL		0x0002	/* Clock Polarity Setting */
 #define SPCMD_CPHA		0x0001	/* Clock Phase Setting */
 
@@ -290,24 +291,24 @@ static int rspi_set_config_register(struct rspi_data *rspi, int access_size)
 static int rspi_rz_set_config_register(struct rspi_data *rspi, int access_size)
 {
 	int spbr;
-	int div = 0;
+	int brdv = 0;
 	unsigned long clksrc;
 
 	/* Sets output mode, MOSI signal, and (optionally) loopback */
 	rspi_write8(rspi, rspi->sppcr, RSPI_SPPCR);
 
 	clksrc = clk_get_rate(rspi->clk);
-	while (div < 3) {
+	while (brdv < 3) {
 		if (rspi->speed_hz >= clksrc/4) /* 4=(CLK/2)/2 */
 			break;
-		div++;
+		brdv++;
 		clksrc /= 2;
 	}
 
 	/* Sets transfer bit rate */
 	spbr = DIV_ROUND_UP(clksrc, 2 * rspi->speed_hz) - 1;
 	rspi_write8(rspi, clamp(spbr, 0, 255), RSPI_SPBR);
-	rspi->spcmd |= div << 2;
+	rspi->spcmd |= SPCMD_BRDV(brdv);
 
 	/* Disable dummy transmission, set byte access */
 	rspi_write8(rspi, SPDCR_SPLBYTE, RSPI_SPDCR);
-- 
2.17.1

