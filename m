Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890B4C6FA92
	for <linux-spi@archiver.kernel.org>; Fri, 16 Sep 2022 11:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbiIPLj7 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 16 Sep 2022 07:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiIPLj5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Sep 2022 07:39:57 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058E329CAA;
        Fri, 16 Sep 2022 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663328395;
  x=1694864395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vf3z5znW0KooHgZEWacieLyXs7JGdr3NGOK/5vrCD1M=;
  b=eFy+FW6CHrDWf1kO4Y3dIcd4NPx0J4mm+wXoPThFKfHkvERl1A7zD7ij
   3b1SFjJ0lcT2R39ytQ5GY4vnH6GEzbUPo4/T+Ytn4Rc6W31WEMm1pkUey
   mivygkCkkv0oJun6VFxS4W3YuCo1MvCNtqr+Zr+kfOUGmKLPDJiZN8Zs3
   UaINdzhG4flDqT5HlI3Q5sE30KNAnizc5oEPEHnAI2aFKxbTkEsYUbmwM
   /vfPauScaAR/FYcg+BAf36ZwiXaLgSdjdv13icUCY3AIR7+XtkOSiSwuq
   Fb9PPmBsLtkhBGDNeOHHnh1ShJdVwltxvFKAZjOlOVSnrtS5HuASMbRF+
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <broonie@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <andi@etezian.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <alim.akhtar@samsung.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/4] spi: Fix DMA bugs in (not only) spi-s3c64xx
Date:   Fri, 16 Sep 2022 13:39:47 +0200
Message-ID: <20220916113951.228398-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series fixes some bugs I found while running spi-loopback-test with
spi-s3c64xx.  The first problem (which I actually noticed while trying to fix
the second problem with transfers >64KiB) seems to be a generic issue which
affects several drivers so I fixed it in the core.

The series has been tested on ARTPEC-8, which has a version of the IP similar
to Exynos 7 and with 64 byte FIFOs (compatible with "tesla,fsd-spi").

Cc: alim.akhtar@samsung.com
Cc: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Vincent Whitchurch (4):
  spi: spi-loopback-test: Add test to trigger DMA/PIO mixing
  spi: Save current RX and TX DMA devices
  spi: Fix cache corruption due to DMA/PIO overlap
  spi: s3c64xx: Fix large transfers with DMA

 drivers/spi/spi-loopback-test.c |  27 +++++++
 drivers/spi/spi-s3c64xx.c       |  10 +++
 drivers/spi/spi.c               | 126 +++++++++++++++++++++++---------
 include/linux/spi/spi.h         |   4 +
 4 files changed, 131 insertions(+), 36 deletions(-)

-- 
2.34.1

