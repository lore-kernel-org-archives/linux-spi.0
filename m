Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D4AC4743C
	for <linux-spi@archiver.kernel.org>; Wed, 23 Jun 2021 17:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4FDC611CB
	for <linux-spi@archiver.kernel.org>; Wed, 23 Jun 2021 17:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFWRIF (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229688AbhFWRIF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Jun 2021 13:08:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50531611AC;
        Wed, 23 Jun 2021 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624467947;
        bh=p2cOw9iOxNby1j1UpRU+HVQ3uwvo4XbPaZB9GXC2nE4=;
        h=From:To:Cc:Subject:Date:From;
        b=Bdt3aDkGHFUIxxk7JRVAQzq6kOm/BBHJqBdwQaVPzQLmJdBJ7a0MceiJRWnfgVDMg
         ZXvIF4psuiKmzSJYro3fmHia5Pkw9X3fPXZBGfXMou9F5k2ef23Duz/fyevcwxylBg
         zYdf2kUETyyFMIM6uScMERFk0qK6xecASeydLVEnwIYx0Lrksvelca0uBD0zQL2eUI
         Z+pdBAGXtDYUA9AyxcBq8oRJEEhE1jwLmLCyR0wMpWrwqSnFMbXhCdm9dCso8CXwfZ
         9TRtbLUd1wAhYKTZChnWEp4Cv+5BNZZJ6E4MrNRvZ3iGXwEKnbg+DGboJxr8Sl4bVU
         vlRhBgKoWthXA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.13-rc7
Date:   Wed, 23 Jun 2021 18:05:18 +0100
Message-Id: <20210623170547.50531611AC@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit d38fa9a155b2829b7e2cfcf8a4171b6dd3672808:

  spi: stm32-qspi: Always wait BUSY bit to be cleared in stm32_qspi_wait_cmd() (2021-06-03 13:55:36 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.13-rc7

for you to fetch changes up to f422316c8e9d3c4aff3c56549dfb44a677d02f14:

  spi: spi-nxp-fspi: move the register operation after the clock enable (2021-06-14 15:02:01 +0100)

----------------------------------------------------------------
spi: Fixes for v5.13

A couple of small, driver specific fixes that arrived in the past few
weeks.

----------------------------------------------------------------
Haibo Chen (1):
      spi: spi-nxp-fspi: move the register operation after the clock enable

Jon Hunter (1):
      spi: tegra20-slink: Ensure SPI controller reset is deasserted

 drivers/spi/spi-nxp-fspi.c      | 11 +++++------
 drivers/spi/spi-tegra20-slink.c |  5 +++++
 2 files changed, 10 insertions(+), 6 deletions(-)
