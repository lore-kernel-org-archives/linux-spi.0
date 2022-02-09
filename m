Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ADCC433F5
	for <linux-spi@archiver.kernel.org>; Wed,  9 Feb 2022 12:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiBIM4R (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBIM4Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Feb 2022 07:56:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A3BC0613CA
        for <linux-spi@vger.kernel.org>; Wed,  9 Feb 2022 04:56:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFEC5618FA
        for <linux-spi@vger.kernel.org>; Wed,  9 Feb 2022 12:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1890EC340E7;
        Wed,  9 Feb 2022 12:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644411379;
        bh=K4+OcH+eaMcsCrGnDmrIM2bXhUghoDN8pzqpF/ZL3sc=;
        h=Subject:From:Date:To:From;
        b=Kig+YL1jQ0hjKHtWADYEIU5XQmkMAcBIjEm4pjcGy9SCkp74MzZt9t+6fnutR+SSm
         jVF902I6HhMg8dnBKFI/tGe9JKvtRHlbpOBqyW/9gPi8IhnVzQOkjHZgmUQcEeSMKa
         ellEdjiyUTrxYvzRC09S8YPvlmurnhwUBFovFl7cPDScsToVp4KIv2e4XGfE84uKW5
         kvJb76seIZ4m5nh8QNOZ4wOWlRgujxE06KpF+A3btFaTCr/Qu+m9ct9tfyCxjAbOz6
         ZaWDT2Spk4Bk3ooIwmqXoDMeBBwXCn53NJz3DDUj++CC9c5kQnoNZvIhxYLap1PkPq
         JA6KEdEV2z/Qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07108E5D084;
        Wed,  9 Feb 2022 12:56:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164441137902.6237.9967632688930657559.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 09 Feb 2022 12:56:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2022-02-09T12:27:04)
  Superseding: [v5] mtd: spi-nor / spi / MFD: Convert intel-spi to SPI MEM (2021-12-20T16:46:24):
    [v5,1/3] mtd: spi-nor: intel-spi: Disable write protection only if asked
    [v5,2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
    [v5,3/3] Documentation / MTD: Rename the intel-spi driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

