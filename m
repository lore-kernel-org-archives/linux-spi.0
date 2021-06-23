Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560A1C4743C
	for <linux-spi@archiver.kernel.org>; Wed, 23 Jun 2021 18:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE0761185
	for <linux-spi@archiver.kernel.org>; Wed, 23 Jun 2021 18:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFWSwM (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWSwM (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 14:52:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 698B961185;
        Wed, 23 Jun 2021 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624474194;
        bh=cE/yYGsM87+1QKt8eBnCBcFwR2rD2QehJo8F9kMW/Qg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i25UakUSGgDfIUIafg0aduXPxXVFq5ChhgLX3Ia4oIMY+Ek/Tjzo9y+DizK6A0sFj
         fzbiczLCjgDKGce+puQgVbOhm7yzlwzH6UMQ5fT6MRB073nbkIueBA29NPUh3Cd3oA
         vdgT1NEyk3aMnyZUvCVfo9jB/o6HPUlTNin+Yrm6iwFQDI/ArmaeQ3nlJBj0fKkkPv
         WCE0MwhPyATTl+Z7bABGtIhbksr5suaXtJKkEthR6a8fIO6bIi6co2SJ4Kjr0i/KqK
         h0Sw1UB8PAodRFTTqHzXx2FOPcvvJPJA0k8x4tXI7alzaryj88hkjlYVvVBUEnu5pX
         8NWfmbaZoemRw==
Subject: Re: [GIT PULL] SPI fixes for v5.13-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210623170547.50531611AC@mail.kernel.org>
References: <20210623170547.50531611AC@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210623170547.50531611AC@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.13-rc7
X-PR-Tracked-Commit-Id: f422316c8e9d3c4aff3c56549dfb44a677d02f14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7426cedc7dad67bf3c71ea6cc29ab7822e1a453f
Message-Id: <162447419428.24381.4482906373355653945.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Jun 2021 18:49:54 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Wed, 23 Jun 2021 18:05:18 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7426cedc7dad67bf3c71ea6cc29ab7822e1a453f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
