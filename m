Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CC3C433E0
	for <linux-spi@archiver.kernel.org>; Fri,  5 Feb 2021 19:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4DA64FB9
	for <linux-spi@archiver.kernel.org>; Fri,  5 Feb 2021 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBESPY (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:15:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:32858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232098AbhBESOv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 5 Feb 2021 13:14:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 21F7764FB9;
        Fri,  5 Feb 2021 19:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612554995;
        bh=b1FoFPhl57GIBtdaZICDup5TbLO3OSZmHBe9M6P4uMs=;
        h=Subject:From:Date:To:From;
        b=ZY1+IVRJnBuG6mPQt2x5fvQ5OCM4bbVroB1FreeIJYvlK0VCY4+o82bKRcQu8xEc3
         vsp/9ZED1D1uk09Hx9fNeLX5wB08iddgXXmgun+vV6ayqmpyNDy74n4fQCSxfffh04
         5RmIjOClhK7O6Ey6m476cbutIFCvAz7kaOfptW03rhsJVOQuncAwgs208wDLOkXNUE
         6rVObGgwTG7FCTd6EVJ3yGfR+dDWaoSW5kN1uomRqynFJ29Zaar/uzViQ0TsBHbRBW
         MVKWdRsC07/rk16+65IimjqRNqnoaMfXrSGePfHxi9hDXBoEqTa4s1npdpUVHxYmvf
         1LvGaXt5bXseg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161255499506.29987.4157883655096370093.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 05 Feb 2021 19:56:35 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: stm32: fix and enhancements for spi-stm32 (2021-02-05T18:59:25)
  Superseding: [v1] spi: stm32: fix and enhancements for spi-stm32 (2021-02-05T11:09:02):
    [1/8] spi: stm32: properly handle 0 byte transfer
    [2/8] spi: stm32: do not mandate cs_gpio
    [3/8] spi: stm32h7: ensure message are smaller than max size
    [4/8] spi: stm32: driver uses reset controller only at init
    [5/8] spi: stm32: defer probe for reset
    [6/8] spi: stm32: use bitfield macros
    [7/8] spi: stm32h7: replace private SPI_1HZ_NS with NSEC_PER_SEC
    [8/8] spi: stm32: make spurious and overrun interrupts visible


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

