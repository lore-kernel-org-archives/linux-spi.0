Return-Path: <SRS0=8NEx=BI=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFD1C433E0
	for <linux-spi@archiver.kernel.org>; Wed, 29 Jul 2020 14:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 933D420FC3
	for <linux-spi@archiver.kernel.org>; Wed, 29 Jul 2020 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596031210;
	bh=YlSaJad5xekbKUL7n8UhsIbXpYS5cu1yZ2y6w5zlaiw=;
	h=Subject:From:Date:To:List-ID:From;
	b=lt+49mUw7KEgQsVvmKJ71fjHgdT2F/MPHVTdPtT0+G1pWIv0zF0amyi5Lskx5mMmE
	 oU9ZcgeIUORw2yJrJuG7bxN4Y5zvYR2+MG3DdSSj/YfBHfTuhoJrrK+sANkAL1v/fr
	 0c4quvz6HYaWuIwdJgR1BOtvtQLXQ5aIXq0inEhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgG2OAK (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgG2OAK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 29 Jul 2020 10:00:10 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596031209;
        bh=YlSaJad5xekbKUL7n8UhsIbXpYS5cu1yZ2y6w5zlaiw=;
        h=Subject:From:Date:To:From;
        b=gUAS5rI29BZLfCM38XFegG2JfUDCPedgjjftm93N1ynap4PPHlbveYi3BF9vnTdpL
         R0R1pSTHU2MHk5DbpFmIc6+G2ntduoDrK8ua1LYUebUszF/CuTinG4FMw1THSuo40c
         rxPjcTrjwwJ+dhu6COKPv3MRqofRxwpGAldHxRVE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159603120970.17142.3746321735858941037.git-patchwork-summary@kernel.org>
Date:   Wed, 29 Jul 2020 14:00:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: Some bug fix for lpspi
  Submitter: Clark Wang <xiaoning.wang@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=324497
  Link: <20200727031448.31661-1-xiaoning.wang@nxp.com>
    Patches: [V2,1/4] spi: lpspi: Fix kernel warning dump when probe fail after calling spi_register
             [V2,2/4] spi: lpspi: remove unused fsl_lpspi->chipselect
             [V2,3/4] spi: lpspi: fix using CS discontinuously on i.MX8DXLEVK
             [V2,4/4] dt-bindings: lpspi: New property in document DT bindings for LPSPI

Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
