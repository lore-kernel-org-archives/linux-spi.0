Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADF1C77B6E
	for <linux-spi@archiver.kernel.org>; Fri, 14 Apr 2023 12:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDNM4o (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDNM4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 08:56:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D6393F7
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 05:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA7A60C8E
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 12:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD2A7C433EF;
        Fri, 14 Apr 2023 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681476999;
        bh=+hq36SMDDTw8Q4qjzZ5MT7/qLgPNKDs6M7I8WbNnnAY=;
        h=Subject:From:Date:To:From;
        b=fPlAWAy7P2HLU6V3A16wtVcJJPAOUdtxPGeTgBozlVR8bRhucmUFQcPDs56VjMgvx
         v4QekqMLrTfsM83laFEcN++rftErzGSFt8z62lmEZQJ1VcGYvZjRVpb0rWcR5tYIwj
         jaGrBVbC6wJcsRjVVzE1SylNKcRcn7PuSZZFhVs2l+SbKbKkcXvykrO968GwgBsKeM
         UVoCU85EurHM17lodlpDng1TzcH5ohWr0pKaz135JKCofIOrzGT8xxrGISlHB833sl
         YalEmC9tu2nU1doTDVSN2BX3GDEfhp/MB3A41SuDsA64UCl87ODKzsMRGPLRPAZNFA
         gZ/K0L5z++FAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2FCAE52441;
        Fri, 14 Apr 2023 12:56:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168147699958.15033.597486377405322232.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 14 Apr 2023 12:56:39 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: dw: DW SPI DMA Driver updates (2023-04-14T12:05:15)
  Superseding: [v5] spi: dw: DW SPI DMA Driver updates (2023-03-30T06:34:48):
    [v5,1/2] spi: dw: Add 32 bpw support to DW DMA Controller
    [v5,2/2] spi: dw: Add dma controller capability checks


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

