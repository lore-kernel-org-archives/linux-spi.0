Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7D0C433FE
	for <linux-spi@archiver.kernel.org>; Wed, 23 Nov 2022 19:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiKWTY1 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 23 Nov 2022 14:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbiKWTYY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Nov 2022 14:24:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD1AC604D;
        Wed, 23 Nov 2022 11:24:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F300B82465;
        Wed, 23 Nov 2022 19:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFA54C433D6;
        Wed, 23 Nov 2022 19:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669231460;
        bh=0Xv6hRd935ZkfNko0MKVnltSbedyCiqw414iUAfzvzE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TyjCnpF1jEctFcv9uvRqngj6SXPUwa5aSjdPivFrTkzgZQs28HfnSrbsoIgoSQBa1
         JGp/MC1UCMTIZ0/zEs5cM7Mcg19DZac9wQmRt1HdjuS12scHNFuCp0mE4tpK+wSHea
         8TJbf2FX6CfhLAZp/n2Yq0Iccjjm3NNO2UScjKBa0j96Z+MAKbm5c1wueNTYqG0vMC
         F9eLJWiMHH/qYTHcgCPNcO3SU/RZ7IBfKuWJHgdiQWIzlSK1mSLL/D4JRxUpdscxYs
         S4aefM17MmiGRestep+Ntmipbt62FH1csg950qx+juBTH28XRNN8rdEgF4use3WYj+
         pZRj4jWP8Ipjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8BF5C395ED;
        Wed, 23 Nov 2022 19:24:19 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221123160524.A4687C433C1@smtp.kernel.org>
References: <20221123160524.A4687C433C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221123160524.A4687C433C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc6
X-PR-Tracked-Commit-Id: e85e9e0d8cb759013d6474011c227f92e442d746
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4312098baf37ee17a8350725e6e0d0e8590252d4
Message-Id: <166923145988.2332.3821760036184874925.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Nov 2022 19:24:19 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Wed, 23 Nov 2022 16:04:59 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4312098baf37ee17a8350725e6e0d0e8590252d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
