Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF61C433F5
	for <linux-spi@archiver.kernel.org>; Sun, 27 Feb 2022 13:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiB0N5H (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 27 Feb 2022 08:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiB0N5G (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 27 Feb 2022 08:57:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3143E1CB09
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 05:56:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B283360F2D
        for <linux-spi@vger.kernel.org>; Sun, 27 Feb 2022 13:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D950C340F2;
        Sun, 27 Feb 2022 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645970189;
        bh=msTbY6FQO0gCmNnb262qAdrNA9Yh5WzFJDU6rJ8NHag=;
        h=Subject:From:Date:To:From;
        b=W6JAW1N/X6JmW+iJSAFxvOLCF2849YovmD7PdvvDfvU7EVca0fKKKW8pqGKpWpYMU
         a207v5LeHvM9GoSV4pyvlaqkEL7xH9ySPA8AwGSnR4yVdl8aSdeV7UpLR7mD5m49Su
         kIHf53xRXbj78XSleZOrg04ZijcbhZK4q/tRVf1MSzyPo6YhjbOVjO/mRIG4cs+zvf
         8X9vRcHu8X46SOKIIc43mrRAh1jiWnNdYCYh14dZAtJj687OQ9mDrBvEFxhj2SiQM9
         zCcY7twe5zSK/JSHxJYaxAlluP+Oi35QyJLPfEzaCw5BUGKkvmZ+P4xiBB+V+vCJe/
         vBBcSt68bct0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 067B6EAC081;
        Sun, 27 Feb 2022 13:56:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164597018902.6419.8646848054891137737.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 27 Feb 2022 13:56:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Fix broken usage of driver_override (and kfree of static memory) (2022-02-27T13:52:04)
  Superseding: [v2] Fix broken usage of driver_override (and kfree of static memory) (2022-02-23T19:12:59):
    [v2,01/11] driver: platform: add and use helper for safer setting of driver_override
    [v2,02/11] amba: use helper for safer setting of driver_override
    [v2,03/11] fsl-mc: use helper for safer setting of driver_override
    [v2,04/11] hv: vmbus: use helper for safer setting of driver_override
    [v2,05/11] pci: use helper for safer setting of driver_override
    [v2,06/11] s390: cio: use helper for safer setting of driver_override
    [v2,07/11] spi: use helper for safer setting of driver_override
    [v2,08/11] vdpa: use helper for safer setting of driver_override
    [v2,09/11] clk: imx: scu: fix kfree() of static memory on setting driver_override
    [v2,10/11] slimbus: qcom-ngd: fix kfree() of static memory on setting driver_override
    [v2,11/11] rpmsg: fix kfree() of static memory on setting driver_override


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

