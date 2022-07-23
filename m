Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076F1C43334
	for <linux-spi@archiver.kernel.org>; Sat, 23 Jul 2022 17:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbiGWRjy (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 23 Jul 2022 13:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238438AbiGWRjw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 23 Jul 2022 13:39:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCB51EEE0;
        Sat, 23 Jul 2022 10:39:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4824CB80D14;
        Sat, 23 Jul 2022 17:39:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08AE3C341C7;
        Sat, 23 Jul 2022 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658597989;
        bh=hwDAKAk6i7Wr3vgNlTgX7ANW/JyE4NCFl/UAssaFIeY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ENeMA0TWX1wgygDKw582M4ROP/f3s0pd4kT5wk0oKAHj8w30Wry1aEH5e9UfDrL2N
         /Sa/dTGj7trKgE0xcJY6kXCbGIivLACwxeEsXerb9Z2o2Ty3c6IoyNF9tmgCLlVVZa
         zQuZWBEiZ7iSvqcfK3lALST8+tQaL6yC8Ye7vw/I3NkBVT+EoE6VeXkycEw/7VwPA9
         HB1W0NxUOth0/RJf7AyzayCCF+DXsegA8ekcOE31CvHJKyGww3bcOeqVWu7JIQDoEA
         ujXiUAhHTFbFK/FZNiU0IQ5KDfdNNDsknRwKs8cKDvxJ60rdU5BH7sqhxG07j2tRCe
         Kg0xjSORuZBYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E10CCD9DDDD;
        Sat, 23 Jul 2022 17:39:48 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220722221236.EDF49C341C6@smtp.kernel.org>
References: <20220722221236.EDF49C341C6@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220722221236.EDF49C341C6@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc7
X-PR-Tracked-Commit-Id: b620aa3a7be346f04ae7789b165937615c6ee8d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 301c8949322fe46766b334cc60ada5819b92000e
Message-Id: <165859798891.12882.16074708628854918835.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Jul 2022 17:39:48 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Fri, 22 Jul 2022 23:12:27 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/301c8949322fe46766b334cc60ada5819b92000e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
