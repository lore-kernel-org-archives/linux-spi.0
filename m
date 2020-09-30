Return-Path: <SRS0=/X/+=DH=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA00C4727E
	for <linux-spi@archiver.kernel.org>; Wed, 30 Sep 2020 18:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A6342076B
	for <linux-spi@archiver.kernel.org>; Wed, 30 Sep 2020 18:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgI3Sz6 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 30 Sep 2020 14:55:58 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41720 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbgI3Sz6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:55:58 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9247980305E2;
        Wed, 30 Sep 2020 18:55:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vK1qjrlkNmOP; Wed, 30 Sep 2020 21:55:54 +0300 (MSK)
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
Subject: [PATCH v2 06/21] spi: dw: Update Rx sample delay in the config function
Date:   Wed, 30 Sep 2020 21:55:30 +0300
Message-ID: <20200930185545.29959-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Rx sample delay can be SPI device specific, and should be synchronously
initialized with the rest of the communication and peripheral device
related controller setups. So let's move the Rx-sample delay setup into
the DW APB SSI configuration update method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 478262fb4f8e..87c8f0028a23 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -294,13 +294,18 @@ static void dw_spi_update_config(struct dw_spi *dws, struct spi_device *spi,
 		spi_set_clk(dws, clk_div);
 		dws->current_freq = speed_hz;
 	}
+
+	/* Update RX sample delay if required */
+	if (dws->cur_rx_sample_dly != chip->rx_sample_dly) {
+		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, chip->rx_sample_dly);
+		dws->cur_rx_sample_dly = chip->rx_sample_dly;
+	}
 }
 
 static int dw_spi_transfer_one(struct spi_controller *master,
 		struct spi_device *spi, struct spi_transfer *transfer)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(master);
-	struct chip_data *chip = spi_get_ctldata(spi);
 	u8 imask = 0;
 	u16 txlevel = 0;
 	int ret;
@@ -326,12 +331,6 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	if (master->can_dma && master->can_dma(master, spi, transfer))
 		dws->dma_mapped = master->cur_msg_mapped;
 
-	/* Update RX sample delay if required */
-	if (dws->cur_rx_sample_dly != chip->rx_sample_dly) {
-		dw_writel(dws, DW_SPI_RX_SAMPLE_DLY, chip->rx_sample_dly);
-		dws->cur_rx_sample_dly = chip->rx_sample_dly;
-	}
-
 	/* For poll mode just disable all interrupts */
 	spi_mask_intr(dws, 0xff);
 
-- 
2.27.0

