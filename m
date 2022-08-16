Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBD8C25B0E
	for <linux-spi@archiver.kernel.org>; Tue, 16 Aug 2022 19:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiHPTVT (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiHPTVS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Aug 2022 15:21:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCAD80F53;
        Tue, 16 Aug 2022 12:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89364B81AC8;
        Tue, 16 Aug 2022 19:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EAD6C433D7;
        Tue, 16 Aug 2022 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660677674;
        bh=rqQmPKuzb5daA5RCPob+5rcVn2W7ybe8QvI6YIJDO3E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l0dZfbIkhuB8AlPUuvD0geY5Laq02s/CHu285rGn7/DkgwatbikvlbzlBL7xdKuC4
         xq6gu/nevxWpKHpo/HHljO5/qrg0lyo+4KkWQvLBS3xUGrK9+jY/+vrXbn/ty/eNSl
         jx1UpmKNmGel0nTFp8+J9KdTfRIsr4Z1uT4cMCT2rsoHuZ24WeqhL0xWr+IG145gJI
         IqzDafbpmj5sOGB29ZEz4vKj8LmQShvpiBT21FwP2tQLE1JsVCc8rCXBXr09kuTQjY
         iebZ5TEQdSHlUJYgnw+aQkYyM84hpOMr2rrrAph2Xhzv3jNsSv9yfpQZnuEqB1SOLT
         kumjIO3a1wQ2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2319EE2A04C;
        Tue, 16 Aug 2022 19:21:14 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220816112317.47721C433C1@smtp.kernel.org>
References: <20220816112317.47721C433C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220816112317.47721C433C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.0-rc1
X-PR-Tracked-Commit-Id: 2fd92c7b8fe2cfc634613dc093d0f507c7389ea8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 339800d50b411d617fb3298d478921e6626032e7
Message-Id: <166067767413.31662.688858607098166502.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Aug 2022 19:21:14 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Tue, 16 Aug 2022 12:23:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/339800d50b411d617fb3298d478921e6626032e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
