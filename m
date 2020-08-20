Return-Path: <SRS0=42wJ=B6=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09307C433DF
	for <linux-spi@archiver.kernel.org>; Thu, 20 Aug 2020 22:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D186920FC3
	for <linux-spi@archiver.kernel.org>; Thu, 20 Aug 2020 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597960991;
	bh=4X29S1cNUJhpwwrIKUxx2gwPYbR/p9hDK/Y9vTYlwxQ=;
	h=Subject:From:Date:To:List-ID:From;
	b=EIRlJ7yWVmGlwZaD89dH0dhgNuOMAsWcXxQAxePvmmoxWMDJtoguRah3ojfxLNYTG
	 02uxpS09Oiz+oS0+5lusQUAnCg1cohUNoZE2qlGyyUKvKXCPbOgDjAktOI9iTY9FjB
	 Fo+CYCAMAwYgn2LK+wV9FmR/r4qSuvAlEuhTsEyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgHTWDL (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgHTWDK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 20 Aug 2020 18:03:10 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597960990;
        bh=4X29S1cNUJhpwwrIKUxx2gwPYbR/p9hDK/Y9vTYlwxQ=;
        h=Subject:From:Date:To:From;
        b=bgxO7QDqb66mBgMvOFHwXqkF29qdQGJpuVMaoymbrPvckE5UqqFI4MRIYvakxZXc7
         O8UAH2au/ylxpxv62Bm6UgDF+t3mYS5MTitkEfazTTYMuZ/Px1ruEzF8ZcF/QESiMn
         Pzdqe7KnH6mIE56PlC9JR3IzpXcZ+hShrwd84UMY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159796099051.28136.15204359024661060396.git-patchwork-summary@kernel.org>
Date:   Thu, 20 Aug 2020 22:03:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: rspi: Bit rate improvements
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=335257
  Link: <20200819125904.20938-1-geert+renesas@glider.be>
    Patches: [v2,1/7] spi: rspi: Remove useless .set_config_register() check
             [v2,2/7] spi: rspi: Clean up Bit Rate Division Setting handling
             [v2,3/7] spi: rspi: Increase bit rate accuracy on RZ/A
             [v2,4/7] spi: rspi: Increase bit rate range for RSPI on SH
             [v2,5/7] spi: rspi: Increase bit rate range for QSPI
             [v2,6/7] spi: rspi: Fill in spi_transfer.effective_speed_hz
             [v2,7/7] spi: rspi: Fill in controller speed limits

Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
