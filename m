Return-Path: <SRS0=0Kns=C5=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F13C43465
	for <linux-spi@archiver.kernel.org>; Sun, 20 Sep 2020 11:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D009A21BE5
	for <linux-spi@archiver.kernel.org>; Sun, 20 Sep 2020 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600602017;
	bh=4YX7kFbrQAZ2dbBn4LIld0Vao8YGvDuHIwmhfD8afQE=;
	h=Subject:From:Date:To:List-ID:From;
	b=zRbzR4LCACgAb23TLtFNZfWl+e7HE5ldElEb+yphhycevyh0YQGKvhRQjp8RYU9XM
	 AeUH0SGmZlMUkQRR/h1mvi0BiSl1P49OtGDhCP9jl7nMldwtNN3oByrEzVAntBXp/Y
	 qlIheaU9JJsqpw80xPf/nkCJV9RLXS9IgwY3n9ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgITLkR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgITLkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 20 Sep 2020 07:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600602016;
        bh=4YX7kFbrQAZ2dbBn4LIld0Vao8YGvDuHIwmhfD8afQE=;
        h=Subject:From:Date:To:From;
        b=jxOioKycqFQyr/+oW2NLFqgy3ZPi2HPtreGAvE+vlnx0KCA5MxWubVD7P2CVswK9O
         kCuoUiSsWT58jc7TRSNyuGM2+F/KW4lM3CDadIFzDizikSPPga8TvE91ZkFxE//o8J
         Mf7JuJokUjYJduosZiFVMCnvOtGynwZwMhT66sn4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <160060201683.3089.3459316833921715408.git-patchwork-housekeeping@kernel.org>
Date:   Sun, 20 Sep 2020 11:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: dw-dma: Add max SG entries burst capability support (2020-09-20T11:23:20)
  Superseding: [v1] spi: dw-dma: Add max SG entries burst capability support (2020-07-31T07:59:46):
    [1/8] spi: dw-dma: Set DMA Level registers on init
    [2/8] spi: dw-dma: Fail DMA-based transfer if no Tx-buffer specified
    [3/8] spi: dw-dma: Configure the DMA channels in dma_setup
    [4/8] spi: dw-dma: Move DMA transfers submission to the channels prep methods
    [5/8] spi: dw-dma: Detach DMA transfer into a dedicated method
    [6/8] spi: dw-dma: Move DMAC register cleanup to DMA transfer method
    [7/8] spi: dw-dma: Pass exact data to the DMA submit and wait methods
    [8/8] spi: dw-dma: Add one-by-one SG list entries transfer


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
