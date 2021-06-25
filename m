Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A495DC2B9F4
	for <linux-spi@archiver.kernel.org>; Fri, 25 Jun 2021 07:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DB96141C
	for <linux-spi@archiver.kernel.org>; Fri, 25 Jun 2021 07:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFYH7G (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 25 Jun 2021 03:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhFYH7F (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Jun 2021 03:59:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0BE4161351;
        Fri, 25 Jun 2021 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624607805;
        bh=uRL3Yyeho/0ilYABFHhBfRaPu1a8awtEjWAMUPnYsQo=;
        h=Subject:From:Date:To:From;
        b=SEbrqaxsKryjvcYXfp5HhKPuWHugp3HovqJ88pawYg0smVnMURUQ0nO/GHwXejw/2
         QEOIKCsvStKQCVcl5soqfyM959ffdO+t8Q19F7c/iIMhNPmfe/XUOYRe0VerwZfgWC
         Sr5/8+WbG22EsJvtT6y/rj5vU+joi72g+HqNO37a8MDNLOW0+SoE5LOPZkCN+uNmJL
         Nf22tbEBdsqO6u4Ac5Oahtcc+OlSvXcuf08Dp1b0pVXkTuLuMV/uVgIXPQp+v/SJPy
         7/5uYAC24c+8VpOZG+0u47jVCWlcr2ASoGFtaJQ77KtlipTIbQDfSumk6c+uai/IDs
         ocT51Voxojk2g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162460780491.639.4093587367258159131.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 25 Jun 2021 07:56:44 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v9] Add Rockchip SFC(serial flash controller) support (2021-06-25T07:16:52)
  Superseding: [v8] Add Rockchip SFC(serial flash controller) support (2021-06-11T06:11:25):
    [v8,1/9] dt-bindings: rockchip-sfc: Bindings for Rockchip serial flash controller
    [v8,2/9] spi: rockchip-sfc: add rockchip serial flash controller
    [v8,3/9] arm64: dts: rockchip: Add SFC to PX30
    [v8,4/9] clk: rockchip: rk3036: fix up the sclk_sfc parent error
    [v8,5/9] clk: rockchip: Add support for hclk_sfc on rk3036
    [v8,6/9] arm: dts: rockchip: Add SFC to RK3036
    [v8,7/9] arm: dts: rockchip: Add SFC to RV1108
    [v8,8/9] arm64: dts: rockchip: Add SFC to RK3308
    [v8,9/9] arm64: dts: rockchip: Enable SFC for Odroid Go Advance


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

