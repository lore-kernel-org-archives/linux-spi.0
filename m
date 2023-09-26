Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B094E7E644
	for <linux-spi@archiver.kernel.org>; Tue, 26 Sep 2023 15:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjIZPKs (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 26 Sep 2023 11:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZPKr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Sep 2023 11:10:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66C10A
        for <linux-spi@vger.kernel.org>; Tue, 26 Sep 2023 08:10:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D81E9C433C8;
        Tue, 26 Sep 2023 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695741040;
        bh=d3t/P8+ayNHYp0sh468s5WYvkhswiQ68y9Q7guysLBc=;
        h=Subject:From:Date:To:From;
        b=kJRxG+vT0yhy4QjF+st2QzhcgVyr6MBUVqrY5qcdHLEIb8e8kQNUlNswluHm2U/dv
         dA1Uikkr+BaBLH5cGi3MOWe3XoGlCRNqcgAwYwZXdR7NEg1FEiBBaxe8HrbpTkNh9I
         8QknZ6gtwIaQeUP/1l/RkBQkENa7KLKOeSU+yXIBjDevJxeBVxh3SKZj9j7XXw4Hbu
         V+FFeIF05IKXojhCUYmQi5HrEKfm0KWrzWulSFEH8QZn4QwXSkvm4Z0j1YE52127uG
         6h1lbTTQKuL9UWgrzPkcdgfazfVIJIhYSAJuT/FdBAG+8HDXTojV0HcUrFRI/AWiEW
         pW6Xftx7MN78g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEBE6E29AFF;
        Tue, 26 Sep 2023 15:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169574104071.12943.16735513205756368793.git-patchwork-summary@kernel.org>
Date:   Tue, 26 Sep 2023 15:10:40 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: omap2-mcspi: Fix hardcoded reference clock
  Submitter: Vaishnav Achath <vaishnav.a@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=787633
  Lore link: https://lore.kernel.org/r/20230926113812.30692-1-vaishnav.a@ti.com

Patch: [V3] spi: spi-cadence-quadspi: Fix missing unwind goto warnings
  Submitter: Dhruva Gole <d-gole@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=787659
  Lore link: https://lore.kernel.org/r/20230926130926.314751-1-d-gole@ti.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


