Return-Path: <SRS0=1/NZ=EL=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8461DC388F7
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 20:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315FD20735
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 20:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604607728;
	bh=IpJ0HSqfBID4Y4qMCiMz0GDRwmasiMsoz8K9vgKW8qU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pBWMBW32lz9o20/k/IUtcNr3JK9371VnwWejyqNw65jxSH9RWbA4ctPql9pe530Gh
	 2sAj3ve0QuLPP2/Or6O5kKjQaKlFwJ5Epko4+0qMov8/6ZhaIfs6cZBetcO6nv/yW6
	 1HimdR5Jp3uuHPBBYl8tipadO0VsgKtNhZiSdrIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbgKEUWG (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 5 Nov 2020 15:22:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732176AbgKEUVX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 15:21:23 -0500
Subject: Re: [GIT PULL] SPI fixes for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604607682;
        bh=IpJ0HSqfBID4Y4qMCiMz0GDRwmasiMsoz8K9vgKW8qU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pxTnKTtNIVAbQ6ioXGO2S/DTbzVGbiwp3jOSBkN5XZnIwN3udhn4eU3JHUfRyO9ga
         hQWdBhASfwUVn0njJhNrzQvaUN9IA1SRV+NTb0yswREM9B65IpQLlyqZQd0qA3jrMa
         wpFS7M8+jFa4rBvbaPgpYS/ypZXtXHSNkd8JWcfI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201105164607.AD20021734@mail.kernel.org>
References: <20201105164607.AD20021734@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201105164607.AD20021734@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc2
X-PR-Tracked-Commit-Id: 9bd77a9ce31dd242fece27219d14fbee5068dd85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf26c714874c14941953f6658ef85d7ce3446a0a
Message-Id: <160460768293.18865.4491543128747188328.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Nov 2020 20:21:22 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Thu, 05 Nov 2020 16:45:46 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf26c714874c14941953f6658ef85d7ce3446a0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
