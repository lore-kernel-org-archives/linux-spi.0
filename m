Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E974FC43334
	for <linux-spi@archiver.kernel.org>; Wed, 22 Jun 2022 16:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358545AbiFVQ4g (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiFVQ4f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jun 2022 12:56:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30271F63C
        for <linux-spi@vger.kernel.org>; Wed, 22 Jun 2022 09:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 791ACB81D7C
        for <linux-spi@vger.kernel.org>; Wed, 22 Jun 2022 16:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40749C34114;
        Wed, 22 Jun 2022 16:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655916992;
        bh=G4WPUJMORpVCoQUZBlEpyY6lWYS1riBam1wZW1gMahs=;
        h=Subject:From:Date:To:From;
        b=ENeWIyCVu9RWiOofE3k/9XplThUNaKrSw+WkY3qxUIbdHcfW7WsjX6qmGuSaQvRLC
         JcJAGbZDNSYOBi5wrFSKTexZLeYjsbmt5uWhP+Y/u8GtQjPi3uaJqsOI6MbOMXArwm
         grSKfMEjq1ak4Gl3o/1fPeYvXxfsM/lG573wRTGbAhYCU89/eK3nEArgGlKqsSEpYm
         BJTmftYlZamwiiLUiAvI8WBP/KW26l250i7vDsMvekVGv6iiq4sHosENHlP4Lx1ZIG
         INQ92JQRQ3+gqXdu22Go6LQPDG2PdUbZy3sUDWhUKwMp60QpDoGOkkMawTgh6GaRiU
         vVinJeSYuXTSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F627E574DA;
        Wed, 22 Jun 2022 16:56:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165591699212.21689.6395142672137190131.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 22 Jun 2022 16:56:32 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] spi: aspeed: Fix division by zero (2022-06-22T16:16:15)
  Superseding: [v2] spi: aspeed: Fix division by zero (2022-06-22T09:42:31):
    [v2,1/2] spi: aspeed: Add pr_debug in aspeed_spi_dirmap_create()
    [v2,2/2] spi: aspeed: Fix division by zero


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

