Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B64C433FE
	for <linux-spi@archiver.kernel.org>; Mon,  7 Mar 2022 18:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiCGS5c (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 7 Mar 2022 13:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiCGS5b (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 13:57:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BEE92D0E
        for <linux-spi@vger.kernel.org>; Mon,  7 Mar 2022 10:56:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 626F3B81657
        for <linux-spi@vger.kernel.org>; Mon,  7 Mar 2022 18:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E084BC340E9;
        Mon,  7 Mar 2022 18:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646679393;
        bh=RZtekI+l+CaosqIyrBDUVNZ/pxxoq9Ryp3akbE/49jw=;
        h=Subject:From:Date:To:From;
        b=R6ggcwVgpgQPHGGz3aDKJ6Iy0SABhbmcV4e+3lj7obnfWuSCWpkzUT7Lb2ORvP2P0
         FlDLhaT8r/8VVUBhtTTTx+xhAKw+bFftpca1UoayHQrjsWTq7XzqI7tR1MabB+I/pZ
         qb8wLSTk1QLC4MQKxhCIWbcK3eaJpiJUjhgnVHOMMpyAF3OAkq3jt4MPwY0qqXvBzT
         W70APlUrBWNWiSk/jFcKJo/ff4aSgNWlo+4liGZDs+a3XEQ4NbbXDi1xyCJlx/y19+
         Q5C3RTWT7057ZrTFh9zrDilXZ3CiXU2PjotPsQtqvh1mE4GrSZ5lNA4oWsQL8cZQuc
         Kz66Gjr4Pjy0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B53F7E6D3DE;
        Mon,  7 Mar 2022 18:56:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164667939364.922.4293456165728173290.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 07 Mar 2022 18:56:33 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: Fix invalid sgs value (2022-03-07T18:48:43)
  Superseding: [v1] spi: Fix invalid sgs value (2022-03-07T18:01:16):
    spi: Fix invalid sgs value


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

