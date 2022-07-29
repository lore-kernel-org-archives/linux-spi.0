Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5866FC19F2A
	for <linux-spi@archiver.kernel.org>; Fri, 29 Jul 2022 19:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiG2Tav (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238987AbiG2Ta2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 Jul 2022 15:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E45636D
        for <linux-spi@vger.kernel.org>; Fri, 29 Jul 2022 12:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC66061FB3
        for <linux-spi@vger.kernel.org>; Fri, 29 Jul 2022 19:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 365EDC433D6;
        Fri, 29 Jul 2022 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659123014;
        bh=KUZs3FRmGAKhaCsyXJIKURbC5REUaoGPV0zmYC7+mfE=;
        h=Subject:From:Date:To:From;
        b=HVVYcv/B9vpbRHrlmmAHHmNnbsW4cxq4RlR5VakIXNl1Y5O9teaVWqhzKCsFBQGPr
         zj9pz/AIfuz+rMbKXg2vzCbODEMt9pTRzm52vly2Hu+J27c2R4vZkqLjvpNIDu/yAY
         SrWjfQXD4w3UDg4uOUhnnxaJZMVikH/B6VznBl8tQqH+KMrcxyPe2Y1mH5pl9Wwivc
         9wWXPvcO78e3QW+jnzZrbA49JNX9h5RrXw4SYu+1q7+be+uRAcVUcYvIdA+4ptJPt7
         VdJ03iS/PEX385By6BRvmrxaS5GzIBCuoQuzMnfVHAQ04I3RYHL44oydz/l7Ex8Giq
         o1TgMRWh/7OXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0989AC43142;
        Fri, 29 Jul 2022 19:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165912301398.29520.10653095196170113465.git-patchwork-summary@kernel.org>
Date:   Fri, 29 Jul 2022 19:30:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add SPI Driver to HPE GXP Architecture
  Submitter: Hawkins, Nick <nick.hawkins@hpe.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=663824
  Lore link: https://lore.kernel.org/r/20220728161459.7738-1-nick.hawkins@hpe.com
    Patches: [v6,1/5] spi: spi-gxp: Add support for HPE GXP SoCs
             [v6,2/5] spi: dt-bindings: add documentation for hpe,gxp-spifi
             [v6,5/5] MAINTAINERS: add spi support to GXP


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


