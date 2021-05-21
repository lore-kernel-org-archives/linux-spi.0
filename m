Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96166C04FF3
	for <linux-spi@archiver.kernel.org>; Fri, 21 May 2021 20:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB85613EE
	for <linux-spi@archiver.kernel.org>; Fri, 21 May 2021 20:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbhEUUbf (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 21 May 2021 16:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhEUUbe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 21 May 2021 16:31:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 88482613EC;
        Fri, 21 May 2021 20:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621629010;
        bh=v46D6467eh6cu9MqtNzQFf2+EFLxmZk0QILP5LlHGu0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZM0LSD4Y/RyEAhnq5thF6j5vh/f7dX6dhLxSyAJVYHSlxFvrClQr1Eot/agSwjlDx
         bvxiEbIjb5/6KO5vACsmnONPEznQOvzOdxq/Am0wFNPuAaWHX7HKgfNw8iP1WpFtZG
         qUbHwWDGxTQlVj26QlTi+7sxNBY54vck0FH49Sh5rM6N3utKEeHUc9C0snMB/KFeq3
         RKzyBFlpFEcdztwRB6zJ5xF6ra67slLozg6hXsIVSFKUdu7KwHkMUDKjYzPC/cfVMk
         /n9wMFU/MUROigygb9HKwpYGzM2KwkJ2VEEjj1Y/49jaIC/NKDRTIQAIzMulYqoyd4
         hNwTbfxXlNGMw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/2] Adapt the sja1105 DSA driver to the SPI
 controller's transfer limits
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162162901049.11427.12413955245468287025.git-patchwork-notify@kernel.org>
Date:   Fri, 21 May 2021 20:30:10 +0000
References: <20210520211657.3451036-1-olteanv@gmail.com>
In-Reply-To: <20210520211657.3451036-1-olteanv@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        f.fainelli@gmail.com, andrew@lunn.ch, vivien.didelot@gmail.com,
        broonie@kernel.org, linux-spi@vger.kernel.org, linux@roeck-us.net,
        vladimir.oltean@nxp.com
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Fri, 21 May 2021 00:16:55 +0300 you wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> This series changes the SPI transfer procedure in sja1105 to take into
> consideration the buffer size limitations that the SPI controller driver
> might have.
> 
> Changes in v3:
> - Avoid a signed vs unsigned issue in the interpretation of SIZE_MAX.
> - Move the max transfer length checks to probe time, since nothing will
>   change dynamically.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/2] net: dsa: sja1105: send multiple spi_messages instead of using cs_change
    https://git.kernel.org/netdev/net-next/c/ca021f0dd851
  - [v3,net-next,2/2] net: dsa: sja1105: adapt to a SPI controller with a limited max transfer size
    https://git.kernel.org/netdev/net-next/c/718bad0e4da9

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


