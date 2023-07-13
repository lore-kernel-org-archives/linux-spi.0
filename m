Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9364EB64DD
	for <linux-spi@archiver.kernel.org>; Thu, 13 Jul 2023 09:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjGMJ4n (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 13 Jul 2023 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjGMJ4Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Jul 2023 05:56:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA8E2127
        for <linux-spi@vger.kernel.org>; Thu, 13 Jul 2023 02:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A007361A87
        for <linux-spi@vger.kernel.org>; Thu, 13 Jul 2023 09:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08585C433C7;
        Thu, 13 Jul 2023 09:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689242184;
        bh=g+zY+7BILCb0RFWFDnPD4Rj51Xu2BDuVb4lRgmd1EME=;
        h=Subject:From:Date:To:From;
        b=ed0mlOx/Yv+acsK5NaWxafkxkbMowuMjjmqdGHFHW+X0IngtGWWv2NfskLSKkRzYg
         2hnD0Mi/DS2d4e6YLs68f/6QeiN1CUsdzYlF1B+z6aUq/ep4d5cN7dJGkzc9PoZ9tA
         3FfewQHslTuraU7/K2KtRsIL7fxXHBegHQujE5aiLqxbCOCjCw+DcwE8Tgb+Vt9OF6
         faN7qCtgcKtQDJfxZhyFrr9M3NEJ6zMqKH6YDakHOOPg4OezjQUeu8q4oPZJHeNdvT
         tTo0EyhztLzs9Zz86lUpkPpdHj968S5fFLOLA9wXwY60FNahBJt13hFk0OsvCy+0vo
         200ZiRh9eNwQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E26F9E29F46;
        Thu, 13 Jul 2023 09:56:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168924218392.14168.6360754499314055216.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 13 Jul 2023 09:56:23 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Add SPI module for StarFive JH7110 SoC (2023-07-13T09:00:14)
  Superseding: [v1] Add SPI module for StarFive JH7110 SoC (2023-07-04T09:21:58):
    [RESEND,v1,1/2] dt-binding: spi: constrain minItems of clocks and clock-names
    [RESEND,v1,2/2] riscv: dts: starfive: Add spi node for JH7110 SoC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

