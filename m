Return-Path: <SRS0=d3ll=DG=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05964C4346E
	for <linux-spi@archiver.kernel.org>; Tue, 29 Sep 2020 07:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3ED22075F
	for <linux-spi@archiver.kernel.org>; Tue, 29 Sep 2020 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601366259;
	bh=x/uJ+sYAnWIAvc5F3s6Se7uMp2PJa5Dx5TDJyLYDwVE=;
	h=Subject:From:Date:To:List-ID:From;
	b=13o0qekLtXZXwyTncVTztwZaVRdtnoa9Ubah7mWg70BAexXAPa3IeqrEp9ThfVrer
	 AwwBCWtblI0Dk5rX1S/Fck8+TNQ2NTvSrDnX1M3PhPYsdtuNdE8Tnh57i+qRoqjuOc
	 yTXhGhOGUjP7x9TTotYfH3KrVkoX66qtTuxwtHiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgI2H5j (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 29 Sep 2020 03:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbgI2H5g (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 29 Sep 2020 03:57:36 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601366256;
        bh=x/uJ+sYAnWIAvc5F3s6Se7uMp2PJa5Dx5TDJyLYDwVE=;
        h=Subject:From:Date:To:From;
        b=C7xPh4fFM8vTd+2E9mP7laFJ+Lx/Y/IvplIFDowtHCWgO91+FEgZx8JOHydZrZ3Jg
         2e8eqUOSAlM3awWz84giyDtLLW70wzKWynn3g70KmzBA1P/x7uaP3NcvpoZppVY0e7
         1HEEYnnJAZ4ynjQkljFSacoLi/dnluk17Vh1BRZ4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160136625655.7404.724396234399401673.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 29 Sep 2020 07:57:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: spi-mtk-nor: Add mt8192 support. (2020-09-29T07:37:51)
  Superseding: [v2] spi: spi-mtk-nor: Add mt8192 support. (2020-09-18T08:31:18):
    [v2,1/5] dt-bindings: spi: add mt8192-nor compatible string
    [v2,2/5] spi: spi-mtk-nor: fix mishandled logics in checking SPI memory operation
    [v2,3/5] spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
    [v2,4/5] spi: spi-mtk-nor: support 36bit dma addressing to mediatek
    [v2,5/5] spi: spi-mtk-nor: Add power management support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

