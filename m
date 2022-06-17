Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AA9C433EF
	for <linux-spi@archiver.kernel.org>; Fri, 17 Jun 2022 12:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiFQMm7 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbiFQMm7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Jun 2022 08:42:59 -0400
Received: from mail-m12736.qiye.163.com (mail-m12736.qiye.163.com [115.236.127.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAFD5FFA;
        Fri, 17 Jun 2022 05:42:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m12736.qiye.163.com (Hmail) with ESMTPA id EC3797E01CA;
        Fri, 17 Jun 2022 20:42:53 +0800 (CST)
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH] spi: rockchip: Unmask IRQ at the final to avoid preemption
Date:   Fri, 17 Jun 2022 20:42:51 +0800
Message-Id: <20220617124251.5051-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkkYVkoZHkJPHhhNTkNJTVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktITkhVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6EBw5MT09VkkSARY#Exg1
        Pk0wChlVSlVKTU5OT01CTExPT0NDVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
        QVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0xMNwY+
X-HM-Tid: 0a8171b01537b20fkuuuec3797e01ca
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Avoid pio_write process is preempted, resulting in abnormal state.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Signed-off-by: Jon <jon.lin@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a08215eb9e14..79242dc5272d 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -381,15 +381,18 @@ static int rockchip_spi_prepare_irq(struct rockchip_spi *rs,
 	rs->tx_left = rs->tx ? xfer->len / rs->n_bytes : 0;
 	rs->rx_left = xfer->len / rs->n_bytes;
 
-	if (rs->cs_inactive)
-		writel_relaxed(INT_RF_FULL | INT_CS_INACTIVE, rs->regs + ROCKCHIP_SPI_IMR);
-	else
-		writel_relaxed(INT_RF_FULL, rs->regs + ROCKCHIP_SPI_IMR);
+	writel_relaxed(0xffffffff, rs->regs + ROCKCHIP_SPI_ICR);
+
 	spi_enable_chip(rs, true);
 
 	if (rs->tx_left)
 		rockchip_spi_pio_writer(rs);
 
+	if (rs->cs_inactive)
+		writel_relaxed(INT_RF_FULL | INT_CS_INACTIVE, rs->regs + ROCKCHIP_SPI_IMR);
+	else
+		writel_relaxed(INT_RF_FULL, rs->regs + ROCKCHIP_SPI_IMR);
+
 	/* 1 means the transfer is in progress */
 	return 1;
 }
-- 
2.17.1

