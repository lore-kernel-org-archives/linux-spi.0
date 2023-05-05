Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9605AC77B75
	for <linux-spi@archiver.kernel.org>; Fri,  5 May 2023 11:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjEEL4t (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 5 May 2023 07:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjEEL4s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 May 2023 07:56:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC3E9017
        for <linux-spi@vger.kernel.org>; Fri,  5 May 2023 04:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D463D63D7D
        for <linux-spi@vger.kernel.org>; Fri,  5 May 2023 11:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A8B3C433D2;
        Fri,  5 May 2023 11:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683287806;
        bh=fSQyuNSBlNKtddMp+YGCJejiMniTlr+O/PxF1NwH8fE=;
        h=Subject:From:Date:To:From;
        b=qi2ReYcSITB7K7W31aybtp2tWUBePI8GFEIHQtBMuVjUaYQlNHWC7Nas7ExmrR/be
         5qAHo3kjmrDnHITG9lm0zlGbzJFDvlrbloH48S7MJ6XAGR8jDFv3Bt+SnuBFjbQEL/
         cYnJsXveyDKaqurK4LMdqXykuQaWHaeYbdLC2ixSY/Ma5iQFkUCzWtiFLDUdZeXDTn
         x+q4ds7VCf61F2UdSD5JEwYALgVSDHaVeulMIVBeHLLxOjY5Rmnh8uZ99AAPyGwXId
         a96E3ITLGCDgIeDlLknCcHE3nhUCoHTw3W4zlDBk2XXo4nqfWZAmH6loLMVyHH5du4
         xvs2ozZT2UJ/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A914C43158;
        Fri,  5 May 2023 11:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <168328780609.31947.15515097329227242015.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 05 May 2023 11:56:46 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Fix up Nokia 770 regression (2023-05-05T11:16:54)
  Superseding: [v2] Fix up Nokia 770 regression (2023-05-05T08:22:59):
    [v2,1/3] Input: ads7846 - Convert to use software nodes
    [v2,2/3] ARM/mmc: Convert old mmci-omap to GPIO descriptors
    [v2,3/3] ARM: omap1: Fix up the Nokia 770 board device IRQs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

