Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD57C64E7C
	for <linux-spi@archiver.kernel.org>; Wed,  2 Dec 2020 17:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0FFB221FA
	for <linux-spi@archiver.kernel.org>; Wed,  2 Dec 2020 17:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbgLBRbB (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 2 Dec 2020 12:31:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387594AbgLBRbA (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 2 Dec 2020 12:31:00 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606930220;
        bh=FZe+dtwmn21XEselnXTPUj+kxibvoly/w2+BCPJGTNY=;
        h=Subject:From:Date:To:From;
        b=Ln5WvdKfOblqSwCO2klK/30pny9jVHIi5kZLMWH6gJ3ozS30wz1eDE2mdHk+UE/6E
         QXuKrk95/ki+ghK7d+e3OtKYPuEgTuWxy4zkCg/pqdjxdVxPKRog233XQqQL4zkdop
         BoPwOKXJm97nATlxphVt2ycgM+GLKxKEwhVBC3YU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160693021986.1372.3612056546569152035.git-patchwork-summary@kernel.org>
Date:   Wed, 02 Dec 2020 17:30:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: spi-fsl-dspi: Use max_native_cs instead of num_chipselect to set SPI_MCR
  Submitter: Maxim Kochetkov <fido_max@inbox.ru>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=394731
  Lore link: https://lore.kernel.org/r/20201202142552.44385-1-fido_max@inbox.ru

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


