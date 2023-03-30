Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E695C6FD1D
	for <linux-spi@archiver.kernel.org>; Thu, 30 Mar 2023 06:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjC3G4l (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 30 Mar 2023 02:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjC3G4l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Mar 2023 02:56:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2E19F
        for <linux-spi@vger.kernel.org>; Wed, 29 Mar 2023 23:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEC82B825DB
        for <linux-spi@vger.kernel.org>; Thu, 30 Mar 2023 06:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A684EC433D2;
        Thu, 30 Mar 2023 06:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680159397;
        bh=+oOD2sizPMt0yA/d72Uo3/ToCQkP/HoVDfv6XgGiXq0=;
        h=Subject:From:Date:To:From;
        b=OdoCUVI24u/2YCJLEFt1PM3Y62+2BG+VBu7CsNhYHPKijmaTjceSCAU3Z1KKCXoRj
         ckjAjaHTbKSeNeSBgPUccv1qMgm6GJ95UGYsDs8SYdp3PxUygdN0CasOEqIV8W62j1
         Rkws4JSWPKw3U4t7wwAoO8BjPew+QQm/FfM6zWo1p5D/iXZ+WOTKDxQrRGvPSntNCc
         a1VLQO+tNY8Msrqr5ItiXA7PCpZGsqWyatsuLauR20vkkEIMuKM1KHaCthECINZaJ7
         HzyAScUPlWFH5KCX+uwndW6dEfAVTZJWK70qHCiQJQglj6qIT2b1CKEumFwooOC9o6
         eR7uU3Sc+WpFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91927E21EDD;
        Thu, 30 Mar 2023 06:56:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168015939759.504.13301820113643812968.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 30 Mar 2023 06:56:37 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: dw: DW SPI DMA Driver updates (2023-03-30T06:34:48)
  Superseding: [v4] spi: dw: DW SPI DMA Driver updates (2023-03-27T04:34:03):
    [v4,1/2] spi: dw: Add 32 bpw support to DW DMA Controller
    [v4,2/2] spi: dw: Add dma controller capability checks


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

