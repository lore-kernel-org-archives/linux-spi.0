Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC5EC87FDC
	for <linux-spi@archiver.kernel.org>; Wed,  7 Jun 2023 17:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjFGRaf (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 7 Jun 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjFGRa0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jun 2023 13:30:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D22100
        for <linux-spi@vger.kernel.org>; Wed,  7 Jun 2023 10:30:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D73EA63BC1
        for <linux-spi@vger.kernel.org>; Wed,  7 Jun 2023 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4777AC433D2;
        Wed,  7 Jun 2023 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686159023;
        bh=4/4YGfWPnAH1CPeK7jx5pJdwbOTtHWDhpjmmb8LiUNA=;
        h=Subject:From:Date:To:From;
        b=q96scMYE4Rl2CovK8WCjn8++Wghz6ei25hAPCfXXpQr0JjBnnGO/tciQQ1GTJkqkO
         l6Krg9AdE1ggouKgRmyrPpdjgipxB/aFqGsyGu7ccL3yL7BYGNPkfbkGVbLPaUx68s
         9WiXhevyBcKSgmi0AojD0ObLHGhDOGIX7SX1zBsjWcdsWIp/u1f627GE3uh8OWt0o/
         eXEytxOdlhUGg/KEWTemnWhMCP6w4nGjgG8jrv7VK0pce28m8fh9AApghnmNM0abVB
         5LIfBpAa8PeXefryAq5VHAWNfFLk315HWM/D9UP3oND21SsXPgKH7Hx+DPfPuyoclQ
         WnENtIg2hU4Ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22F03E29F37;
        Wed,  7 Jun 2023 17:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168615902308.7521.8564491970447190431.git-patchwork-summary@kernel.org>
Date:   Wed, 07 Jun 2023 17:30:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: s3c64xx: Cleanups
  Submitter: Andi Shyti <andi.shyti@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=754228
  Lore link: https://lore.kernel.org/r/20230606012051.2139333-1-andi.shyti@kernel.org
    Patches: [1/2] spi: s3c64xx: Use the managed spi master allocation function
             [2/2] spi: s3c64xx: Use dev_err_probe()

Patch: spi: dw: Remove misleading comment for Mount Evans SoC
  Submitter: Abe Kohandel <abe.kohandel@intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=754661
  Lore link: https://lore.kernel.org/r/20230606231844.726272-1-abe.kohandel@intel.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


