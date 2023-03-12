Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18CCC6FA99
	for <linux-spi@archiver.kernel.org>; Sun, 12 Mar 2023 19:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCLT4f (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 12 Mar 2023 15:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCLT4e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Mar 2023 15:56:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A27298D5
        for <linux-spi@vger.kernel.org>; Sun, 12 Mar 2023 12:56:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C258B80C2E
        for <linux-spi@vger.kernel.org>; Sun, 12 Mar 2023 19:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA68C433EF;
        Sun, 12 Mar 2023 19:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678650989;
        bh=R6PuaWP2v/sPlrmybCUsCmkIjAp102KQgsYQ9G5uhkg=;
        h=Subject:From:Date:To:From;
        b=KA0H+fRSE/BV4QdE2tLKFdWoq+8lt6F3fcs3Azr8YbYzEb/4kSzoJ2PYz8enSzNgJ
         KYE7BuBngkUvM77407p5ylm0aEc1UVzRd4gnMixz+HQa3mpgPAbO6gWhSxop5n999J
         anClsq4slfgK4qTFqSyK93eHUTMQ4NCcsvJgSOAFrLqF3kt/qDks59alDgRE0tRfI4
         szCW8rTy2lfdxXHNOG+7F70YsNcgt2OacfsalomKSUCM6hKWvGMfICsBoK1NHPnC40
         0uYRRPqxCGal3fyJiT7HE3Y0j5yrt6bysgGiwH55dpCFtbERAHID04oLoxsyzgsg5B
         GnlCQyY6XRdmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA35EE61B75;
        Sun, 12 Mar 2023 19:56:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <167865098888.9034.4272375193047965740.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 12 Mar 2023 19:56:28 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] Add Intel LJCA device driver (2023-03-12T19:04:30)
  Superseding: [v4] Add Intel LJCA device driver (2023-03-09T07:10:55):
    [v4,1/5] mfd: Add support for Intel LJCA device
    [v4,2/5] gpio: Add support for Intel LJCA USB GPIO driver
    [v4,3/5] i2c: Add support for Intel LJCA USB I2C driver
    [v4,4/5] spi: Add support for Intel LJCA USB SPI driver
    [v4,5/5] Documentation: Add ABI doc for attributes of LJCA device


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

