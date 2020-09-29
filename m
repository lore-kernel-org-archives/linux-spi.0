Return-Path: <SRS0=d3ll=DG=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E604C4727C
	for <linux-spi@archiver.kernel.org>; Tue, 29 Sep 2020 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D64121548
	for <linux-spi@archiver.kernel.org>; Tue, 29 Sep 2020 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601397006;
	bh=J/lMynbpoPvK7JvhBErCrseqc7BLywCz7NU96/lvIII=;
	h=Subject:From:Date:To:List-ID:From;
	b=ViPA4vDlFKpsTblzk+SwCoIC3Fdsg+et7cDkS8szCb+RWaIhy9p3x15vgqzXaJhcF
	 /GcgI/f3XY39MIKn0EIxBVzP2/2isFmiPDWCY2YFASYOgCCDb4JEA0/g9wOFNRdnN+
	 CugekfSHGzqAk4NdezVj0a9w3fMyuP21YGbf2Gr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgI2QaF (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 29 Sep 2020 12:30:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbgI2QaF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Sep 2020 12:30:05 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601397005;
        bh=J/lMynbpoPvK7JvhBErCrseqc7BLywCz7NU96/lvIII=;
        h=Subject:From:Date:To:From;
        b=qeovbZ6yKGXTVYemqhnYw+BJ1Hh4EsUPtWWP84l0cKPbaWd29Xb/QveTv0wAX0Hhf
         IazS4W33nOkqPO8KesKhUKXJAIrlxOGEX6pT8o+HxYYf0UY8Py6eVrUWdoOFqFqjE2
         +fkI59LC0DE+GXCLQa30JkgHJB1IBH9SpUOxE5k4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160139700504.26335.4321994456335317885.git-patchwork-summary@kernel.org>
Date:   Tue, 29 Sep 2020 16:30:05 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: dw-dma: Add max SG entries burst capability support
  Submitter: Serge Semin <Sergey.Semin@baikalelectronics.ru>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=352151
  Lore link: https://lore.kernel.org/r/20200920112322.24585-1-Sergey.Semin@baikalelectronics.ru
    Patches: [v2,01/11] spi: dw-dma: Set DMA Level registers on init
             [v2,02/11] spi: dw-dma: Fail DMA-based transfer if no Tx-buffer specified
             [v2,03/11] spi: dw-dma: Configure the DMA channels in dma_setup
             [v2,04/11] spi: dw-dma: Check rx_buf availability in the xfer method
             [v2,05/11] spi: dw-dma: Move DMA transfers submission to the channels prep methods
             [v2,06/11] spi: dw-dma: Check DMA Tx-desc submission status
             [v2,07/11] spi: dw-dma: Remove DMA Tx-desc passing around
             [v2,08/11] spi: dw-dma: Detach DMA transfer into a dedicated method
             [v2,09/11] spi: dw-dma: Move DMAC register cleanup to DMA transfer method
             [v2,10/11] spi: dw-dma: Pass exact data to the DMA submit and wait methods
             [v2,11/11] spi: dw-dma: Add one-by-one SG list entries transfer

Total patches: 11

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


