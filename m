Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0CBC433E0
	for <linux-spi@archiver.kernel.org>; Mon, 18 Jan 2021 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE28722BF3
	for <linux-spi@archiver.kernel.org>; Mon, 18 Jan 2021 16:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404845AbhARQjl (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:39:41 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:51462 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405747AbhARQja (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 Jan 2021 11:39:30 -0500
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Jan 2021 11:39:29 EST
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7B115FB03;
        Mon, 18 Jan 2021 17:31:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Pbhew2sWb8fE; Mon, 18 Jan 2021 17:31:11 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id BDF5040885; Mon, 18 Jan 2021 17:31:10 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Trent Piepho <tpiepho@impinj.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: Don't print error on -EPROBEDEFER
Date:   Mon, 18 Jan 2021 17:31:10 +0100
Message-Id: <0f51ab42e7c7a3452f2f8652794d81584303ea0d.1610987414.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This avoids

[    0.962538] spi_imx 30820000.spi: bitbang start failed with -517

durig driver probe.

Fixes: 8197f489f4c4 ("spi: imx: Fix failure path leak on GPIO request error correctly")
Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/spi/spi-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 73ca821763d6..5dc4ea4b4450 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1685,7 +1685,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	master->dev.of_node = pdev->dev.of_node;
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
-		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "bitbang start failed\n");
 		goto out_bitbang_start;
 	}
 
-- 
2.29.2

