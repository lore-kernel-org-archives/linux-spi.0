Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81266C433ED
	for <linux-spi@archiver.kernel.org>; Tue, 11 May 2021 08:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E6061107
	for <linux-spi@archiver.kernel.org>; Tue, 11 May 2021 08:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhEKIal (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 11 May 2021 04:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231134AbhEKIaN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 11 May 2021 04:30:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ED60661107;
        Tue, 11 May 2021 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721747;
        bh=w2WXGZR6msz0prMcOk5jfPOF5Hbx4yUcBFHYzJomcPo=;
        h=Subject:From:Date:To:From;
        b=LvNtI3WwQThSXg+xk85YxMLZkY0NeFWwQcvdKyjinl2hWW/fES42niXY4Ik5HAnVy
         CXkYX/YdvaAMNXhZXo8WLRrqdDu9SgdNDC9v4s1LGaTC11yT6wSSQpXjmSYtYBxo/Y
         zkLeNiWzumwYA2J4dPSoIUdm6esCRCHdNth/aHHM27z3RXjMD7YiglSHaMkHPb2lNE
         JA+hRQdHYNuaiO/98zzY878qeqzvmmrwVLnVGil5Cq+IRkScuYrZl0cs19eWLbiRgw
         hWrGE2oLEQmP+eopXTwaz7XJ9QdzO88e/EXCTqZJ0xZgSGJSnOVBOv7rPsKy4MnvHa
         OFVs0+68fiP8w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162072174684.29505.7656806295448497792.git-patchwork-summary@kernel.org>
Date:   Tue, 11 May 2021 08:29:06 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: imx: Use of_device_get_match_data() helper
  Submitter: Tian Tao <tiantao6@hisilicon.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=452493
  Lore link: https://lore.kernel.org/r/1616385476-53327-1-git-send-email-tiantao6@hisilicon.com
Patch: dt-bindings: Clean-up undocumented compatible strings
  Submitter: Rob Herring <robh@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=449453
  Lore link: https://lore.kernel.org/r/20210316194918.3528417-1-robh@kernel.org

Total patches: 2

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


