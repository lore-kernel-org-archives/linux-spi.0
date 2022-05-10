Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375AEC433EF
	for <linux-spi@archiver.kernel.org>; Tue, 10 May 2022 11:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240985AbiEJL4U (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 10 May 2022 07:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiEJLz5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 May 2022 07:55:57 -0400
Received: from smtp124.ord1d.emailsrvr.com (smtp124.ord1d.emailsrvr.com [184.106.54.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A5526FA6C
        for <linux-spi@vger.kernel.org>; Tue, 10 May 2022 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1652183515;
        bh=Y7XVrzTmFweMl4M9yd6V2sX3igzni/Z2EKPpdqON66w=;
        h=From:To:Subject:Date:From;
        b=oTxXAGLRLil4V1PrT3u5Mk5wkcFrt9e6jHgQHsMMIEI7CLvTitP07wlZzONfFNRs2
         Y/d8UdeC6btUDaj4PxkzUKWUhVfIHJzxmzYq9gRi5d/299bYO+eMb14J7iKcxXEMIu
         DRCR3VRNEZKJ66C0X7BOevGgTnc/WnhdbvAWK3cQ=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp8.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id C08FDC005D;
        Tue, 10 May 2022 07:51:54 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 0/2] spi: cadence-quadspi: a couple of minor cleanups
Date:   Tue, 10 May 2022 12:51:39 +0100
Message-Id: <20220510115141.212779-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b75da69c-0230-413e-8e5d-188bceb56f6b-1-1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Just a couple of trivial source code cleanups.

Ian Abbott (2):
  spi: cadence-quadspi: Add missing blank line in
    cqspi_request_mmap_dma()
  spi: cadence-quadspi: remove unnecessary (void *) casts

 drivers/spi/spi-cadence-quadspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: ab38272e99730375c5db3db1c4cebf691a0550ab
-- 
2.35.1

