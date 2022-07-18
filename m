Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D5CCA481
	for <linux-spi@archiver.kernel.org>; Mon, 18 Jul 2022 08:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiGRI1j (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbiGRI1h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Jul 2022 04:27:37 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F31118E00
        for <linux-spi@vger.kernel.org>; Mon, 18 Jul 2022 01:27:36 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id C6F831C811BE;
        Mon, 18 Jul 2022 16:12:36 +0800 (CST)
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Jul
 2022 16:12:36 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 18 Jul 2022 16:12:36 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 814C563A20; Mon, 18 Jul 2022 11:12:35 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 0/3] spi: npcm-fiu: add Arbel NPCM8XX support
Date:   Mon, 18 Jul 2022 11:11:43 +0300
Message-ID: <20220718081146.256070-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch set adds Arbel NPCM8XX Flash Interface Unit (FIU) support to FIU NPCM
driver and modify direct read dummy configuration.

NPCM8XX FIU supports four controllers.

The NPCM FIU driver tested on NPCM845 evaluation board.

Tomer Maimon (3):
  spi: npcm-fiu: Modify direct read dummy configuration
  dt-binding: spi: Add npcm845 compatible to npcm-fiu document
  spi: npcm-fiu: Add NPCM8XX support

 .../bindings/spi/nuvoton,npcm-fiu.txt         | 13 ++++++++-
 drivers/spi/spi-npcm-fiu.c                    | 28 +++++++++++++++++--
 2 files changed, 38 insertions(+), 3 deletions(-)

-- 
2.33.0

