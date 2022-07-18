Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A24C433EF
	for <linux-spi@archiver.kernel.org>; Mon, 18 Jul 2022 08:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiGRI1i (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 18 Jul 2022 04:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiGRI1h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Jul 2022 04:27:37 -0400
X-Greylist: delayed 899 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 01:27:36 PDT
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0311718B34
        for <linux-spi@vger.kernel.org>; Mon, 18 Jul 2022 01:27:36 -0700 (PDT)
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
        by maillog.nuvoton.com (Postfix) with ESMTP id 06F8A1C811BD;
        Mon, 18 Jul 2022 16:12:38 +0800 (CST)
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 18 Jul
 2022 16:12:37 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Mon, 18 Jul 2022 16:12:37 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id AF8FE63A4C; Mon, 18 Jul 2022 11:12:36 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/3] spi: npcm-fiu: Modify direct read dummy configuration
Date:   Mon, 18 Jul 2022 11:11:44 +0300
Message-ID: <20220718081146.256070-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220718081146.256070-1-tmaimon77@gmail.com>
References: <20220718081146.256070-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Modify NPCM BMC FIU direct read dummy configuration that according
spi-mem direct read function.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-fiu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index ba67dbed9fb8..d5b4fe7b9b62 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -252,8 +252,7 @@ static void npcm_fiu_set_drd(struct npcm_fiu_spi *fiu,
 	fiu->drd_op.addr.buswidth = op->addr.buswidth;
 	regmap_update_bits(fiu->regmap, NPCM_FIU_DRD_CFG,
 			   NPCM_FIU_DRD_CFG_DBW,
-			   ((op->dummy.nbytes * ilog2(op->addr.buswidth)) / BITS_PER_BYTE)
-			   << NPCM_FIU_DRD_DBW_SHIFT);
+			   op->dummy.nbytes << NPCM_FIU_DRD_DBW_SHIFT);
 	fiu->drd_op.dummy.nbytes = op->dummy.nbytes;
 	regmap_update_bits(fiu->regmap, NPCM_FIU_DRD_CFG,
 			   NPCM_FIU_DRD_CFG_RDCMD, op->cmd.opcode);
-- 
2.33.0

