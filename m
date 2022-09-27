Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37996C07E9D
	for <linux-spi@archiver.kernel.org>; Tue, 27 Sep 2022 11:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiI0L5A (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 27 Sep 2022 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiI0L47 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 27 Sep 2022 07:56:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A551155669
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 04:56:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 175E3B81B92
        for <linux-spi@vger.kernel.org>; Tue, 27 Sep 2022 11:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9783C433D7;
        Tue, 27 Sep 2022 11:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664279815;
        bh=YBbJwQq0y3IHwOoKt0ADHVAWgqmMd/hnSp11Znhoxik=;
        h=Subject:From:Date:To:From;
        b=LXRq762dwleWYT05U4CYySZAqvLmk95XslyhFvIyxrc5WP4ffQ7TYRwW5rlpr2hSn
         Fn54qnVJNoDSHTI46h152ZnA6x4jbKHWcomtpZyvwpOLJOJ0Jl5rE6RZkT3WLRzoaX
         jSfKlJUxqKTCGbcfFT3Ey/z2ldYlkH/ozdmkHw+PqwdzqHuiLFSkdnjaC6IRAX8EKS
         qRRU9cA8IjBYkn8iAY91TZ7bciLtRPvZP2padE4TLk4PduiWpIXFaqOUEC+DV9lT8B
         yf65yCneM/I7H1kPzKwOL5gk7vot5zlerIUouGSj83eCnXmEArgj0mt+4EHwnMb6gB
         C9PgOAT0TeZxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4890C04E59;
        Tue, 27 Sep 2022 11:56:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166427981566.10601.8850075357849060607.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 27 Sep 2022 11:56:55 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Fix DMA bugs in (not only) spi-s3c64xx (2022-09-27T11:21:13)
  Superseding: [v1] spi: Fix DMA bugs in (not only) spi-s3c64xx (2022-09-16T11:39:49):
    [1/4] spi: spi-loopback-test: Add test to trigger DMA/PIO mixing
    [2/4] spi: Save current RX and TX DMA devices
    [3/4] spi: Fix cache corruption due to DMA/PIO overlap
    [4/4] spi: s3c64xx: Fix large transfers with DMA

Latest series: [v2] Add support for the Airoha EN7523 SPI controller (2022-09-27T11:32:26)
  Superseding: [v1] Add support for the Airoha EN7523 SPI controller (2022-09-22T10:04:08):
    [1/3] dt-bindings: arm: airoha: Add documentation for Airoha SPI controller
    [2/3] spi: Add support for the Airoha EN7523 SoC SPI controller
    [3/3] ARM: dts: en7523: Add SPI node


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

