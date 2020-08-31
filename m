Return-Path: <SRS0=StxT=CJ=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D8C433E2
	for <linux-spi@archiver.kernel.org>; Mon, 31 Aug 2020 13:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD6C2073A
	for <linux-spi@archiver.kernel.org>; Mon, 31 Aug 2020 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598880018;
	bh=qqRMl07TblncPVGM3WHF+6pI43fWrte5kuMY58JeBIE=;
	h=Subject:From:Date:To:List-ID:From;
	b=hs28qg+WYABGLrfop95ic+wOoNxHM0qvROlm6J8LkBW/f56wwnbgAm3NVYcSterpT
	 VLLD9vTnU5s8id3ZD7kTffqjqzhLgjFz5aADe0sHmFeyJ3M4kCjJf9NC0Z0NAUEEf0
	 LdbXd4KbVxwrda9tWMATF2OU9zhvVSqd85XtwyWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHaNUR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgHaNUO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 31 Aug 2020 09:20:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598880014;
        bh=qqRMl07TblncPVGM3WHF+6pI43fWrte5kuMY58JeBIE=;
        h=Subject:From:Date:To:From;
        b=gpjAAvksOfECKi40brjxPBnE04ND34LSHNPf7j8Wmgaxw15qZVaZhLLOQ70VHKujN
         Z660iS+s9skO3SXkLG5qDSgV+h69v+L4wpYs7reptQZScUdwDY0+iXuCBBZEQJuRi1
         pSOIM/3yw6Qo/qepqbNBoDXQY6bkuTQUHFYoX7X0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159888001402.30411.12295766006154825332.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 31 Aug 2020 13:20:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads (2020-08-31T13:07:20)
  Superseding: [v1] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads (2020-08-28T07:47:26):
    spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
