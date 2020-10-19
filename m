Return-Path: <SRS0=A3JY=D2=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB4AC433E7
	for <linux-spi@archiver.kernel.org>; Mon, 19 Oct 2020 15:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBAA422282
	for <linux-spi@archiver.kernel.org>; Mon, 19 Oct 2020 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603122968;
	bh=3bEodLi5qYzVKpGNbbjVSRy7zgHZoy1is862tAMAqv8=;
	h=Subject:From:Date:To:List-ID:From;
	b=vz3fGUs5SpwuxXSf8nlcHOm8lGSdXghWkIZFG+pAZG/n72ckQFtypD4GwMJAR5upR
	 NGpuKfVKj8eLql/UNjeioOshWUDfEpzsx44cRFopEdD01s01FGu1o3V0P9mD7rMVpC
	 37qwgMDKpDRJp2s8pd9f5DwoA8pEt6K9AbuwLvF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgJSP4I (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 19 Oct 2020 11:56:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbgJSP4I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Oct 2020 11:56:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603122967;
        bh=3bEodLi5qYzVKpGNbbjVSRy7zgHZoy1is862tAMAqv8=;
        h=Subject:From:Date:To:From;
        b=KlzsC8VjaDcD9NB26xnWxwxgAJMIYtyvQipJ7HqS97CjBTDKr/uAkB5XRZctrtPhm
         uPfQH1uafVBN//I0tRVQb86/OUSghlDQufGI6NIdnGjNzxWKsC2SmM2p4M10HkjR/Q
         cihbShsvtCEMX2CqGt+qtNlcbsLDdl7vLrJ4AHfo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160312296749.18812.7229956722538811565.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 19 Oct 2020 15:56:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-sun6i: implement DMA-based transfer mode (2020-10-19T14:58:33)
  Superseding: [v1] spi: spi-sun6i: implement DMA-based transfer mode (2020-10-15T15:47:40):
    spi: spi-sun6i: implement DMA-based transfer mode

Latest series: [v2] spi: spi-sun6i: enable autosuspend feature (2020-10-19T15:03:43)
  Superseding: [v1] spi: spi-sun6i: enable autosuspend feature (2020-10-16T08:38:26):
    spi: spi-sun6i: enable autosuspend feature


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

