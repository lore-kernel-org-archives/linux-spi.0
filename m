Return-Path: <SRS0=L3Og=BA=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29A4C433E1
	for <linux-spi@archiver.kernel.org>; Tue, 21 Jul 2020 00:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE05D2080D
	for <linux-spi@archiver.kernel.org>; Tue, 21 Jul 2020 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595290817;
	bh=nMM77ADzATRP6Ucwf9QKkVId0b/9+o5QCou622nCzqI=;
	h=Subject:From:Date:To:List-ID:From;
	b=CkDKD/RW+FtI0hazBXmnP6BSVFAyG/eqh7TD+FGtb5Cy7wACODR2eAGrf2Vc9QaPz
	 7s4eQAaPicrR2E0oWABfwIL9Hl6JZW1/BaDQUWznOrIPeUfw3SZT4LsCfHDAH3PXII
	 HnSDzHPoiCle3+gkP1tClRwBa32+B4CxgppRsBTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgGUAUR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgGUAUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jul 2020 20:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595290817;
        bh=nMM77ADzATRP6Ucwf9QKkVId0b/9+o5QCou622nCzqI=;
        h=Subject:From:Date:To:From;
        b=kOa9msIRXfyasKlBE978nq/GiVma3LwUnO/s7dzKRnkT1BjI/e9ShO58PQ8KNmFou
         NZ6C1u9uzugoGfvhrL5ORnAFW2GiiM6mOeDneQaiatPjg66qiyVmcuc4pBKDaHxDsP
         gX4xTcXZPbO5sNcY4lmY4gZygty+vowRxdIEmD4Q=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159529081698.32752.14936867594064397906.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 21 Jul 2020 00:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: spi-cadence: add support for chip select high (2020-07-21T00:08:50)
  Superseding: [v1] spi: spi-cadence: add support for chip select high (2020-07-10T21:16:55):
    spi: spi-cadence: add support for chip select high


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
