Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E3AC54E76
	for <linux-spi@archiver.kernel.org>; Fri, 17 Nov 2023 00:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjKQAU2 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 16 Nov 2023 19:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKQAU1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Nov 2023 19:20:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D859B8
        for <linux-spi@vger.kernel.org>; Thu, 16 Nov 2023 16:20:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1342BC433C7;
        Fri, 17 Nov 2023 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700180424;
        bh=vSMgtvzOv2vck+v6BNpJl2SkuPWSGaSVt/hkDiuJGGY=;
        h=Subject:From:Date:To:From;
        b=Za3G2nPcxFoSRt7yDNTMlXiVRQeerwQOkwjBWMPPdip2ndrAcpAF6EaE0Io25BdAd
         7obsZT21Qel6M4bp04HAjVGsxgqGlHtBmWhkLduJdu68kkplzAgvPrVGkML3iTb4Be
         CtO2eI9NeXbM+trhQMpYEU9OKJXQkxOPCAXXP9Eg33kqxreMVhBkS9y/Cl78DWgTPo
         Vnj46qlscV2FQBWXd4RsMtS3Pw0u2btWhkNs4yD2KVlgTKKOMvelKSgEO5k4XtoBYK
         g+Qa4aQf/bwSvek6wuRlENEvyD+gUP8WP/omyAYl9UF6gozUsFAv9f7VDXPrIFroQN
         XeeI1Fo4CBukw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFE0DC4166E;
        Fri, 17 Nov 2023 00:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <170018042385.7131.18021771160470987872.git-patchwork-summary@kernel.org>
Date:   Fri, 17 Nov 2023 00:20:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dt-bindings: renesas,rspi: Document RZ/Five SoC
  Submitter: Prabhakar <prabhakar.csengg@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=801433
  Lore link: https://lore.kernel.org/r/20231115205333.31076-1-prabhakar.mahadev-lad.rj@bp.renesas.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


