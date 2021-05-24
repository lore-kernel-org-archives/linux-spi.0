Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B13BC04FF3
	for <linux-spi@archiver.kernel.org>; Mon, 24 May 2021 16:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4EA6113B
	for <linux-spi@archiver.kernel.org>; Mon, 24 May 2021 16:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhEXQ0H (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 24 May 2021 12:26:07 -0400
Received: from tux.runtux.com ([176.9.82.136]:35482 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233026AbhEXQ0H (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 May 2021 12:26:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 442096EFC0;
        Mon, 24 May 2021 18:24:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id 7nT45oZLbKUC; Mon, 24 May 2021 18:24:35 +0200 (CEST)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 6DB866EF06;
        Mon, 24 May 2021 18:24:34 +0200 (CEST)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id EFA9846F; Mon, 24 May 2021 18:24:33 +0200 (CEST)
Date:   Mon, 24 May 2021 18:24:33 +0200
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mirko Vogt <mirko-dev|linux@nanl.de>
Subject: Re: [PATCH 1/1] spi-sun6i: Fix chipselect/clock bug
Message-ID: <20210524162433.6nebp2k7u66zbkx3@runtux.com>
References: <20210520100656.rgkdexdvrddt3upy@runtux.com>
 <20210521173011.1c602682@slackpad.fritz.box>
 <20210521201913.2gapcmrzynxekro7@runtux.com>
 <20210524133301.32c74794@slackpad.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524133301.32c74794@slackpad.fritz.box>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 24, 2021 at 01:33:01PM +0100, Andre Przywara wrote:
> - Single patch set series don't bother to have a "1/1" after the
>   "PATCH".
> - You are expected to increase the version number when you send a new
>   version, to show that *this* is better than the previous post and
>   this version should be merged. Otherwise the maintainer might pick
>   the wrong version. "git format-patch -v2" and "git send-email" will
>   automatically take care of this.

OK I'll keep that in mind.

> Please keep in mind that text after the dashes doesn't make it in it
> repo, so this information would be lost there. Also, in general links in
> commit messages are somewhat frowned upon, since they tend to 404
> sooner or later. So ideally you can put a condensed version of your
> findings into the commit message? Don't worry if it grows long, it is
> not uncommon to have a 2 page commit message for a one-liner patch.

This was intentional, the commit message is only the upper part.
The Links were meant to give a lot of details why the patch fixes
something. I think the commit message already explains the condensed
findings. I've put this additional explanation text after the '---' to
not need an additional Patch 0/1 email ;-)

Thanks!
Ralf
-- 
Dr. Ralf Schlatterbeck                  Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com
