Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF2AC001B0
	for <linux-spi@archiver.kernel.org>; Sat, 15 Jul 2023 15:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGOP5h (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 15 Jul 2023 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjGOP5g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 15 Jul 2023 11:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145492D7B;
        Sat, 15 Jul 2023 08:57:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A724260BC5;
        Sat, 15 Jul 2023 15:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14744C433CB;
        Sat, 15 Jul 2023 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689436655;
        bh=RWJwEhnf9ue0Z+WjssyNBHzxXS5l1v9lxxuTPPH+4Y4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QXWDWAmMz4KGHGg0K/gKMR316/TumTdW2hhoWLFR1Lit0/i838bJWpL5FK072GfSy
         AopyzVgTwBenha5kWuEbgsugyer8rLhV4rLC/0k3IS64Te1LdGuykRgYZ3a0zNcD0z
         RAnZzcUE3WWigMKNiR149Z/stFRz7FWAkwrxLeSXod8EhYibAKRz7YX6dSu3igAg6G
         0g10+j+y0bXo7GXV7M4UJ0kBmyjGCxBDidIf97yiLKL0NW55TxbW4QcovJAURq+Gg2
         UErn9UzPDZz1X9/jyXm2aBCG/fsACGcje0Es2QhUzdVxbz1R0hekB7vgDEEd5VziEx
         1sYHwxf7jsbvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EFE29E4508D;
        Sat, 15 Jul 2023 15:57:34 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230715115326.333B8C433C8@smtp.kernel.org>
References: <20230715115326.333B8C433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230715115326.333B8C433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc1
X-PR-Tracked-Commit-Id: 54ccc8758ef4d29de9e8fdb711c852abbdd4103a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 831fe284d8275987596b7d640518dddba5735f61
Message-Id: <168943665497.17130.8459550455688557328.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jul 2023 15:57:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Sat, 15 Jul 2023 12:53:19 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/831fe284d8275987596b7d640518dddba5735f61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
