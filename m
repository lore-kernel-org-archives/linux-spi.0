Return-Path: <SRS0=Gz9J=DC=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49C0C4727E
	for <linux-spi@archiver.kernel.org>; Fri, 25 Sep 2020 22:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747022087D
	for <linux-spi@archiver.kernel.org>; Fri, 25 Sep 2020 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601072864;
	bh=FvBdzsHOz+BJlcDxeL8xO+G8Dj7UZ+IIcBaewrwGajQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RiU9ehqGzxK1wmTCAEL7wJcBVqEF5lvjEfbr6vVcBt/hikktRMkP/CMNcUEvJDWjw
	 79Kf2V1PbkJMHJ9UpIrvv7hb50Dl5Ehq1Yd4XzdRLSm5JbNQ3IJI82uWsdLo5ssE/F
	 wO5fjLp0BHh2n0rXXu+SBJWjOU6iuE5qRm5Cd8PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgIYW1o (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 25 Sep 2020 18:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgIYW1o (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Sep 2020 18:27:44 -0400
Subject: Re: [GIT PULL] SPI fixes for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601072863;
        bh=FvBdzsHOz+BJlcDxeL8xO+G8Dj7UZ+IIcBaewrwGajQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xWwbiIk6EuFg2CbpDZn29zJiVEdve2CACEPL0l2jtO7DS776NgCXP1qNN8N6+1bIa
         n5yfUIVCKREBqYUudMoVAXKShFoQ3nukU5aMxHBIHH8lQaecbY0fsvU8wMYjSdCT17
         DhBGZgYwjkxX1sosRfNfnX9cyAPL4gmTTk+mHoOg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200925201749.4470521D42@mail.kernel.org>
References: <20200925201749.4470521D42@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200925201749.4470521D42@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc6
X-PR-Tracked-Commit-Id: 00fb259c618ea1198fc51b53a6167aa0d78672a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 782d1222555c42187af94b5cb65c68034f473fb2
Message-Id: <160107286360.23838.14365470026578628389.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Sep 2020 22:27:43 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The pull request you sent on Fri, 25 Sep 2020 21:16:43 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/782d1222555c42187af94b5cb65c68034f473fb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
