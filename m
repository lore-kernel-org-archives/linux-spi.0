Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE923C4742C
	for <linux-spi@archiver.kernel.org>; Mon, 16 Nov 2020 04:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD5422284
	for <linux-spi@archiver.kernel.org>; Mon, 16 Nov 2020 04:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qsVK+TlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKPEHc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 15 Nov 2020 23:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgKPEHb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 15 Nov 2020 23:07:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82496C0613CF;
        Sun, 15 Nov 2020 20:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=g+rNn3zM3a12w/t9GtWhFg2RLsV2JGh9kKYmYsZ9uYI=; b=qsVK+TlMlygjbWnwfW+4oOHRUv
        6COVrF2m0nZtjU/j+FtJ/OtuhGarO0g0xDWTBeH7hGCxRafYT99uE1Kc+qWJGWLdeTbgrMjL/zKi8
        pm/QEfe4tLESsx1KqLLEnsGx+Wzel9zAV4mY01f07XwLHI2Mi2fJ9mOHsUrEZ8i2G4jyFmubVCfzz
        xuoxTU/SX/1Yb5cLhoVQFAUdHxEsOKtJhsM96LtcjkDvJOE33gdBirQRdwzb5cPa+gWrKsAFmMilv
        9S+8nRfxnMLtaJ6AyXGlF/GXdnin4y6FBs8F62XC4+MlKCrfwFV0f1MkaI+rAab5HHAfPDD4eSuKB
        UYRfw/6w==;
Received: from [2601:1c0:6280:3f0::f32] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keVna-0003aM-Ft; Mon, 16 Nov 2020 04:07:27 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH] spi: dw: fix build error by selecting MULTIPLEXER
Date:   Sun, 15 Nov 2020 20:07:21 -0800
Message-Id: <20201116040721.8001-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix build error for spi-dw-bt1.o by selecting MULTIPLEXER.

hppa-linux-ld: drivers/spi/spi-dw-bt1.o: in function `dw_spi_bt1_sys_init':
(.text+0x1ac): undefined reference to `devm_mux_control_get'

Fixes: abf00907538e ("spi: dw: Add Baikal-T1 SPI Controller glue driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
 drivers/spi/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20201113.orig/drivers/spi/Kconfig
+++ linux-next-20201113/drivers/spi/Kconfig
@@ -255,6 +255,7 @@ config SPI_DW_MMIO
 config SPI_DW_BT1
 	tristate "Baikal-T1 SPI driver for DW SPI core"
 	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
+	select MULTIPLEXER
 	help
 	  Baikal-T1 SoC is equipped with three DW APB SSI-based MMIO SPI
 	  controllers. Two of them are pretty much normal: with IRQ, DMA,
