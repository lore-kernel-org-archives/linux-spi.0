Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813F8C433F5
	for <linux-spi@archiver.kernel.org>; Sun, 19 Sep 2021 07:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6489061019
	for <linux-spi@archiver.kernel.org>; Sun, 19 Sep 2021 07:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhISH6N (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 19 Sep 2021 03:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhISH6N (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 19 Sep 2021 03:58:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3988A60F51;
        Sun, 19 Sep 2021 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632038208;
        bh=ebftCa26V2uE3ho557BCqLACTC1WOHZKB1+K+3yeqhQ=;
        h=Subject:From:Date:To:From;
        b=bZ7nERH1lEDcMnbjC/OS5o2JvrahjdOZ7+dV06OSpCexmtFQQj6KBG75t7hSkeU+3
         85D/hvV03yMW8GJ8sld7EX8YY9zWcXv0ZtVsW3eyzgWzf3Ie3O5L96+mED7cV/Bn2D
         XC9Cdxn72V318G/wpoIV8N+tnCFFxsk8vuK/8HgYfc/qiYTghhgxypU/vGgNRK9/hE
         nZJwKs+IbK+kARD6QsUgadJ5D0aTd3O6rF/DSCGCdcDbtstO9ZpVFVJS4giEfUfr0B
         O50H/tzXzBWJW58KoJZf8BexWncZRVEjc8mYdooPTLoZB1SRX/JQz8ujMs/BEzTnh8
         3+/3tsfbGr92Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163203820808.9410.13647544955638590798.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 19 Sep 2021 07:56:48 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] add support for Cadence's XSPI controller (2021-09-19T07:38:41)
  Superseding: [v5] add support for Cadence's XSPI controller (2021-09-17T14:29:07):
    [v5,1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
    [v5,2/2] spi: cadence: add support for Cadence XSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

