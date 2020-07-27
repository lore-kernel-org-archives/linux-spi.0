Return-Path: <SRS0=+j3L=BG=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8262BC433DF
	for <linux-spi@archiver.kernel.org>; Mon, 27 Jul 2020 03:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1D620658
	for <linux-spi@archiver.kernel.org>; Mon, 27 Jul 2020 03:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595820023;
	bh=ABEcLC8FHstL/LTWPGfwIhu0rvH3gGF2PELpZrENQQw=;
	h=Subject:From:Date:To:List-ID:From;
	b=NyExApuWwLlG8bHUZrlphgimkvxE0N+RgqjCu03LFI4dZ8BSr+a53259tIOWSO9km
	 CyWTTnBqgOCAVDZ4XyV9utodMtZGrDE4he/MrJ9mdJzd/bkqrcyfvyPS800fGV5tDr
	 LQWNVkwtE1ZitgctoH6xd6AMSohrZTtYvj14z0C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG0DUW (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sun, 26 Jul 2020 23:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgG0DUV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 26 Jul 2020 23:20:21 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595820021;
        bh=ABEcLC8FHstL/LTWPGfwIhu0rvH3gGF2PELpZrENQQw=;
        h=Subject:From:Date:To:From;
        b=uFm17A//780QRgWbop2lHEVooM4U2P8VDIKmTtn+RWvaTWs2VlVzERMGo+HKpryxx
         /ox/qfJNBWX1oiEnfTtBSH2FvDAvgbTno3llWsSAHwzyXkZxsR4hISuHRdxQr/xy0y
         IT2HYioiE7OCU7lqYLogZtjZ+Np8FEOB+ylpJnuA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159582002095.13864.5573638814756740375.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 27 Jul 2020 03:20:20 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Some bug fix for lpspi (2020-07-27T03:14:45)
  Superseding: [v1] Some bug fix for lpspi (2020-07-14T07:52:46):
    [1/5] spi: lpspi: fix the imbalance of runtime pm function call
    [2/5] spi: lpspi: add NULL check when probe device
    [3/5] spi: lpspi: fix kernel warning dump when probe fail after calling spi_register
    [4/5] spi: lpspi: handle EPROBE_DEFER when get cs-gpios number
    [5/5] spi: lpspi: fix using CS discontinuously on i.MX8DXLEVK


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
