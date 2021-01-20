Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14690C433DB
	for <linux-spi@archiver.kernel.org>; Wed, 20 Jan 2021 22:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD886235FF
	for <linux-spi@archiver.kernel.org>; Wed, 20 Jan 2021 22:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbhATVif (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 20 Jan 2021 16:38:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:47420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387499AbhATU5H (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 Jan 2021 15:57:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A686233FC;
        Wed, 20 Jan 2021 20:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611176186;
        bh=ePjS/K4VxqGwia//zbnoAI4yZNX8i7Cx/nMndHVuMRU=;
        h=Subject:From:Date:To:From;
        b=tzQCV+E1cE6Ofv63C5/J3BnyckJEdnR/NanWs62Nqr2vwmK9Ty1JNJVjGPecQvpb5
         ClfcL0ZsdZvM72pv5stWP6ssQedzQV4dfVyQOPVxvbSgwt2zRQ2qtEdsV5HiY2xW21
         1nooadxFIq3NxbEtweDWdGGDycy7PwePmRAWHYhcWyQmivlKdzqBB9HgMXwR73GsPD
         ZtCc8ZH0A5Z1DwECx2KElcJlFaeNhzWRzfriTiJILe4EuC1+aLbj2SN3LVZG67wjVU
         bvDEC1joJiGGGxDMfNJphtfkQEnGHk3FMPFcFq8OBxGy3D7Irl0J6CoJjYKBSZMM8/
         xb1SoCuvJM3Eg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161117618654.29015.1717682633571727488.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 20 Jan 2021 20:56:26 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: Add support for Realtek RTL838x/RTL839x SoC SPI (2021-01-20T13:59:28)
  Superseding: [v4] spi: Add support for Realtek RTL838x/RTL839x SoC SPI (2021-01-05T23:28:14):
    [v4,1/2] dt-bindings: spi: Realtek RTL838x/RTL839x SPI controller
    [v4,2/2] spi: realtek-rtl: Add support for Realtek RTL838x/RTL839x SoC SPI controllers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

