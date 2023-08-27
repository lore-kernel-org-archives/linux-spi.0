Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115AC83F12
	for <linux-spi@archiver.kernel.org>; Sun, 27 Aug 2023 15:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjH0PiN (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 27 Aug 2023 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjH0PiK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Aug 2023 11:38:10 -0400
X-Greylist: delayed 387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Aug 2023 08:38:07 PDT
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40FCFC;
        Sun, 27 Aug 2023 08:38:07 -0700 (PDT)
From:   Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1693150298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9CFlQknagNZ7xplVnx26WwbwbBId9FT6aSVcWnKANcA=;
        b=v7OvgJHrAZz+KB7S5cz0VREbnwljDRmKtVndhFB7GX0A2ygw0nsnk4an25vdjUhKvS87Kt
        v4BTHtHkoWDSZlf6Poin1dt/3QK8FHLY0WNN/s6tnztm2WaRpqbStPx4I2Wlhwm0YXphap
        BLdcfbJzW6hF0SLx2m6GCRfmRRnvQ74BpxgwH5z8E8ajnwjGby7jb7TsvyJDo286ynHxat
        MBhlxm3OXABZP4/2hwKDI4pFfIbMXU7kDFmkS2uHDmZkLVsroaQyzY7ycdEHAnQd6npbCe
        JCFyFu8cH2luBk9BiRbIpfuENHgc4g5atvSXguv+DKDyZmSUn0MLH2p6dmkdjQ==
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-spi@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 1/2] spi: sun6i: reduce DMA RX transfer width to single byte
Date:   Sun, 27 Aug 2023 17:25:57 +0200
Message-ID: <20230827152558.5368-2-t.schramm@manjaro.org>
In-Reply-To: <20230827152558.5368-1-t.schramm@manjaro.org>
References: <20230827152558.5368-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Through empirical testing it has been determined that sometimes RX SPI
transfers with DMA enabled return corrupted data. This is down to single
or even multiple bytes lost during DMA transfer from SPI peripheral to
memory. It seems the RX FIFO within the SPI peripheral can become
confused when performing bus read accesses wider than a single byte to it
during an active SPI transfer.

This patch reduces the width of individual DMA read accesses to the
RX FIFO to a single byte to mitigate that issue.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/spi/spi-sun6i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 30d541612253..8fcb2696ec09 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -207,7 +207,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 		struct dma_slave_config rxconf = {
 			.direction = DMA_DEV_TO_MEM,
 			.src_addr = sspi->dma_addr_rx,
-			.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+			.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
 			.src_maxburst = 8,
 		};
 
-- 
2.42.0

