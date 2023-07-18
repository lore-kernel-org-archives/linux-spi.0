Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40958EB64DA
	for <linux-spi@archiver.kernel.org>; Tue, 18 Jul 2023 07:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjGRH4X (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 18 Jul 2023 03:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjGRH4W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jul 2023 03:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDDBDD
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 00:56:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 721456147A
        for <linux-spi@vger.kernel.org>; Tue, 18 Jul 2023 07:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D182DC433C7;
        Tue, 18 Jul 2023 07:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689666980;
        bh=AWl8Mo0IddspKuoSKGihSQo7UaeLyOWpCoBhFbnTPRw=;
        h=Subject:From:Date:To:From;
        b=h3S9h+pQt5R0GlWfCDW4GHtnqMb1nbWHabaNikK7DfQS3HfsfB8wsgSeoKzL79vvx
         AFjSKTlQGUp6gnYwGJW6hTQ5OXkumH6xQCKz2atMPDkTZk6PiKrurc8IVqBTMLDXGG
         87gwRdpaXvwCiJdZSg5qNqwwVYg0luSni9ovHIFc8W0MAMtkbBz7JccCWf07lKgHvN
         kwDCEoR7sLHxquivK8RhU9Fo4Ay7J/3GuZHMF/i7j+dLlf4/jy185OKfKGFvX4hoE8
         tBL55fa02Qsl4la2u7ZD8P4C2aQC+axOPb9iFb/yzq8JgUNPbEPvlbL6hVvnshFDd8
         QAiq3bqhY6pWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADB88C64458;
        Tue, 18 Jul 2023 07:56:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168966698064.30806.16911196593915566271.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 18 Jul 2023 07:56:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] update at91 usart compatible for sam9x60 (2023-07-18T06:57:33)
  Superseding: [v1] update at91 usart compatible for sam9x60 (2023-07-13T09:51:09):
    [PATCHv2,1/2] dt-bindings: serial: atmel,at91-usart: add compatible for sam9x60
    [PATCHv2,2/2] ARM: dts: at91: sam9x60: fix the SOC detection


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

