Return-Path: <SRS0=hzoM=6D=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2004C38A30
	for <linux-spi@archiver.kernel.org>; Sun, 19 Apr 2020 19:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4122075E
	for <linux-spi@archiver.kernel.org>; Sun, 19 Apr 2020 19:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587325217;
	bh=jZ3ROdo1T8A5SCqd/Zj3McR9QLMKMzQJgRMS8yt+jbU=;
	h=Subject:From:Date:To:List-ID:From;
	b=BzXGJdVNRm5JDkscvxGr3fzlEM3sXudE3KPKU0AxGGYKls2StFORpjgs4hg2uRZuC
	 uh5js4+GeDrtdq54ON+f6kKiiNpZCBP5vnylRNaWwGP3tOFoxEH9LnkzTd6O82XR3/
	 ACs9MuRCGBE1sfrikuG7M+jz3s4wytzYG551Z7nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgDSTkR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 19 Apr 2020 15:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgDSTkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 19 Apr 2020 15:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587325216;
        bh=jZ3ROdo1T8A5SCqd/Zj3McR9QLMKMzQJgRMS8yt+jbU=;
        h=Subject:From:Date:To:From;
        b=vNlv39/OOxqmIjsxezJyf5zf5pKCzFAWJ4F04NQQ4qmJDg+Ngl9osoWQAI0lBr0RU
         txOpPuKTYGiV2crnOex1iwJV1dIePQJeYgw8AdwWv2pGacUf+loy/NdLqWL2jvHUhR
         7q4Qi59zvnkXw+doJDkLayDefGxp1wRLZ/6X6FlQ=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158732521693.12783.13668375557837360985.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 19 Apr 2020 19:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: bcm-qspi: Handle clock probe deferral (2020-04-19T19:23:30)
  Superseding: [v1] spi: bcm-qspi: Handle clock probe deferral (2020-04-16T17:43:01):
    [1/9] spi: bcm-qspi: Handle clock probe deferral
    [2/9] dt: bindings: spi: Add support for mspi on brcmstb SoCs
    [3/9] spi: bcm-qspi: Handle lack of MSPI_REV offset
    [4/9] spi: bcm-qspi: Drive MSPI peripheral SSb pin on cs_change
    [5/9] spi: bcm-qspi: when tx/rx buffer is NULL set to 0
    [6/9] spi: bcm-qspi: Make PM suspend/resume work with SCMI clock management
    [7/9] spi: bcm-qspi: Use fastbr setting to allow faster MSPI speeds
    [8/9] spi: bcm-qspi: add support for MSPI sys clk 108Mhz
    [9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only on legacy controllers


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
