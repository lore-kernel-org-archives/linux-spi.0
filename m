Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42379C83F14
	for <linux-spi@archiver.kernel.org>; Sun, 27 Aug 2023 15:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjH0PiN (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 27 Aug 2023 11:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjH0PiK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Aug 2023 11:38:10 -0400
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Aug 2023 08:38:07 PDT
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E283813E;
        Sun, 27 Aug 2023 08:38:07 -0700 (PDT)
From:   Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1693150298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mJCkXIySq/iFwmfrnE/7WGXMl038R0X4mESkOBP9McM=;
        b=ANMbIKdmPXocR5EkhrkUzYxoOrMxxM1/7bTNikyISMQHIxWNLZGCWI6z3+gLCYY8ovEtXs
        IH0ROBJDGc2fplCKlFxUTaftE/lS7roa2C2s8yfIQb/bpTgv2ZZSPs4UIu3W/Z/tkiPkY6
        4FtoQRXwh+3k9gw4l8rTfUHF9deJwCjuYl1Ryy7XskcSN+Rbpn99AjZFEhkWf7Od7nmjPQ
        bIJB+fjh4rB2fqfgcbQKLpbaJxv5SQr6ifZBaHYSRTotuq9BlOOHo6FUa+a8q0yaOGSkBo
        NhR+CmGbBlzO2BxzghQfQEttJo2IIyQtYMKQWYe37dPOV8o1ndBuuXAFzgM2fA==
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-spi@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH 0/2] spi: sun6i: fix RX data corruption in DMA mode
Date:   Sun, 27 Aug 2023 17:25:56 +0200
Message-ID: <20230827152558.5368-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hey folks,

this set of patches fixes two bugs in the sun6i SPI driver that result in
corruption of received data in DMA RX mode.

The first bug seems to be related to an incompatibility of the SPI RX FIFO
with wider than single byte read accesses during SPI transfers. I'm not
sure if this bug affects all types of SPI controllers found in Allwinner
SoCs supported by this driver. However reducing the access width should
always be safe. I've tested this change on a V3s SoC. Further testing to
narrow down the set of affected SoCs in the future would be welcome.

The second bug is a race between SPI RX DMA and FIFO drain logic for
interrupt-based SPI operation. This bug affects all SPI controllers
supported by this driver. Once again this change has been tested on the
Allwinner V3s SoC.

Tobias Schramm (2):
  spi: sun6i: reduce DMA RX transfer width to single byte
  spi: sun6i: fix race between DMA RX transfer completion and RX FIFO
    drain

 drivers/spi/spi-sun6i.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

-- 
2.42.0

