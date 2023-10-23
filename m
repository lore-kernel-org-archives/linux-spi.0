Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A16C25B46
	for <linux-spi@archiver.kernel.org>; Mon, 23 Oct 2023 17:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJWRKZ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 23 Oct 2023 13:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWRKY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Oct 2023 13:10:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B994
        for <linux-spi@vger.kernel.org>; Mon, 23 Oct 2023 10:10:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B711C433C7;
        Mon, 23 Oct 2023 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698081022;
        bh=KqOd4c4vCOkxl0zH/sEZ2okoBT7eM7ov4GS9a3du70g=;
        h=Subject:From:Date:To:From;
        b=D7VIXM3sfUudLTYVfm6pNUT4kX02t66EaE0E6sPcqu0/MITjbFuaNiG2bhJYbtPQV
         ZwZa5SrXXPT9AJNLlTnMKy22jp0I1mfm/918iVH9aa4WSsYY7ZRHPnq967p7G+WS7A
         CGo52OGqR1pQO0fJA0qVmZrJ1oMT32KO+YS4JXzkpjPe0IG6Mg3ktBLf/cDfSGpWpU
         M8BN7v+bINm9DNoWEvMpVKy4rOlD48Bf14VYUzGq6v+wBONAVSw9XDY+zBf2WkErm5
         Wtdh3kQTcqYNt/xrRvF3x/Dg0vKAUi8foWGdJNRHkP0hGydgB1cCJP7cC3YIatqP/g
         w36n/9HHSyrEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4617BE4CC13;
        Mon, 23 Oct 2023 17:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169808102223.23259.11674344806175580710.git-patchwork-summary@kernel.org>
Date:   Mon, 23 Oct 2023 17:10:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: omap2-mcspi: Add FIFO support without DMA
  Submitter: Vaishnav Achath <vaishnav.a@ti.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=792929
  Lore link: https://lore.kernel.org/r/20231013092629.19005-1-vaishnav.a@ti.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


