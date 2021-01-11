Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFB3C433E0
	for <linux-spi@archiver.kernel.org>; Mon, 11 Jan 2021 10:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED15A2222D
	for <linux-spi@archiver.kernel.org>; Mon, 11 Jan 2021 10:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbhAKK50 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 11 Jan 2021 05:57:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728986AbhAKK50 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Jan 2021 05:57:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0075B224D3;
        Mon, 11 Jan 2021 10:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610362606;
        bh=iAMofg0vSyL4UVDFO4ukRUmmd/CNpDli2THXZAJVLjU=;
        h=Subject:From:Date:To:From;
        b=uq47CBEHGA3iXtubfD2ONA2Pi/w465r5Ttmrq/MqMOXRgCYDRtDGfujgqf7e/cjvT
         PxEgqJFgj3qoGu8IJMlr4ufMsJfqgY7+/B2nM0nEEIs+jTP2r1W+3J71GzeAIyOkcj
         C+U1/L1DdHTZRX0aRU4mcwHPeajgJf/oB8bt+vsECfQ94kdJjaxgKY/TaivUG04kY8
         IAXBCRLSbuziUfhKZhq69ArdoFdIFauVqdvZgmHHIPAwXTvdxqM40gPKKXcUnwmzsd
         5a+/z6RCRnE8SsABGdVcZj5CteiT5BWUJHN0sI6wK6sSex42qkjszsGVXFrwoulySJ
         NqMCf16wypEWQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161036260596.6052.16715988070469489963.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 11 Jan 2021 10:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-bcm-qspi: style: Simplify bool comparison (2021-01-11T09:54:48)
  Superseding: [v1] spi: spi-bcm-qspi: style: Simplify bool comparison (2021-01-11T09:26:29):
    spi: spi-bcm-qspi: style: Simplify bool comparison


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

