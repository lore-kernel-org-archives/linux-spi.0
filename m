Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A60EB64DC
	for <linux-spi@archiver.kernel.org>; Mon,  3 Jul 2023 15:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGCPUX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 3 Jul 2023 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGCPUX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jul 2023 11:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AAAFD
        for <linux-spi@vger.kernel.org>; Mon,  3 Jul 2023 08:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28AB360F7B
        for <linux-spi@vger.kernel.org>; Mon,  3 Jul 2023 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 864E3C433C7;
        Mon,  3 Jul 2023 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688397621;
        bh=15h7oVoInkClOkOLbxYnzFrevs7p6VzrWlod5AbtRvU=;
        h=Subject:From:Date:To:From;
        b=FzYqfNfxSaOL/3m0TFwVH45aNVSi01EK8NimQEG9grC+ZHbZqfifWgd/c/8/H1qOW
         E7sUZqCjCXAiWA2HZe1nB1Zkkf66YfyWuUlydtvKgK9BRwp4OktT7kLAjouZ4tllQi
         zLfDGt1HAmSuYiEYLBGtFbqYghFNzg063mW85ejgm1LOXS76SDZwGZdnKWR7stXP+2
         ruJ9PW4exzG5bFJsCiPDX4cepKkdRnZVkJFOGs6KOGgPqKLAq8/9RAtldNSOwy0T3X
         XqVFAlSAibqP6mIWh7nZuiYS+7B6wjW+1N9C9IHU2m1+gXn6HTfYdcLQw3l4sVT2l4
         i4uiaci9c4pzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64E1BC64457;
        Mon,  3 Jul 2023 15:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168839762133.16555.17785465385781186413.git-patchwork-summary@kernel.org>
Date:   Mon, 03 Jul 2023 15:20:21 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rzv2m-csi: Fix SoC product name
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=761951
  Lore link: https://lore.kernel.org/r/89e9870a2c510387e4d7a863025f4d3639d4a261.1688375020.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


