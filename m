Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F2CCDB474
	for <linux-spi@archiver.kernel.org>; Tue, 17 Oct 2023 20:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjJQU4h (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 17 Oct 2023 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjJQU4h (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Oct 2023 16:56:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF992
        for <linux-spi@vger.kernel.org>; Tue, 17 Oct 2023 13:56:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A853AC433C7;
        Tue, 17 Oct 2023 20:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697576195;
        bh=rIs9bJ898+LbFc5JDKxDr1RPZ5zIAHG9kY76CX45qsQ=;
        h=Subject:From:Date:To:From;
        b=l5VbD9KSIUWC5N2TSyg1WRoP2X/AdM9de7Klu82LwXsjgTEisXQOE/Zcn3Pp7VLuC
         GBS0p2gqwIrHssm7NoBTlBKQCOmxFflyQAvItVO4SN+mfaqh+Q2x1c2w/0Rb/piapX
         IkE3rA7eWt1dVoMdA1ZnCAntW02tWzC5cTxvTlHVYGJKtE6p2OQ2cM0D/CuL9peLWF
         lznNYbqi9xHsXNg4iJN/pVT8yvYr6DoSDwFj8ztSyrrex7SzwUMSalWHdsBUps5KPi
         GtUAphr+aARUzXLqVePNE/U1gIpy2ZQYTqufoZAS9C3biRvgbhOUFIchTD7H5fsMDa
         DaUvc1+eNV69w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96A0BE4E9BC;
        Tue, 17 Oct 2023 20:56:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <169757619561.17036.4075191865930420766.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 17 Oct 2023 20:56:35 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: stm32: Explicitly include correct DT includes (2023-10-17T20:33:51)
  Superseding: [v1] spi: stm32: Explicitly include correct DT includes (2023-10-09T21:13:44):
    spi: stm32: Explicitly include correct DT includes


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

