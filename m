Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25241C433F5
	for <linux-spi@archiver.kernel.org>; Thu,  7 Apr 2022 15:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345235AbiDGP6d (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiDGP6b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 11:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E6CC535
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 08:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4E4561E1D
        for <linux-spi@vger.kernel.org>; Thu,  7 Apr 2022 15:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F41EC385A4;
        Thu,  7 Apr 2022 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649346990;
        bh=688PI3JbhCeZen+yChcsV8k7pUz4wQsvqNsynMArdNI=;
        h=Subject:From:Date:To:From;
        b=FDTehEKw0VGvp4Vv61mgupBi0D0pJkPh78DAjj7sIlWXt5mRYUidiCd0Vy/jLMHTE
         w1o5JC18c7CNSN1IVvWpX9I1R1JEXoMSR1T4mU8Wv/T8J6GeiApNQQ5xg8tpDTiCSI
         xOp0HiixN5p19erT0gVfc5TSe/unkG3bMNMQ+Z609NHD4O8XSOCjJGjW5tHIw5bg9n
         Kh2DS0FB69CCOdvygTb0gWRgON96aElJgJU+5yTT8yV/ggdD+FrVVxg9i8Tz+cpEAf
         Xlh5yVl/C1vFZO67H42z4n4XvnRFYiZNY9mtjASGvhRadddax48HlHgh/Vf++Oz1Np
         DMHhvAiIx8eNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5E94E85BCB;
        Thu,  7 Apr 2022 15:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164934698987.12620.17328487219055096960.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 07 Apr 2022 15:56:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: add support for Mediatek SPI-NAND controller (2022-04-07T15:06:47)
  Superseding: [v3] spi: add support for Mediatek SPI-NAND controller (2022-04-04T13:18:13):
    [v3,1/5] mtd: nand: make mtk_ecc.c a separated module
    [v3,2/5] spi: add driver for MTK SPI NAND Flash Interface
    [v3,3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
    [v3,4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
    [v3,5/5] arm64: dts: mediatek: add mtk-snfi for mt7622


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

