Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B1BC2B9F4
	for <linux-spi@archiver.kernel.org>; Mon, 14 Jun 2021 14:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890986054E
	for <linux-spi@archiver.kernel.org>; Mon, 14 Jun 2021 14:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhFNOtR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 14 Jun 2021 10:49:17 -0400
Received: from tux.runtux.com ([176.9.82.136]:41532 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhFNOtQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Jun 2021 10:49:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 019906F13A;
        Mon, 14 Jun 2021 16:47:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id EOYoaGeA4CcL; Mon, 14 Jun 2021 16:47:10 +0200 (CEST)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 213FE6EFC2;
        Mon, 14 Jun 2021 16:47:09 +0200 (CEST)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 8720946E; Mon, 14 Jun 2021 16:47:09 +0200 (CEST)
Date:   Mon, 14 Jun 2021 16:47:09 +0200
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Mirko Vogt <mirko-dev|linux@nanl.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] spi-sun6i: Fix chipselect/clock bug
Message-ID: <20210614144709.2oxoutizjh2sii4r@runtux.com>
References: <20210520100656.rgkdexdvrddt3upy@runtux.com>
 <20210521173011.1c602682@slackpad.fritz.box>
 <20210521201913.2gapcmrzynxekro7@runtux.com>
 <YK0LR3077RUsSYti@sirena.org.uk>
 <20210527113920.ncpzrpst2d6rij3t@runtux.com>
 <0418aba2-6bca-8de1-9f72-2fb10007fc81@nanl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0418aba2-6bca-8de1-9f72-2fb10007fc81@nanl.de>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I've reposted as v2 in a new thread.
-- 
Ralf Schlatterbeck
