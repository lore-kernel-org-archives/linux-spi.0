Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68354C46CA1
	for <linux-spi@archiver.kernel.org>; Mon, 18 Sep 2023 16:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjIRQJX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjIRQJG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 18 Sep 2023 12:09:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCCB5B92
        for <linux-spi@vger.kernel.org>; Mon, 18 Sep 2023 09:07:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC922C116A0;
        Mon, 18 Sep 2023 15:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695052227;
        bh=09VB7ozUc3aQmKdqNo25ivufGdw/o3MtUdUgwDBCe30=;
        h=Subject:From:Date:To:From;
        b=WUWSOLb9BtPWwQKvo8ws+M3UNrSkKuQio1/GUKYLIDb+1s+TNEj2EU7yZ7cbnnGW8
         N9gFwfheuVHkY3WI04viS+HmnmCbQXXrIwrZAmNDHsloCbrVQQ3B9TjG+d04dQxzI6
         m/oTEasOQDXaQ6wWVwuPR2xwQUIuC3e7Kst8kZ/o+pZFBGJs6Ro2ZOWpD9WKNZiSxX
         b8YiMNbd69JVPytj7xV5lwtyDHB1aZS5m8Rr77XWBzC/Bco6Xzm5SL0gmzgKi/JkwJ
         /Ga7ndgCQBswI1pLbR6q775N6v4pa7JeT8/GYbulR2vJTCWhWgkcBjNS9PPcvGajUv
         NqGosxQZu1+pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5957C595C4;
        Mon, 18 Sep 2023 15:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169505222767.10585.11878486656663605664.git-patchwork-summary@kernel.org>
Date:   Mon, 18 Sep 2023 15:50:27 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Drop warning from spi_stop_queue()
  Submitter: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=784952
  Lore link: https://lore.kernel.org/r/20230916161235.1050176-1-u.kleine-koenig@pengutronix.de

Patch: [v3] spi: bcm2835: reduce the abuse of the GPIO API
  Submitter: Bartosz Golaszewski <brgl@bgdev.pl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=783115
  Lore link: https://lore.kernel.org/r/20230911161553.24313-1-brgl@bgdev.pl


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


