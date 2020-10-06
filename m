Return-Path: <SRS0=+2U+=DN=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5814C41604
	for <linux-spi@archiver.kernel.org>; Tue,  6 Oct 2020 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91D132075A
	for <linux-spi@archiver.kernel.org>; Tue,  6 Oct 2020 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601998204;
	bh=EuQwVZiRMy1h3Unm6i1F//YuOeeHQiWo/Bn0zePk/1s=;
	h=Subject:From:Date:To:List-ID:From;
	b=1IeXRd8E7RwD704wd7lngitHi4vrZfqqogU5g48459AetkpZknA19XZeYCrj+1PLN
	 OKri1ZdADT5m7sduvOzZg8Bz/Cqajk+bHjaRbYaf5ptgIrdnCfebc+7IKu/VxY39Eu
	 EPJXBKOxoZxyCy032dFkaKRo5DA/1sTSIDFpw/qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJFPaE (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 6 Oct 2020 11:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJFPaE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 6 Oct 2020 11:30:04 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601998203;
        bh=EuQwVZiRMy1h3Unm6i1F//YuOeeHQiWo/Bn0zePk/1s=;
        h=Subject:From:Date:To:From;
        b=nx33bpk6TiPCcX6ElYUIwppl6Uvwqa4yQOnC9Fk9Q1kjgYUmoerMXTYS8xqMzza5L
         wghdMmObwaM/pZ/xcolHbcGiXuPs19cGwuBrlQyOk2Rd6UwSgSU6CouCRLU8FPn6xZ
         XPPRtCL+TFCyll/zqCj/88lJac7ZEaqOmokKGPUw=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160199820351.11686.1005273253405060886.git-patchwork-summary@kernel.org>
Date:   Tue, 06 Oct 2020 15:30:03 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: spi: spi-mtk-nor: Add mt8192 support.
  Submitter: Ikjoon Jang <ikjn@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=360161
  Lore link: https://lore.kernel.org/r/20201006075405.11658-1-ikjn@chromium.org
    Patches: [v5,1/4] dt-bindings: spi: add mt8192-nor compatible string
             [v5,2/4] spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
             [v5,3/4] spi: spi-mtk-nor: support 36bit dma addressing
             [v5,4/4] spi: spi-mtk-nor: Add power management support

Total patches: 4

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


