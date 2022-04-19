Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307EEC433EF
	for <linux-spi@archiver.kernel.org>; Tue, 19 Apr 2022 22:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346946AbiDSW7P (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245617AbiDSW7N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 18:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0F37BF2
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 15:56:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D13160B3C
        for <linux-spi@vger.kernel.org>; Tue, 19 Apr 2022 22:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB5E5C385A7;
        Tue, 19 Apr 2022 22:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408988;
        bh=RxitJMnxdQjHoOX3WAi8fjcjnrFdC20DM26iiIFlNL4=;
        h=Subject:From:Date:To:From;
        b=bZxpky2GMQuW7ZPWKdIPW9DKPuPHNbtgh8j4pBuDhDlbKv2fAvYwR/odQrQnaqh4x
         6HZJz+iWSiPW8KfnyoyDd9qPUeSg5MncpbTO0RmojQgXmhk8r78rp/1N+KztxLYCYB
         CQidoLf9viK35wPOPO80mPKqqjFkUOz6pB4iuyM1r/xZdel0tiQY7eWLc2VFEXjwUX
         M05dy3C8VyapN6vcciBK+Yn6qzoS/RDwOd0k33kyfViwdaczNB8PZfaUw2K7WlneB1
         xwyCxeCs3kcQ5DjDHVvkhNZh/ZCqgTCma7vitFDPjUUFyOFuBRBEzoBKIczvs8DCub
         Kbb7RsQYUevXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82BABE8DD61;
        Tue, 19 Apr 2022 22:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165040898848.18326.914452601035099200.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 19 Apr 2022 22:56:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync (2022-04-14T08:56:37)
  Superseding: [v1] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync (2022-04-13T09:36:56):
    spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

