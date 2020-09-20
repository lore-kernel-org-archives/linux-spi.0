Return-Path: <SRS0=0Kns=C5=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67755C4346A
	for <linux-spi@archiver.kernel.org>; Sun, 20 Sep 2020 11:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA1520672
	for <linux-spi@archiver.kernel.org>; Sun, 20 Sep 2020 11:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgITLal (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:30:41 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53932 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgITL3w (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 33741800255E;
        Sun, 20 Sep 2020 11:29:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uBpfZlhmhcAO; Sun, 20 Sep 2020 14:29:38 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 23/30] spi: dw: Explicitly de-assert CS on SPI transfer completion
Date:   Sun, 20 Sep 2020 14:29:07 +0300
Message-ID: <20200920112914.26501-24-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

By design of the currently available native set_cs callback, the CS
de-assertion will be done only if it's required by the corresponding
controller capability. But in order to pre-fill the Tx FIFO buffer with
data during the SPI memory ops execution the SER register needs to be left
cleared before that. We'll also need a way to explicitly set and clear the
corresponding CS bit at a certain moment of the operation. Let's alter
the set_cs function then to also de-activate the CS, when it's required.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 65db4dd3ea8a..7a25ea6f4af6 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -100,7 +100,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	 */
 	if (cs_high == enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
-	else if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
+	else
 		dw_writel(dws, DW_SPI_SER, 0);
 }
 EXPORT_SYMBOL_GPL(dw_spi_set_cs);
-- 
2.27.0

