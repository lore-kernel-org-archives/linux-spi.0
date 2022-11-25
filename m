Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E19FC4332F
	for <linux-spi@archiver.kernel.org>; Fri, 25 Nov 2022 15:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKYPKS (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 25 Nov 2022 10:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKYPKS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Nov 2022 10:10:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DE710FCB
        for <linux-spi@vger.kernel.org>; Fri, 25 Nov 2022 07:10:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CBD7624E5
        for <linux-spi@vger.kernel.org>; Fri, 25 Nov 2022 15:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6F41C433D6;
        Fri, 25 Nov 2022 15:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669389016;
        bh=NnD3U46PzyBzm9pEX9/doa4f3l9BCIGIEm9he0rIOsk=;
        h=Subject:From:Date:To:From;
        b=MCxJ4t192AOWmfZEIw9iT4H0p9V16yiA6vcBAUcamKU81twtxUFtMGiji33ZxyWJ2
         aanmI4DVZqNYZPHZRSPDkrfS6roX4O7Sr+j4H9JABtHzBqeJxOichBD3E19svGNf7X
         /O5wl6A8Z9HK3el4a8jBvfpKJb3+5oeVntJSSNbApcGErPNkTqcSlU9r6xAMpqYsfn
         40U5+TAg1ZjHkEh9S0FloE10DJaD3kjhawC6vFsKnZ87hsyUJNtkfZeVFQ21k6+Nxz
         RIey/5gAy7zM6s1gJmmgq4mTkirwS+F8+H76C1Ksr4wctNnKSJe0sTj+NHEyVWAlV7
         20VHdNOPquGFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9585AC395EC;
        Fri, 25 Nov 2022 15:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166938901656.26926.5516029398956521193.git-patchwork-summary@kernel.org>
Date:   Fri, 25 Nov 2022 15:10:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Nuvoton WPCM450 FIU SPI flash controller
  Submitter: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=698952
  Lore link: https://lore.kernel.org/r/20221124191400.287918-1-j.neuschaefer@gmx.net
    Patches: [v2,1/3] dt-bindings: spi: Add Nuvoton WPCM450 Flash Interface Unit (FIU)
             [v2,2/3] spi: wpcm-fiu: Add driver for Nuvoton WPCM450 Flash Interface Unit (FIU)
             [v2,3/3] spi: wpcm-fiu: Add direct map support


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


