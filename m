Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53396C0015E
	for <linux-spi@archiver.kernel.org>; Wed, 26 Jul 2023 16:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjGZQAk (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbjGZQA1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Jul 2023 12:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2350A19A4
        for <linux-spi@vger.kernel.org>; Wed, 26 Jul 2023 09:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B283461A2A
        for <linux-spi@vger.kernel.org>; Wed, 26 Jul 2023 16:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F425C433C8;
        Wed, 26 Jul 2023 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387226;
        bh=34pRLNaFZ+WfQIvXgfOMhgyB5dpOxnW2GAkwPIklY2w=;
        h=Subject:From:Date:To:From;
        b=R27TWFGz5XcScIou3whi7EihI9xDdqFmxjiRRi+piWJ/zKXcNhCgn8m1VfFTgEVh5
         DWTN9X7ZCuplcCqvJGqq6xLQmUflLXkIXadm/4DeDmWvJg1Xr1Dx1ifQGAQ8ytlQyD
         sil3JHMpOWMEu4XJPoN9cIw4iWA7LI5qlKaMVtvlJjUrPeTj5trJozFRG30zaBu1uf
         /pvwsjvyZIcxCY6PdfKY3M3hEjnl3X0z9i1BQUK39vrhXnqkuR6t+1YwaoK20wp5Js
         64JIGmnpYgIuum8zy6Q4KVrwOOvcGfHJTD06PiCO1sR+s/jNXNd8h6LLwViPeQWul/
         H3H8BCzZgborg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF617C41672;
        Wed, 26 Jul 2023 16:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169038722592.5347.10790038490647670620.git-patchwork-summary@kernel.org>
Date:   Wed, 26 Jul 2023 16:00:25 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: spi-qcom-qspi: Fallback to PIO for xfers that aren't multiples of 4 bytes
  Submitter: Doug Anderson <dianders@chromium.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=769428
  Lore link: https://lore.kernel.org/r/20230725110226.1.Ia2f980fc7cd0b831e633391f0bb1272914d8f381@changeid
    Patches: [1/2] spi: spi-qcom-qspi: Fallback to PIO for xfers that aren't multiples of 4 bytes
             [2/2] spi: spi-qcom-qspi: Add mem_ops to avoid PIO for badly sized reads


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


