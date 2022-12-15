Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01898C4332F
	for <linux-spi@archiver.kernel.org>; Thu, 15 Dec 2022 16:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiLOQxg (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiLOQwy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Dec 2022 11:52:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BE9396D2;
        Thu, 15 Dec 2022 08:52:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD0861E5D;
        Thu, 15 Dec 2022 16:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD03FC433EF;
        Thu, 15 Dec 2022 16:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671123173;
        bh=2bmhdr/nvgkMf7YcywGkuuzXTYoO4RT28VcvVaqvCyU=;
        h=From:To:Cc:Subject:Date:From;
        b=B/+V5Zt/7aZXi/25niJEihaQl697KMqmlxDtuRuL7on8YtR7umPBPLp5ZYsX1jtl5
         Krc8ipKD2F4SyIdc29Cy1soN+OfO7gj1RySeBWttJFxiTce+DSVh7lQu++Ofe1ZUMt
         94upTImB5ujP/M8x1Icu/ZeANadgp9v07a7g4xzIkEdsayWTF2dC6pVXnZ17cF534u
         SYYWahicyAy5reTzMSBh5dT9ZyCNzidGHsE+IQQerc1JC9CO+Uuun0/nIMqJhc53AS
         +ICvlmvPDaD0RnR0X55ffX+oB++R01NKXbCKVFFW+AjKTj168/0BHjYxMgBvHYeDc8
         fWs/b6S7jP8PA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dw_bt1: fix MUX_MMIO dependencies
Date:   Thu, 15 Dec 2022 17:52:34 +0100
Message-Id: <20221215165247.1723462-1-arnd@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Selecting a symbol with additional dependencies requires
adding the same dependency here:

WARNING: unmet direct dependencies detected for MUX_MMIO
  Depends on [n]: MULTIPLEXER [=y] && OF [=n]
  Selected by [y]:
  - SPI_DW_BT1 [=y] && SPI [=y] && SPI_MASTER [=y] && SPI_DESIGNWARE [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])

Alternatively, we could drop this 'select' and require users to manually
put it into their .config as we do for other drivers.

Fixes: 7218838109fe ("spi: dw-bt1: Fix undefined devm_mux_control_get symbol")
Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3b1c0878bb85..1884e4083088 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -294,6 +294,7 @@ config SPI_DW_MMIO
 config SPI_DW_BT1
 	tristate "Baikal-T1 SPI driver for DW SPI core"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
+	depends on OF
 	select MULTIPLEXER
 	select MUX_MMIO
 	help
-- 
2.35.1

