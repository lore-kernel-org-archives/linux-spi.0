Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E468C4332F
	for <linux-spi@archiver.kernel.org>; Fri, 21 Oct 2022 13:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiJUNu2 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiJUNu0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Oct 2022 09:50:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABED521E105
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 06:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FF00B82B1D
        for <linux-spi@vger.kernel.org>; Fri, 21 Oct 2022 13:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC267C433C1;
        Fri, 21 Oct 2022 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666360217;
        bh=2ikAf7tNF82pah1UPLQA6ChgpEfTBIUi0LmrfQdQE6A=;
        h=Subject:From:Date:To:From;
        b=jcnFeQwSmRuEpASPUHTqTF0jkbNyUlQkiDyRvvHWrk4i+UPFrFEjNQ7VeH2w+gKMK
         bYnme/HzV+i6sp+o+dzSdqCXVQIfNOk/yvlQjLkMqeXbqNpbVTJN3GyiBjB4Ds132m
         dmo0NhLCQtfRmDC+PQuOKigQYER43YD8wV4bSq6zudI/PDUsF1eikIMG6pM3oKxaZ0
         NzQuxvEK8WHYfcDfJ7V3qJUdql1c/yt1/bQsdL/KONk0qVqPqAwPhvwzi1hsBx+4DD
         ee1avqFCefEAnsc8h8D21qwkiP5FOmsRxs8DKiCUeYbt2LUqCyslJFUvkTsp+fUKSx
         ZDEUi0seNttLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2045E270DF;
        Fri, 21 Oct 2022 13:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166636021760.13520.8809397076219257897.git-patchwork-summary@kernel.org>
Date:   Fri, 21 Oct 2022 13:50:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2,1/1] spi: Introduce spi_get_device_match_data() helper
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=687276
  Lore link: https://lore.kernel.org/r/20221020195421.10482-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


