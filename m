Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE54CC3E8C5
	for <linux-spi@archiver.kernel.org>; Fri, 27 Nov 2020 23:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643612223D
	for <linux-spi@archiver.kernel.org>; Fri, 27 Nov 2020 23:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dw+CuJ1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgK0XSt (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 27 Nov 2020 18:18:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731271AbgK0UFt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 27 Nov 2020 15:05:49 -0500
Subject: Re: [GIT PULL] SPI fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606507548;
        bh=gaNdrtDVpvvUUpeTraskkOzhGXBobyv4I+eAOJomzz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dw+CuJ1fEPTsSwWBgqX1iBlU7ZnGaQhpb9nCI3nUufjavtS7KPHCBF1YZvOjNSCi4
         AYZKBSiCpVEHPcZneExpcvlW0LrBsS+Gsi/ZGdlD5EicxCePQLM8epHxZfcrXD8NKM
         CZXryfNYyEu4w5+W19V4BR6/lcqAxtoJOwvlbzvc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201127134907.9C8BA221EB@mail.kernel.org>
References: <20201127134907.9C8BA221EB@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201127134907.9C8BA221EB@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc5
X-PR-Tracked-Commit-Id: 0abdb0fba07322ce960d32a92a64847b3009b2e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87c301ca911a3bee68900ee475fe536eebd9bc41
Message-Id: <160650754868.29509.13798181312817622509.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 20:05:48 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 13:48:29 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87c301ca911a3bee68900ee475fe536eebd9bc41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
