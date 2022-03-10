Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF01AC433F5
	for <linux-spi@archiver.kernel.org>; Thu, 10 Mar 2022 12:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbiCJM2U (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiCJM2S (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Mar 2022 07:28:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B941480F3;
        Thu, 10 Mar 2022 04:27:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98767B825DA;
        Thu, 10 Mar 2022 12:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67E36C340E8;
        Thu, 10 Mar 2022 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646915235;
        bh=Z8QfQl6nJlVUL/vP53XZWb1CeAJFi5c8MlGJGpw3eM0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G8IhIuWk5Y7/ATA6M4YX8f7musmCbZ0BWsSfaWv8LHB9ZzTeY/l0vD4Jh0BGdgcf6
         Qrbhm5lKwDkDICKICH/lyhA7fVaB+OeojJHiRxQ1Oc43BdnTX0U0dPPa1Y5jTHFv+1
         2qAeF/I3V1eaP502x/EMMOVNQudDe/Gbr7uKw9CQ1/u2V+uHyXRFTvAfyuKtJDXfmK
         7X9rKHbJN4rHgJ57blwJXcvoWvS4j4SWErjkB1M8rAXEG2zg9wOrGE6L7LMY6EI7vc
         OaxnteS9PhB9v74tQNKOXVkIlVwgJp8lJCzdsiyG5dpGR8zJ8rtgvq+7KnRIELdULJ
         GTZM6zoaCmxRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45C2BE6D3DE;
        Thu, 10 Mar 2022 12:27:15 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220310121327.63C6FC340E8@smtp.kernel.org>
References: <20220310121327.63C6FC340E8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220310121327.63C6FC340E8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.17-rc7
X-PR-Tracked-Commit-Id: 1a4e53d2fc4f68aa654ad96d13ad042e1a8e8a7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1db333d9a51f3459fba1bcaa564d95befe79f0b3
Message-Id: <164691523527.11941.16621770358112144313.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Mar 2022 12:27:15 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Thu, 10 Mar 2022 12:13:11 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.17-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1db333d9a51f3459fba1bcaa564d95befe79f0b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
