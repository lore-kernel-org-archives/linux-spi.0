Return-Path: <SRS0=pAD9=DU=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7085DC43457
	for <linux-spi@archiver.kernel.org>; Tue, 13 Oct 2020 18:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335BF214DB
	for <linux-spi@archiver.kernel.org>; Tue, 13 Oct 2020 18:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602613463;
	bh=6mlQVw+rrBCO2LC11qi6DBtvC2K7Cv0v49UjE9zjxqA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T6WZxO555iRZj73cPRB5mZBHJRj+Bx9nf62b9eS5ij58qXR3J9QbgXsq4P3TVKPxJ
	 tzmFET9v61I2pUyzEvPsguC40I9Zz5mpN/4nlaKn1RQt5kL/8+bGju/bL8Li0iHWoy
	 ql/GjY7pUeQzc3qOpIKa2zwtWtTmthc7WI+sTrpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgJMSYT (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 13 Oct 2020 14:24:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgJMSYH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 14:24:07 -0400
Subject: Re: [GIT PULL] SPI updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602613447;
        bh=6mlQVw+rrBCO2LC11qi6DBtvC2K7Cv0v49UjE9zjxqA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X+IsEjVcluRxCy8Vp41jdg1FG7NZ3tfMvWD6LpFIadanNOJgJEfNWWG9PDPFM7m+u
         ezFol7mR2hFcb1tlQ7VKEPR36IUM2Elx+nha4KokzMdWDlusJT0wTAKtN0UTqtaGDX
         y8F226VhNYtaoaJz6OTO6XCQ3DO1sewgBR554dAU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012130953.370DA20838@mail.kernel.org>
References: <20201012130953.370DA20838@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012130953.370DA20838@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.10
X-PR-Tracked-Commit-Id: 988731181359efd771ae967f94936906fa38868a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a996b9c61729cd1507e48303c214dc317df890e2
Message-Id: <160261344710.11865.644561534721349938.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 18:24:07 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 14:09:27 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a996b9c61729cd1507e48303c214dc317df890e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
