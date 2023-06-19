Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A6BEB64D9
	for <linux-spi@archiver.kernel.org>; Mon, 19 Jun 2023 15:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjFSPyD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 19 Jun 2023 11:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFSPyC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Jun 2023 11:54:02 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB1BE63
        for <linux-spi@vger.kernel.org>; Mon, 19 Jun 2023 08:53:55 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687190034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O1eIJeAVog5amjj66j1E1EeTqm3rvg0ZXdAJ8CVTp74=;
        b=Sm1fulgrRfC0KJDlLgvDwIiuncg9hgnic30gNPkplmsPm34Bzb1ZizeclCE/9TamYqKK03
        IzpJSojjsEfgWGHpvTQw/SyWMwFgCX+sHjMVE5VoPDacqfWOVzIoHXdpqRM9lMZP102Hd7
        6sMkUgtuq49Xhx/D15U/VHidcMOF6kYfAHgn9hbktsoOF0lL0GPrwZAlJWYv9FJaqkrx0S
        iUle7yx3bEzoiLWAB6Lo8EiSUwLzFCexNkp7rp31Y1arI11PJ/wWhwos6320UokkGWFKWR
        SFsZKqunY9OD86qK+2UvBdIBDG9Y+Dx2ILe3KEfOkfyYffzkgPPSnBrseswxUA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45F2A1BF20A;
        Mon, 19 Jun 2023 15:53:50 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/3] spi: Helper for deriving timeout values
Date:   Mon, 19 Jun 2023 17:53:46 +0200
Message-Id: <20230619155349.3118420-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

I recently came across an issue with the Atmel spi controller driver
which would stop my transfers after a too small timeout when performing
big transfers (reading a 4MiB flash in one transfer). My initial idea
was to derive a the maximum amount of time a transfer would take
depending on its size and use that as value to avoid erroring-out when
not relevant. Mark wanted to go further by creating a core helper doing
that, based on the heuristics from the sun6i driver.

Here is a small series of 3 patches doing exactly that.

Cheers,
Miquèl

Miquel Raynal (3):
  spi: Create a helper to derive adaptive timeouts
  spi: atmel: Prevent false timeouts on long transfers
  spi: sun6i: Use the new helper to derive the xfer timeout value

 drivers/spi/spi-atmel.c | 18 +++++++++++-------
 drivers/spi/spi-sun6i.c |  2 +-
 include/linux/spi/spi.h | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 8 deletions(-)

-- 
2.34.1

