Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40700EB64D7
	for <linux-spi@archiver.kernel.org>; Wed, 28 Jun 2023 21:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjF1VQ4 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjF1VJg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Jun 2023 17:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65DC1FE4;
        Wed, 28 Jun 2023 14:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61B1961478;
        Wed, 28 Jun 2023 21:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAA5CC433CB;
        Wed, 28 Jun 2023 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687986574;
        bh=UnIqjbwULWzDA+/nmygU1opUXwKIqdFFriZ7oFzXiic=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ht3QRdQBiSmTzo11erLhobkg1cV8fBOO/mteJa41dc8to7BXCds5lHV3ov+bxRA/K
         d6yP9GrKBz9Tba21XA4gMyLtVUIg0d+rFlWGP+pCTPGk56GLBTSOvFqmdTgugrCQ7k
         R6FcshwxJTmujg5Ucb+rCL6K+TPUvJdT5pthgUgbArQpIFA0lEjvA94G7btPzMrcT6
         tQauXdKfhFZDUj5MhiNhcqjX6hBcfSKm4tEAxa1ItRskfIuqI0cVvK+LJCBupShcuO
         ScTIgp19r8+AurY0vZhAOkMrRYxX7JjGlcnOTyrE2DR7Kv0Q/fj8r7kT28n5oKSy2o
         b6wij1cMhXsyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2AAAC0C40E;
        Wed, 28 Jun 2023 21:09:34 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626133342.B7F90C433C8@smtp.kernel.org>
References: <20230626133342.B7F90C433C8@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626133342.B7F90C433C8@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.5
X-PR-Tracked-Commit-Id: e884a133340a470070b2c59833c9ff87aa6517ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84fccbba93103b22044617e419ba20e1403b4a65
Message-Id: <168798657472.29247.12962996338723774240.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 21:09:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:33:33 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84fccbba93103b22044617e419ba20e1403b4a65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
