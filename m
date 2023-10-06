Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B862AE81E1E
	for <linux-spi@archiver.kernel.org>; Fri,  6 Oct 2023 17:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjJFRud (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 6 Oct 2023 13:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjJFRud (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Oct 2023 13:50:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062CDCA
        for <linux-spi@vger.kernel.org>; Fri,  6 Oct 2023 10:50:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0E22C433C8;
        Fri,  6 Oct 2023 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696614630;
        bh=0j9FtKsnNNj1ksan9rjD/SvcD3rNxiHTBOeC6tMTIpY=;
        h=Subject:From:Date:To:From;
        b=fMpPBFI0Wmk1kNOo14sPxWH3nXjcDQTYUPybXDPhatbDr9jdqoGY/WqlOCP2Ehnu2
         MvmwrDYdoA88UYaf/9ZByBfvX2KIqD8J/yrWTxlzAYFAUc2MJvE8Sj2dsjpyLTJvz7
         2dN3NttEvGRVc//5V+r/CHFURf/Xg6zRLxeAGcBifTs6o5uaVX6KJEqY/XxtQ5dQNz
         Gfeg/6vnb1l6gxF99V1N3vqgqpGssZee11f0/QZ+xlO32TOaqhcWDluQAcYVj4vPKr
         oE8YxafQe9j4hsg3ftkRVCysZHtYPJtgpT+pYsjnLSKGYNTfP0MU8DcULjaBjrziBF
         TcGwyoFZsTBjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B2D5C41671;
        Fri,  6 Oct 2023 17:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169661463040.25346.2646215347765009993.git-patchwork-summary@kernel.org>
Date:   Fri, 06 Oct 2023 17:50:30 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spidev: make spidev_class constant
  Submitter: Greg KH <gregkh@linuxfoundation.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=790652
  Lore link: https://lore.kernel.org/r/2023100639-celtic-herbs-66be@gregkh


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


