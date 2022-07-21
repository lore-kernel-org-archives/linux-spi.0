Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A199C433EF
	for <linux-spi@archiver.kernel.org>; Thu, 21 Jul 2022 10:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiGUKPo (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 21 Jul 2022 06:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbiGUKPn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Jul 2022 06:15:43 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE5F42A407;
        Thu, 21 Jul 2022 03:15:41 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 397C21C8025C;
        Thu, 21 Jul 2022 18:15:40 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 21 Jul
 2022 18:15:40 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 21 Jul
 2022 18:15:39 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 21 Jul 2022 18:15:39 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id BBBEE63A23; Thu, 21 Jul 2022 13:15:38 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/2] spi: npcm-pspi: add Arbel NPCM8XX and full duplex support 
Date:   Thu, 21 Jul 2022 13:15:26 +0300
Message-ID: <20220721101528.118499-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch set add the following support to the NPCM Peripheral SPI (PSPI) 
driver:
 - Arbel NPCM8XX.
 - Full duplex.

The NPCM PSPI driver tested on NPCM845 evaluation board.

Tomer Maimon (2):
  spi: npcm-pspi: add full duplex support
  dt-binding: spi: npcm-pspi: Add npcm845 compatible

 .../bindings/spi/nuvoton,npcm-pspi.txt        |  3 +-
 drivers/spi/spi-npcm-pspi.c                   | 75 ++++++++-----------
 2 files changed, 32 insertions(+), 46 deletions(-)

-- 
2.33.0

