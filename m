Return-Path: <SRS0=eEd2=7F=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8FBC433E0
	for <linux-spi@archiver.kernel.org>; Sat, 23 May 2020 12:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D498A20727
	for <linux-spi@archiver.kernel.org>; Sat, 23 May 2020 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590237615;
	bh=40t+t+c0l4Us5Zb+GvJjY7BiJJtU9a7Ayxi//uHqmWM=;
	h=Subject:From:Date:To:List-ID:From;
	b=0cghuSO2GiWm18iaNy4vagUkiTYrMAn/B3QOH92PrDLt3P5VJ18RlkPQH14b2yg3+
	 vyTI57gfp8O7nNXSQE+rv56ppNNJ789yF48zqWARq2PoOGmG8EhVATEEiJ2h7kovca
	 1UDp770UiYOg/7cBEtLcmOvjvxVrxU9WMCSlQk90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgEWMkP (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 23 May 2020 08:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgEWMkP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 23 May 2020 08:40:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590237614;
        bh=40t+t+c0l4Us5Zb+GvJjY7BiJJtU9a7Ayxi//uHqmWM=;
        h=Subject:From:Date:To:From;
        b=nV1FK6V44PjNxBoU3pcAAk3W9zmTBMzHVbNImq+td+BMSdHxf4C3NnIcmYrp7lt9u
         30R/w8P5VvfPzmV+lf1OO0553BaTqPgID4f+Apb6Z1O37BJWDNVsfrq/D2M1sGAM0G
         oHZAJ8ycJZ8VZYW3kRy/sWqyV5pETsmTTmBrn7ok=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159023761488.6335.10958982289880792244.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 23 May 2020 12:40:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: tegra20-slink: Fix runtime PM imbalance on error (2020-05-23T12:29:09)
  Superseding: [v1] spi: tegra20-slink: Fix runtime PM imbalance on error (2020-05-21T07:49:46):
    spi: tegra20-slink: Fix runtime PM imbalance on error


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
