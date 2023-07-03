Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE7C001B3
	for <linux-spi@archiver.kernel.org>; Mon,  3 Jul 2023 09:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGCJFw (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 3 Jul 2023 05:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjGCJFs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jul 2023 05:05:48 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C710CA
        for <linux-spi@vger.kernel.org>; Mon,  3 Jul 2023 02:05:34 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:bc71:f024:6708:ff])
        by andre.telenet-ops.be with bizsmtp
        id GZ5X2A0040kCKfg01Z5Xpm; Mon, 03 Jul 2023 11:05:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qGFUv-000QZm-IT;
        Mon, 03 Jul 2023 11:05:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qGFUx-002YWv-6J;
        Mon, 03 Jul 2023 11:05:31 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: rzv2m-csi: Fix SoC product name
Date:   Mon,  3 Jul 2023 11:05:30 +0200
Message-Id: <89e9870a2c510387e4d7a863025f4d3639d4a261.1688375020.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SoC product name is "RZ/V2M".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Fixes: 83c624d8842d7f6c ("spi: Add support for Renesas CSI")

Please move the Fixes tag up if you think it is worthwhile.
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d9b3a16ef1ea9edc..02efce0e1086230c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -834,7 +834,7 @@ config SPI_RSPI
 	  SPI driver for Renesas RSPI and QSPI blocks.
 
 config SPI_RZV2M_CSI
-	tristate "Renesas RZV2M CSI controller"
+	tristate "Renesas RZ/V2M CSI controller"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  SPI driver for Renesas RZ/V2M Clocked Serial Interface (CSI)
-- 
2.34.1

