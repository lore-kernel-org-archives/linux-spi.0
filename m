Return-Path: <SRS0=zsPE=A4=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88709C433E1
	for <linux-spi@archiver.kernel.org>; Fri, 17 Jul 2020 22:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657182070E
	for <linux-spi@archiver.kernel.org>; Fri, 17 Jul 2020 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595023221;
	bh=wqxZoJ03ajhLa5Kg4TfK1HfFOUr3/rR0nWoY+jB1HF8=;
	h=Subject:From:Date:To:List-ID:From;
	b=P1FDENv/ginr5VK0qSrb43aVK116ZbrSnciYjfCF2/h6tHdGqZyuifJ+rrVN4H7fI
	 2180pfhe0w3rogLpkMevMLXCsB3R7G8GFoxkdSd7WJwPQFc4IOOi334c5RIw2bnoFY
	 s9I3qqdvtMOmKHqdhOJBE8FsJxJiit3WaeZ1+JI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGQWAV (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgGQWAU (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 18:00:20 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595023220;
        bh=wqxZoJ03ajhLa5Kg4TfK1HfFOUr3/rR0nWoY+jB1HF8=;
        h=Subject:From:Date:To:From;
        b=HGUb0EBRHRKhyLgAz1Nrc+rMsZfHLkoJkNP2YM/QrQeIE/rypJMTpTmqZpWpJuu3R
         CT7/tL65mCTafxmUZYuEFk99qIuyMdMrYzd9U5vSZ1PRxRUfWpY/VqmIz8mERXz/Ba
         jqafQ5j6BdK3f9D1F9B2myrgxKMK7m8WC8hPMH9k=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159502322070.27877.7149479150263128497.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 17 Jul 2020 22:00:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM (2020-07-17T21:56:48)
  Superseding: [v1] spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM (2020-07-14T23:02:34):
    spi: lantiq-ssc: Fix warning by using WQ_MEM_RECLAIM


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
