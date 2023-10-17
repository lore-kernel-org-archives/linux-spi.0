Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECE7CDB474
	for <linux-spi@archiver.kernel.org>; Tue, 17 Oct 2023 23:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjJQXu0 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 17 Oct 2023 19:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJQXu0 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Oct 2023 19:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5C93
        for <linux-spi@vger.kernel.org>; Tue, 17 Oct 2023 16:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93DC7C433C7;
        Tue, 17 Oct 2023 23:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697586624;
        bh=Ug/rl969Pw+vCTEQOMCwJGr16dvrJAulRwJfY+MgIT8=;
        h=Subject:From:Date:To:From;
        b=TA/fwiJF36cf12TH/+7PDovQUDJoEA6t5w7DG1NyF7xTN8C0Fjwpco8TC/g6Idxrg
         kH1Tg9QlRwirh+vrMYEyaiE3QnAnyQSfYpvYmUeUvhTXWHmzAwVdRs83g+rMlHjwD5
         gEMC1HgdsXWJdgMRMG2J7kZgpNMMpAE1ArEw3iDEh9ng2vYkXfPDKFiB5m9yqhQvX4
         XN/4Mb69IvHJ2aMonAdF+EXoxu6Xswgk+MjaP6BJipV6Cd15/WI+uxrHPvjpCTe9uK
         mYWcslNbqLmOLzCSmgxVMemnCscro5cLhxlYFnbfMxQg4lllAZmtdPZMkxJsnb2+Sh
         7TKiDaGAJtV2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7416AE4E9DD;
        Tue, 17 Oct 2023 23:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169758662441.16065.2735077268809678353.git-patchwork-summary@kernel.org>
Date:   Tue, 17 Oct 2023 23:50:24 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [RESEND] spi: stm32: Explicitly include correct DT includes
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=794083
  Lore link: https://lore.kernel.org/r/20231017203352.2698326-1-robh@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


