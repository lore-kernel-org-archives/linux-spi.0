Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5B0C433E0
	for <linux-spi@archiver.kernel.org>; Mon, 22 Feb 2021 16:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A4264DD3
	for <linux-spi@archiver.kernel.org>; Mon, 22 Feb 2021 16:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhBVQLQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:11:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231738AbhBVQKt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 22 Feb 2021 11:10:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7FB1D64E74;
        Mon, 22 Feb 2021 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614010207;
        bh=k1dMW8b0XisfJFHs6C1MWnu2qomqkh4nHY6f7Y3Qhyc=;
        h=Subject:From:Date:To:From;
        b=nla579/KszCnzxEwM1buWfcMa8nX5c7D7mm8GlUe2mlJ0F0YklMM9EAyHZouWs5Mj
         GpSAqtrmasmgck6OfOlsrWgNR/ipoe4IrWMW1GKiv4bgVCrEKxVOFyqq8Iisf8QCtc
         87HO/4ImnuEdVmS3Re/Morw9nXWaDm7mtKLuwtSQHGhqqu7oemeMAeI6afgo3Yf98Y
         IjCgEVtCuD66nErncM5zjyr2r1mjIyf/whaTOB//7DNvyUhH8M5M2TY1CC6/WgRxuH
         mIFiHuJVWvKJ3HnUwN6inFe6bfRqqoTkUCUmOt4op80xgIt8EDpFeOg7Dhaf0yB/m+
         UHin0GxvEKHpQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161401020739.23481.2110346794109846687.git-patchwork-summary@kernel.org>
Date:   Mon, 22 Feb 2021 16:10:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v2] spi: spi-ti-qspi: Free DMA resources
  Submitter: Tudor Ambarus <tudor.ambarus@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=435063
  Lore link: https://lore.kernel.org/r/20210218130950.90155-1-tudor.ambarus@microchip.com

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


