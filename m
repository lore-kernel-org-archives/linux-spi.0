Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D450EC00140
	for <linux-spi@archiver.kernel.org>; Tue,  2 Aug 2022 18:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiHBSDN (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 2 Aug 2022 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiHBSC7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Aug 2022 14:02:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3CA1D4;
        Tue,  2 Aug 2022 11:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54A5FB81EC5;
        Tue,  2 Aug 2022 18:02:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE90EC433B5;
        Tue,  2 Aug 2022 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659463366;
        bh=CsKzgBUAnJtmMUm1ftRS3DG1tc4yHRK0xI3jqseiPRw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F23DVrdResjqO8YZOlpezer1dsdxUAuMWlEjMHQGjYpTr2EhCCfcncupWuSNeGrus
         AvUHLNy89R2hEFtEISmPSAVZLjkcQtnsm0dYZIXE+O2xl+smXyPrRNo01DSUfcJK5t
         90399nQkG+Mu+Fvq8rX4xpm/bYXKN+z8BorU5Unzp2lUIn1FBDg6DbtH0Kh8kUo7Ce
         UCVMZP6POE5HGAhV427BWwNvXYmqtUZmKcfl3qRiHHy2I4VvvAHQgYg9uMbX2F3Ac6
         SnmlIRWz93NuuRc1GWNANwTfi3G+DGmwP+9EkDnk/XaQEjXej6J9Nk5n0oHzpEHvQ2
         CYWKPPwT6fVJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE0FBC43142;
        Tue,  2 Aug 2022 18:02:45 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v5.20
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220801123832.C1E2EC433D6@smtp.kernel.org>
References: <20220801123832.C1E2EC433D6@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220801123832.C1E2EC433D6@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.20
X-PR-Tracked-Commit-Id: 69243df953e70c134c6735b31ba0e658c53d3cda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0805c6fb39f66e01cb0adccfae8d9e0615c70fd7
Message-Id: <165946336590.14716.5030821823359863715.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Aug 2022 18:02:45 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 01 Aug 2022 13:38:22 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0805c6fb39f66e01cb0adccfae8d9e0615c70fd7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
