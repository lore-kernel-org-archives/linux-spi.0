Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49497C43219
	for <linux-spi@archiver.kernel.org>; Tue,  5 Apr 2022 11:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbiDEK4F (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349084AbiDEJtF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Apr 2022 05:49:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6535FA9956
        for <linux-spi@vger.kernel.org>; Tue,  5 Apr 2022 02:40:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 138B8B81B14
        for <linux-spi@vger.kernel.org>; Tue,  5 Apr 2022 09:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D11D4C385A2;
        Tue,  5 Apr 2022 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649151622;
        bh=zA6F8jZneUFz9hLbaCCIKyxb1G3zQUSaQg8VuSGuFyo=;
        h=Subject:From:Date:To:From;
        b=Ic/9NUaRqTbHfjE1UmcETkatTa9RtpuAD+ZMA4Bcb7BD+Oqi7OnKpWS8uFqUoU390
         djDO2QD9AAyj5KaR13ehvpJoVszx+VXybYQVxOaF82KAkYllYUyUmAIkKyMiK5f4SW
         0bmRZVZyyILEUc6GFfh4BSiQVIQgJKMylpElU9EyQTRLMO3I/GlOWBrJQ+zmgIjCnI
         SxFyiIUjuNel2FbDpRpPwpGGZmwh4WBtFl/HGJ0l3C35yeIYzkwj4ZJDGZ5l3kURzX
         8RTEwGVb9HozAwtvnlGbMhFONPbgfMMxAtZFx9G84gg+as0KE52CSriafU7TI8sO7J
         5re3+WOZwZPXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4C4FE85BCB;
        Tue,  5 Apr 2022 09:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164915162268.21598.5874587750297922510.git-patchwork-summary@kernel.org>
Date:   Tue, 05 Apr 2022 09:40:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] dt-bindings: spi: qcom-qspi: Add minItems to interconnect-names
  Submitter: Kuldeep Singh <singh.kuldeep87k@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=626984
  Lore link: https://lore.kernel.org/r/20220328192006.18523-1-singh.kuldeep87k@gmail.com

Series: spi: mediatek: add single/quad mode support
  Submitter: Leilk Liu <leilk.liu@mediatek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=628101
  Lore link: https://lore.kernel.org/r/20220401071616.8874-1-leilk.liu@mediatek.com
    Patches: [V7,1/3] spi: mediatek: add spi memory support for ipm design
             [V7,2/3] dt-bindings: spi: support hclk
             [V7,3/3] spi: mediatek: support hclk


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


