Return-Path: <SRS0=8jN7=72=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B0DC433E1
	for <linux-spi@archiver.kernel.org>; Sat, 13 Jun 2020 19:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267D1207DD
	for <linux-spi@archiver.kernel.org>; Sat, 13 Jun 2020 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592076017;
	bh=Pax1SIuid11+T1SSmAgnQXbNByXoAA+Z4crH2sNh154=;
	h=Subject:From:Date:To:List-ID:From;
	b=cLPztRR19RsZqkC4hwbKOb3ks5PFDD4hgrg4Y8EXv02QP93fAWh84e/J8bePKyaOc
	 sJ9oHuG8JvJaSDkHkNkJ2Q/tWFEI2IeeIfs/c94IhAx/7dBt0KSJVsgzK8X836i+7Y
	 vSfsnaiKu4uyFPvtoN8okHOPwfsCHHUD2LoNCxzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFMTUQ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgFMTUQ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 13 Jun 2020 15:20:16 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592076016;
        bh=Pax1SIuid11+T1SSmAgnQXbNByXoAA+Z4crH2sNh154=;
        h=Subject:From:Date:To:From;
        b=p1UpxyMy305P/56ySNIk2+gfxqScZBK8qiGcQMlutNK5WV1L3TNi1bJmDfVIpslc9
         YIPXjjmiSTRgifuTL1ztfauNOvKoyA7JJBcd5M/MH5uZfNHeKSPsNfOAgjM0SexelZ
         ElUZTufVofXgKA7/OJcw/FVYYFXAF+XUsSERR/ns=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159207601622.21263.9449785326062240158.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 13 Jun 2020 19:20:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: add Renesas RPC-IF driver (2020-06-13T19:18:34)
  Superseding: [v3] spi: add Renesas RPC-IF driver (2020-05-08T19:54:10):
    [v3] spi: add Renesas RPC-IF driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
