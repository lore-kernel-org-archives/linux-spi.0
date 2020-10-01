Return-Path: <SRS0=zioz=DI=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA3FC4727E
	for <linux-spi@archiver.kernel.org>; Thu,  1 Oct 2020 22:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D22E207DE
	for <linux-spi@archiver.kernel.org>; Thu,  1 Oct 2020 22:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601593049;
	bh=5oSLrh8EIyyUfFk2R+lr2MUDM3Ns8N6qeBPFAzn/AMM=;
	h=Subject:From:Date:To:List-ID:From;
	b=Kj/yeNXnmKI6qt3Pr2wZeXzOG0YVDx+qqKM3P8uu07mRTOkax/lKvA6SCo7slCXbs
	 U74cdi9alDXWWbbMk1osq59gNmK5n5znlcp4DYWPpZAWr6NFk3f0HvgJhWAAa0g5Cr
	 Kw+1Wxc5STY7qa5lSWczg9ccn14Zj1ItwN1lPjXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgJAW53 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 1 Oct 2020 18:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgJAW52 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 1 Oct 2020 18:57:28 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601593048;
        bh=5oSLrh8EIyyUfFk2R+lr2MUDM3Ns8N6qeBPFAzn/AMM=;
        h=Subject:From:Date:To:From;
        b=i9aUboCjue2N/KeSqNjvOyRPMgtiSoHG2yNoUAOmBFv9nT4II8fskH1LUXMTJwiGR
         QL1piRcj6hMu6vxI1NOY6zLqO0gi1YpbQaAueEBXTxXAe/hRrIWtUY7JoTQ3AqA4ZH
         r3H+ILxBM802Y+9plB1Ga6Ht4vvlpl9sNY03elNA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160159304836.2143.3127773314680678410.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 01 Oct 2020 22:57:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: dw: Add full Baikal-T1 SPI Controllers support (2020-10-01T22:28:09)
  Superseding: [v2] spi: dw: Add full Baikal-T1 SPI Controllers support (2020-09-30T18:55:25):
    [v2,01/21] spi: dw: Use an explicit set_cs assignment
    [v2,02/21] spi: dw: Add DWC SSI capability
    [v2,03/21] spi: dw: Detach SPI device specific CR0 config method
    [v2,04/21] spi: dw: Update SPI bus speed in a config function
    [v2,05/21] spi: dw: Simplify the SPI bus speed config procedure
    [v2,06/21] spi: dw: Update Rx sample delay in the config function
    [v2,07/21] spi: dw: Add DW SPI controller config structure
    [v2,08/21] spi: dw: Refactor data IO procedure
    [v2,09/21] spi: dw: Refactor IRQ-based SPI transfer procedure
    [v2,10/21] spi: dw: Perform IRQ setup in a dedicated function
    [v2,11/21] spi: dw: Unmask IRQs after enabling the chip
    [v2,12/21] spi: dw: Discard chip enabling on DMA setup error
    [v2,13/21] spi: dw: De-assert chip-select on reset
    [v2,14/21] spi: dw: Explicitly de-assert CS on SPI transfer completion
    [v2,15/21] spi: dw: Move num-of retries parameter to the header file
    [v2,16/21] spi: dw: Add generic DW SSI status-check method
    [v2,17/21] spi: dw: Add memory operations support
    [v2,18/21] spi: dw: Introduce max mem-ops SPI bus frequency setting
    [v2,19/21] spi: dw: Add poll-based SPI transfers support
    [v2,20/21] dt-bindings: spi: dw: Add Baikal-T1 SPI Controllers
    [v2,21/21] spi: dw: Add Baikal-T1 SPI Controller glue driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

