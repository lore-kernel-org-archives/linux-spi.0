Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF2C4361B
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 20:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7102423A1D
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 20:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgLQU5g (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 17 Dec 2020 15:57:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731493AbgLQU5g (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 15:57:36 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608238616;
        bh=SS4/cL6c7qRzuNwOAxUqWRvF47fbVqCaMIvga2pUEfI=;
        h=Subject:From:Date:To:From;
        b=BVhn4eiu17F+cWP3i2se3AaUfjg78WdyLrTgA0ecGb5k2c2RJzU2Kba0P6eUEiJxs
         XpI354Ld0plvtCZm5BunkZhRbU99b4jNoQjyou2eax/CUBd0fgZiotm6pFjmYttZgt
         UIoLlxDkWWuFrwRCWzyn9VTe4ZR6PH62MKnwxx7xMxSxv6C1ZZFdN1xedwSlPEdWnG
         /Nmrfwqc8Uu68x/Nou7j9YWujypZ8zBdBAvFnBjeAgBSXCzqVzh8l0bVRJGTYs1NPB
         XOmMhFUWsMXDYp4BKzIpF/8oqcbYloAEYhyNu4IH4uyMZQN35l2LCaEFT8tjQXvco0
         7HTaXDoq6t1OQ==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160823861597.26408.16498376851131714660.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 17 Dec 2020 20:56:55 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add Tegra Quad SPI driver (2020-12-17T20:28:39)
  Superseding: [v3] Add Tegra Quad SPI driver (2020-12-11T21:15:55):
    [v3,1/9] dt-bindings: clock: tegra: Add clock ID TEGRA210_CLK_QSPI_PM
    [v3,2/9] dt-bindings: spi: Add Tegra Quad SPI device tree binding
    [v3,3/9] MAINTAINERS: Add Tegra Quad SPI driver section
    [v3,4/9] spi: tegra210-quad: Add support for Tegra210 QSPI controller
    [v3,5/9] spi: spi-mem: Allow masters to transfer dummy cycles directly by hardware
    [v3,6/9] spi: tegra210-quad: Add support for hardware dummy cycles
    [v3,7/9] arm64: tegra: Enable QSPI on Jetson Nano
    [v3,8/9] arm64: tegra: Add QSPI nodes on Tegra194
    [v3,9/9] arm64: tegra: Enable QSPI on Jetson Xavier NX


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

