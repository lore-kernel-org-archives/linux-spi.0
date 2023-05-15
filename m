Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3B8C77B7D
	for <linux-spi@archiver.kernel.org>; Mon, 15 May 2023 11:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbjEOLKo (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 15 May 2023 07:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbjEOLKj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 May 2023 07:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9B719B2
        for <linux-spi@vger.kernel.org>; Mon, 15 May 2023 04:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10680622A6
        for <linux-spi@vger.kernel.org>; Mon, 15 May 2023 11:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 777E1C433EF;
        Mon, 15 May 2023 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684149022;
        bh=0JfoUgHUQzKUPO/ZiMpIdMyV3y/fSUeJpsTUFdPlt4Q=;
        h=Subject:From:Date:To:From;
        b=oxlBmqa7RWEG4mVyFoWQGQHFBB6OUurEvS2j6JS+S4vQCJVO4BNx1lL4kQgELRFFd
         km1YtyUoBz2Tq7+11NqFqvgoRpqB9bwc4gERr9VXSakPwK7XMwB6pE1ErFQV4eRA48
         //dtby7C4t14sPCHe9d2CQaXjKqiFL16OFe5Ud7Fr7yXyzoJAK91dMGN31ktvXJ+/M
         hlmZLV2V67wAMJZN4q4ggl8vNbVDndEvpgz9SdRzOwvVxvSKXjMZJ33l5HndQD3hqv
         NbxKWxc9zKbf14Q335RmzYwL3E1Comd2rxY26eHLX4SYH0/jQmzQX5eWfSwVTWs8TQ
         x0Gc2ltEfpBNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57909E5421B;
        Mon, 15 May 2023 11:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168414902230.21885.18441664160497604812.git-patchwork-summary@kernel.org>
Date:   Mon, 15 May 2023 11:10:22 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: spi-cadence: Avoid read of RX FIFO before its ready
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=746194
  Lore link: https://lore.kernel.org/r/20230509164153.3907694-1-ckeepax@opensource.cirrus.com
    Patches: [1/2] spi: spi-cadence: Avoid read of RX FIFO before its ready
             [2/2] spi: spi-cadence: Only overlap FIFO transactions in slave mode

Patch: spi: MAINTAINERS: drop Krzysztof Kozlowski from Samsung SPI
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=747282
  Lore link: https://lore.kernel.org/r/20230513173646.4306-1-krzysztof.kozlowski@linaro.org


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


