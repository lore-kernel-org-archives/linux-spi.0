Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252C2C32773
	for <linux-spi@archiver.kernel.org>; Fri, 19 Aug 2022 12:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348508AbiHSM44 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 19 Aug 2022 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348755AbiHSM4v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 19 Aug 2022 08:56:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B7AC6CE0
        for <linux-spi@vger.kernel.org>; Fri, 19 Aug 2022 05:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1754E60F00
        for <linux-spi@vger.kernel.org>; Fri, 19 Aug 2022 12:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72BECC433C1;
        Fri, 19 Aug 2022 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660913809;
        bh=rI7B7yGbo8ah8HtWeMb14cxgQ2HknwwVskqCsp0uFn0=;
        h=Subject:From:Date:To:From;
        b=d8YzIJHH3UuoB4yteUceuE5gs9orrYWW+fB/D46mpQXa8Vc7YQIOSf2RJNwIcO33A
         RBl57ElB+PAcRmfI5H9t+jDwNXY/KqPqnfxRzm4UJTl/dpBxkZOn490heiJndKDDnB
         5vMjbv8EuH2K6N789Umpuiw9WWQPlijVX07g+lGs86X0TkWolHIrA/uGVjTybSz+fj
         iiS8ggJd6ry6RgiZ2xewLf6Bo4PqFZ1Ya44s8WspjmJyrtv7/Rioqk70GUQol7gLg+
         k7djZSb3JfP+fZMl4o3bT5YiZsU3ZFz3Y878MC1S7/5/iNx92qL2MGKNFwTuIO5Pi2
         7BR6dsr2ZpAyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CAE0C43142;
        Fri, 19 Aug 2022 12:56:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <166091380926.16963.505433794790660033.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 19 Aug 2022 12:56:49 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: amd: Configure device speed (2022-08-19T12:36:30)
  Superseding: [v1] spi: amd: Configure device speed (2022-08-17T13:18:09):
    spi: amd: Configure device speed


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

