Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89985C433B4
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 08:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B2566112F
	for <linux-spi@archiver.kernel.org>; Mon, 10 May 2021 08:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhEJI5r (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 10 May 2021 04:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhEJI5q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 10 May 2021 04:57:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C62406112F;
        Mon, 10 May 2021 08:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620637001;
        bh=EGoGqzI6ZY4nqHotT1kNQoq+r7IXYIrRK92VJHp2Aqk=;
        h=Subject:From:Date:To:From;
        b=VaFZLoLBlCJ2SgmM0UQeceput4kHMGBp4KGlF8YCullxq2Oohjs6TGo93e3FOHkBG
         TqwWq3cPIq34mek5Ba3/6ZOhmBgSZOfxY8PN4rwOKNo/AFrx1Ph42W+rx8NORJeA+7
         /i5+l2DMX7sZ1z8UNPmIk5XE6PtbTEL1L/HbvV98wYKAnecUiOBkFuFSnzuCbAsO/I
         bWuhmAgQ1XPaLianukIFNSTNm8Mo2VOn1vH2IIl49WMjt5rSHP1Ng2ySv+y/rC761v
         jh+ttR9sKenFu+PyiVVH2DLs0KMRHVfO/AcnWUz9fSyk/Cp8z9rRhRCa8cLbGd1pmN
         h/ziocCzR8ucw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162063700174.17347.6390444355623227203.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 10 May 2021 08:56:41 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] Add octal DTR support for Macronix flash (2021-05-10T08:20:34)
  Superseding: [v3] Add octal DTR support for Macronix flash (2021-04-20T06:29:37):
    [v3,1/3] mtd: spi-nor: macronix: add support for Macronix octal dtr operation
    [v3,2/3] mtd: spi-nor: macronix: add support for Macronix octaflash series
    [v3,3/3] spi: mxic: patch for octal DTR mode support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

