Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A4FEB64D9
	for <linux-spi@archiver.kernel.org>; Fri, 16 Jun 2023 03:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjFPDKX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Jun 2023 23:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbjFPDKV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 15 Jun 2023 23:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B295297F;
        Thu, 15 Jun 2023 20:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01F72626E2;
        Fri, 16 Jun 2023 03:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51800C433CB;
        Fri, 16 Jun 2023 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686885019;
        bh=UcNvclACoiI+QJfVHv1h9Z+SJO+hTeU6RhdvVRkCTOI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZJGtiIYJ7TPHlfIGymhLDl6Dg3Ig/nFfLvDNgqU651BiqhcUlGyaeZovuusBYyiNR
         I3UfeyjpUx3tyNw0D7mjoYyxkEZ5VJ6z+lCHV2KdSvQ8rYjSPAtVkjlShgJeHmQjXt
         FKsT2QBqIl298Zk82bjpt9R2xKVsSiS4w7aP9jo32MeZVA6f5dS3STo1aH1vwNY/HG
         ly2cTQPJbAz74WGdaatx/F475sC9hw/koS3k1+ng8IvtiyInrTlUMlXZN81z9+DU8J
         Bgop3FbVcyfvKEtWsgLjOZHpcE6CE+unGYInrbOF2BGXD5qsJq3luU1r+k0yh7okpQ
         yrANJ2FPf9Lng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38DBFC00446;
        Fri, 16 Jun 2023 03:10:19 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230615114344.B63DFC433C0@smtp.kernel.org>
References: <20230615114344.B63DFC433C0@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230615114344.B63DFC433C0@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc6
X-PR-Tracked-Commit-Id: eee43699217504ba69cadefc85c6992df555e33f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7feaa490b3ddeed8801ead5e92e647439ce9e65
Message-Id: <168688501922.31465.1769445161787050980.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 03:10:19 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Thu, 15 Jun 2023 12:43:36 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7feaa490b3ddeed8801ead5e92e647439ce9e65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
