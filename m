Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AF8C4332F
	for <linux-spi@archiver.kernel.org>; Tue, 29 Nov 2022 09:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiK2J4W (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 29 Nov 2022 04:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiK2J4V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Nov 2022 04:56:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306FFF34
        for <linux-spi@vger.kernel.org>; Tue, 29 Nov 2022 01:56:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9D3B6156D
        for <linux-spi@vger.kernel.org>; Tue, 29 Nov 2022 09:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 171EFC433C1;
        Tue, 29 Nov 2022 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669715780;
        bh=b7CGInxaLprKmspZ57vhu3/XNYdQv6zsYMtKvqwP+x0=;
        h=Subject:From:Date:To:From;
        b=ssGT3TYWW2sp7uGLxbEcKPJ1lQQg696A8fHav2OuNZ+ZMA0O8894Kldow8c9OV8ur
         9GyOS1EYrvv7IB2bSi/B4190SMUlgMlAebrGSLCE+xP9mEVirAPWN8j6n3anPx3uPX
         o1CSdCK+qQAxPqQQfCI9eKGWqTWgVunjOsXuSxO7fQ+/LwPVq2xV/KfLwk4LDXNJfM
         4Ls+uyyI+7qjrU5u5Rp9EoVSiIfxahulPnTwR02hpul7BvPf3CC5IqTbyqWkNmqHJZ
         iDQOaDz6qsYLj/FgHcgUZUW7zt50xBuWRRME3/j5DVhcEdKoALA0ho+pm4dtC+k6vS
         lxjp+/3WQSQsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EED82C395EC;
        Tue, 29 Nov 2022 09:56:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166971577997.22713.10254441023929835722.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 29 Nov 2022 09:56:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: spi-geni-qcom: Add support for SE DMA mode (2022-11-29T09:23:34)
  Superseding: [v2] spi: spi-geni-qcom: Add support for SE DMA mode (2022-11-21T14:19:33):
    [V2] spi: spi-geni-qcom: Add support for SE DMA mode


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

