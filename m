Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8199C4743D
	for <linux-spi@archiver.kernel.org>; Sun,  6 Jun 2021 11:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8A661370
	for <linux-spi@archiver.kernel.org>; Sun,  6 Jun 2021 11:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhFFLMW (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 6 Jun 2021 07:12:22 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:58717 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhFFLMV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 6 Jun 2021 07:12:21 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5F836300002D0;
        Sun,  6 Jun 2021 13:10:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 532441EDD; Sun,  6 Jun 2021 13:10:28 +0200 (CEST)
Date:   Sun, 6 Jun 2021 13:10:28 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.12 03/43] spi: Fix spi device unregister flow
Message-ID: <20210606111028.GA20948@wunner.de>
References: <20210603170734.3168284-1-sashal@kernel.org>
 <20210603170734.3168284-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603170734.3168284-3-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Jun 03, 2021 at 01:06:53PM -0400, Sasha Levin wrote:
> From: Saravana Kannan <saravanak@google.com>
> 
> [ Upstream commit c7299fea67696db5bd09d924d1f1080d894f92ef ]

This commit shouldn't be backported to stable by itself, it requires
that the following fixups are applied on top of it:

* Upstream commit 27e7db56cf3d ("spi: Don't have controller clean up spi
  device before driver unbind")

* spi.git commit 2ec6f20b33eb ("spi: Cleanup on failure of initial setup")
  https://git.kernel.org/broonie/spi/c/2ec6f20b33eb

Note that the latter is queued for v5.13, but hasn't landed there yet.
So you probably need to back out c7299fea6769 from the stable queue and
wait for 2ec6f20b33eb to land in upstream.

Since you've applied c7299fea6769 to v5.12, v5.10, v5.4, v4.14 and v4.19
stable trees, the two fixups listed above need to be backported to all
of them.

Thanks,

Lukas
