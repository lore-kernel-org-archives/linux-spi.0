Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73524C433EF
	for <linux-spi@archiver.kernel.org>; Sat,  9 Apr 2022 12:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbiDIM6l (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 9 Apr 2022 08:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiDIM6l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 9 Apr 2022 08:58:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8956355BC
        for <linux-spi@vger.kernel.org>; Sat,  9 Apr 2022 05:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51C38B8015A
        for <linux-spi@vger.kernel.org>; Sat,  9 Apr 2022 12:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAE44C385A0;
        Sat,  9 Apr 2022 12:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649508990;
        bh=5tnytoCDVOoqsIDh6yscsjrwxKUad6jahcvlyN9WMtg=;
        h=Subject:From:Date:To:From;
        b=eHTkTPiJQvT/TRcILOyR7ZrVfr2wAljN1GuOmWOvO/XFebfaq20c6gFgXYcTHX8FE
         awpu9ZUvmzD6E8LpGEhl+FXVPFG2rhovQV0JR/U3yf1Ny5lBoFlHVicRawTYsbSrZq
         eIAGJrmesOykYOH7n5rLKirBlDQqhHF1EKOSuZkHUeLBWXfUiUfPO3dW/3tZPLYANT
         lO1Q+kHdOVpwooBB9F57NwrQ7sOIDMjkNI7HqPj2z9Zmfzdp2I2sft+S+MV/7Ijkit
         NTRr6atUf75DT9cxA6zJm5NMH/iyrhObQOT24SPF8ptyDx4yd/VfPQwG+PE1Q4xC0e
         l+JnB6ipp3g8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD49BE85D15;
        Sat,  9 Apr 2022 12:56:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164950899058.31858.2053608226744742622.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 09 Apr 2022 12:56:30 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: add support for Mediatek SPI-NAND controller (2022-04-09T12:08:14)
  Superseding: [v4] spi: add support for Mediatek SPI-NAND controller (2022-04-07T15:06:47):
    [v4,1/5] mtd: nand: make mtk_ecc.c a separated module
    [v4,2/5] spi: add driver for MTK SPI NAND Flash Interface
    [v4,3/5] mtd: nand: mtk-ecc: also parse nand-ecc-engine if available
    [v4,4/5] dt-bindings: spi: add binding doc for spi-mtk-snfi
    [v4,5/5] arm64: dts: mediatek: add mtk-snfi for mt7622


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

