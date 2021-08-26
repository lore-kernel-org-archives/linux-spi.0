Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFFBC4320A
	for <linux-spi@archiver.kernel.org>; Thu, 26 Aug 2021 12:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92160610A4
	for <linux-spi@archiver.kernel.org>; Thu, 26 Aug 2021 12:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242372AbhHZMuy (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:50:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232506AbhHZMux (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 26 Aug 2021 08:50:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 98BA6610A6;
        Thu, 26 Aug 2021 12:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629982206;
        bh=R76JqhdCYnNdRlJ7EJmP5tRqWk5tTDGc2Yisx3ISecs=;
        h=Subject:From:Date:To:From;
        b=FGitMjnDpEWQj6KhkgoQyQrxnjBjbDFmy+0MuTc0WQIKgkhYDwGD7nh6MA15T5s4k
         c8IkRfMgJrDf5acN2878/VWy1vzLQL6Hy3Ou82pzLw5+lYy5ZqeT5Dg9GTh5HpzDb4
         DctYP/RE8eRr2roQA0UNgMHsYcPYBjGi1BQSeYHoMWLIlAmzd6u6eZ5Fhi4rjWAq6h
         NPgfgn7W9JAWQ6X20fuLvWcYVgQsOxVEBkBNcjkHBbbj47K0Y1j8C8R4r2CmupD6Iu
         1uwDW82nbWNm8P/PLPb4Z7Zn8XqqdQdbwnUwxEjpqNUVnS0JjBNkL5GaJy0HvAQ/pB
         OBZrEw6pBUEkw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162998220650.30272.17589450789237128791.git-patchwork-summary@kernel.org>
Date:   Thu, 26 Aug 2021 12:50:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: Add sprd ADI r3 support
  Submitter: Chunyan Zhang <zhang.lyra@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=537629
  Lore link: https://lore.kernel.org/r/20210826091549.2138125-1-zhang.lyra@gmail.com
    Patches: [V3,1/4] spi: sprd: Fix the wrong WDG_LOAD_VAL
             [V3,2/4] spi: sprd: Add ADI r3 support
             [V3,3/4] dt-bindings: spi: Convert sprd ADI bindings to yaml
             [V3,4/4] dt-bindings: spi: add sprd ADI for sc9863 and ums512

Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


