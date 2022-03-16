Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1812EC433EF
	for <linux-spi@archiver.kernel.org>; Wed, 16 Mar 2022 17:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbiCPRyk (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 16 Mar 2022 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiCPRyj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Mar 2022 13:54:39 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79DB52717E;
        Wed, 16 Mar 2022 10:53:23 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,187,1643641200"; 
   d="scan'208";a="114638884"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Mar 2022 02:53:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8119040C92AF;
        Thu, 17 Mar 2022 02:53:20 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] spi: Fix erroneous sgs value with min_t()
Date:   Wed, 16 Mar 2022 17:53:17 +0000
Message-Id: <20220316175317.465-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

While computing sgs in spi_map_buf(), the data type
used in min_t() for max_seg_size is 'unsigned int' where
as that of ctlr->max_dma_len is 'size_t'.

min_t(unsigned int,x,y) gives wrong results if one of x/y is
'size_t'

Consider the below examples on a 64-bit machine (ie size_t is
64-bits, and unsigned int is 32-bit).
    case 1) min_t(unsigned int, 5, 0x100000001);
    case 2) min_t(size_t, 5, 0x100000001);

Case 1 returns '1', where as case 2 returns '5'. As you can see
the result from case 1 is wrong.

This patch fixes the above issue by using the data type of the
parameters that are used in min_t with maximum data length.

Fixes: commit 1a4e53d2fc4f68aa ("spi: Fix invalid sgs value")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d96082dc3340..fb2896cdb3ce 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1019,10 +1019,10 @@ int spi_map_buf(struct spi_controller *ctlr, struct device *dev,
 	int i, ret;
 
 	if (vmalloced_buf || kmap_buf) {
-		desc_len = min_t(unsigned int, max_seg_size, PAGE_SIZE);
+		desc_len = min_t(unsigned long, max_seg_size, PAGE_SIZE);
 		sgs = DIV_ROUND_UP(len + offset_in_page(buf), desc_len);
 	} else if (virt_addr_valid(buf)) {
-		desc_len = min_t(unsigned int, max_seg_size, ctlr->max_dma_len);
+		desc_len = min_t(size_t, max_seg_size, ctlr->max_dma_len);
 		sgs = DIV_ROUND_UP(len, desc_len);
 	} else {
 		return -EINVAL;
-- 
2.17.1

