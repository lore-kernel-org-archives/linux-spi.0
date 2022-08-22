Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8660CC28D13
	for <linux-spi@archiver.kernel.org>; Mon, 22 Aug 2022 18:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbiHVSaR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbiHVSaA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 22 Aug 2022 14:30:00 -0400
X-Greylist: delayed 610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 Aug 2022 11:29:47 PDT
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 071F3491D3
        for <linux-spi@vger.kernel.org>; Mon, 22 Aug 2022 11:29:47 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 1B1D7BB3;
        Mon, 22 Aug 2022 21:22:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 1B1D7BB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661192568;
        bh=F7InFFORhYfp3DTqBSPE91JChrglDc8nS1CHn+DU5tY=;
        h=From:To:CC:Subject:Date:From;
        b=GfiKEPSZLMCcEOBMLWhUKVTh7vsMy0SRFkvzdd4iHokOlNJuaPyJpXNFSKriHivPF
         N0VL0jIzIB6IzawXRdY2yYTiOuN9nDnW4QN/8n9RZsn+4ySD7VrbT2pLEScsS/nYrN
         aziGsPjtG5laDj2BScmG9mA5fJAM6lrqRnKQTabY=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 21:19:33 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: dw: Add deferred controller registration support
Date:   Mon, 22 Aug 2022 21:18:53 +0300
Message-ID: <20220822181853.23063-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It's pretty possible to have the spi_register_controller() method
returning -EPROBE_DEFER status in case, for instance, if the GPIOs used
for the CS implementation aren't ready to be requested due to the
corresponding platform devices still pending to be probed. Let's make sure
the DW SSI driver won't print error message in that case by calling the
dev_err_probe() function if the SPI-registration procedure exited with
a non-zero status.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index f87d97ccd2d6..99edddf9958b 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -955,7 +955,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 
 	ret = spi_register_controller(master);
 	if (ret) {
-		dev_err(&master->dev, "problem registering spi master\n");
+		dev_err_probe(dev, ret, "problem registering spi master\n");
 		goto err_dma_exit;
 	}
 
-- 
2.35.1

