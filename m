Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEACCCA473
	for <linux-spi@archiver.kernel.org>; Mon, 27 Jun 2022 15:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiF0Pbc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbiF0Pb2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jun 2022 11:31:28 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345CF19C32
        for <linux-spi@vger.kernel.org>; Mon, 27 Jun 2022 08:31:24 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id oFXH2700N4C55Sk01FXHYj; Mon, 27 Jun 2022 17:31:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qhp-0014yZ-1Y; Mon, 27 Jun 2022 17:31:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o5qho-004jET-FY; Mon, 27 Jun 2022 17:31:16 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/7] memory: renesas-rpc-if: Add dev helper to rpcif_probe()
Date:   Mon, 27 Jun 2022 17:31:09 +0200
Message-Id: <31051c05581d0200a45357a6d1ab4ad268a1bbf4.1656341824.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1656341824.git.geert+renesas@glider.be>
References: <cover.1656341824.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a helper variable pointing to the device structure, to avoid going
through the platform device every time.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/memory/renesas-rpc-if.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 829b962e8f034bdd..2421a820e3c5880c 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -666,14 +666,15 @@ EXPORT_SYMBOL(rpcif_dirmap_read);
 
 static int rpcif_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct platform_device *vdev;
 	struct device_node *flash;
 	const char *name;
 	int ret;
 
-	flash = of_get_next_child(pdev->dev.of_node, NULL);
+	flash = of_get_next_child(dev->of_node, NULL);
 	if (!flash) {
-		dev_warn(&pdev->dev, "no flash node found\n");
+		dev_warn(dev, "no flash node found\n");
 		return -ENODEV;
 	}
 
@@ -683,7 +684,7 @@ static int rpcif_probe(struct platform_device *pdev)
 		name = "rpc-if-hyperflash";
 	} else	{
 		of_node_put(flash);
-		dev_warn(&pdev->dev, "unknown flash type\n");
+		dev_warn(dev, "unknown flash type\n");
 		return -ENODEV;
 	}
 	of_node_put(flash);
@@ -691,7 +692,7 @@ static int rpcif_probe(struct platform_device *pdev)
 	vdev = platform_device_alloc(name, pdev->id);
 	if (!vdev)
 		return -ENOMEM;
-	vdev->dev.parent = &pdev->dev;
+	vdev->dev.parent = dev;
 	platform_set_drvdata(pdev, vdev);
 
 	ret = platform_device_add(vdev);
-- 
2.25.1

