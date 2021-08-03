Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BA1C4338F
	for <linux-spi@archiver.kernel.org>; Tue,  3 Aug 2021 02:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3864561038
	for <linux-spi@archiver.kernel.org>; Tue,  3 Aug 2021 02:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbhHCCa1 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 2 Aug 2021 22:30:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48608 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233395AbhHCCa1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Aug 2021 22:30:27 -0400
X-UUID: 87bf7c13d5594536b5013c2739468724-20210803
X-UUID: 87bf7c13d5594536b5013c2739468724-20210803
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1292195986; Tue, 03 Aug 2021 10:30:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 10:30:10 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 10:30:09 +0800
From:   Mason Zhang <Mason.Zhang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Laxman Dewangan <ldewangan@nvidia.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Mason Zhang <Mason.Zhang@mediatek.com>
Subject: [PATCH 1/1] spi: tegra114: Fix set_cs_timing param
Date:   Tue, 3 Aug 2021 10:13:29 +0800
Message-ID: <20210803021328.28291-1-Mason.Zhang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch fixed set_cs_timing param, because cs timing delay has
been moved to spi_device.

Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
---
 drivers/spi/spi-tegra114.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 5131141bbf0d..e9de1d958bbd 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -717,12 +717,12 @@ static void tegra_spi_deinit_dma_param(struct tegra_spi_data *tspi,
 	dma_release_channel(dma_chan);
 }
 
-static int tegra_spi_set_hw_cs_timing(struct spi_device *spi,
-				      struct spi_delay *setup,
-				      struct spi_delay *hold,
-				      struct spi_delay *inactive)
+static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
+	struct spi_delay *setup = &spi->cs_setup;
+	struct spi_delay *hold = &spi->cs_hold;
+	struct spi_delay *inactive = &spi->cs_inactive;
 	u8 setup_dly, hold_dly, inactive_dly;
 	u32 setup_hold;
 	u32 spi_cs_timing;
-- 
2.18.0

