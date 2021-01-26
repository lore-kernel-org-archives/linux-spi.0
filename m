Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CAFC4332B
	for <linux-spi@archiver.kernel.org>; Wed, 27 Jan 2021 13:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDC9207A3
	for <linux-spi@archiver.kernel.org>; Wed, 27 Jan 2021 13:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313732AbhAZWmg (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395057AbhAZTHt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 Jan 2021 14:07:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D9B5922228;
        Tue, 26 Jan 2021 19:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611688028;
        bh=hrKRaJ0folIsgpSOswzJs0BTbJYM+fV3ceV+e1S9cyw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CNerbn92HfAFwNdSyifPwE/ZpMcz5J/CWfMpuQIL0bPBr+kdL4kmLnHIabEVqLcxd
         0WVhq7zzxkbzvH09TXHYjjuD89QqUGmxxakLXYk3n1IFxwqkjyzlPkAd6er4OxzDRS
         LkKmMeWPBP/mn9lAA+rLhaHbonsRdar4fPLlrMokgzU+uJvomvnZiVcgSczeZqtYTV
         aw0wqzYnBajRmlJMzL0lo/BCY1TwEqn5wwNp/aH98TxCVPflZNxhZfBNhas/2TVk8a
         8i7N2wC8fzgNxMF8YuL7oDsXbovDp/qZ2XdXFwnJm+jB/01ZY/AFixQ71zLm8TiLks
         QAy0baMq/gv3A==
Subject: Re: [GIT PULL] SPI fixes for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210126124549.055F723122@mail.kernel.org>
References: <20210126124549.055F723122@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210126124549.055F723122@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.11-rc5
X-PR-Tracked-Commit-Id: 396cf2a46adddbf51373e16225c1d25254310046
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c7230a48ed5ebdda54867816303e974c154841d1
Message-Id: <161168802873.27611.13244511493591585866.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Jan 2021 19:07:08 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Tue, 26 Jan 2021 12:44:56 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c7230a48ed5ebdda54867816303e974c154841d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
