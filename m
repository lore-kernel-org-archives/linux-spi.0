Return-Path: <SRS0=cHRz=EK=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064CBC2D0A3
	for <linux-spi@archiver.kernel.org>; Wed,  4 Nov 2020 20:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9656B207BB
	for <linux-spi@archiver.kernel.org>; Wed,  4 Nov 2020 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604523030;
	bh=bM0zQRBPRXg2VIUFPHamul6nlJBYor4QmRq/2m4cMug=;
	h=Subject:From:Date:To:List-ID:From;
	b=xsT5dv8av1YgWBm1yY8RwnfmmHBqHMvx/ZkxE3gQttvWuGD9OgBj4mivZptX6kn30
	 YMK0GUJX0eT3Z+6pgZVcpLCqMB6/OJLYELYEdhynk4Jg3Jj6VMcJ8Yalq9XndT0Kku
	 oy1o4L1D0kI6gfYt1PlJ7dzgn23Dsg6BiSY66U48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKDUua (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:50:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgKDUua (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Nov 2020 15:50:30 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604523029;
        bh=bM0zQRBPRXg2VIUFPHamul6nlJBYor4QmRq/2m4cMug=;
        h=Subject:From:Date:To:From;
        b=TAz9HYSuTKyQCnj5BcbvgAytyfrl9murXFfDW4thoCmMELHVQupDoF88q0GjUZdkh
         wXkg/yWWPfvo5GHOvX2B5svey8Yx4zVZ6enIRTgfmzf/naL2uHzKU1S7KG9n9mL8Y3
         oepkxef0QqUlySDj7CtBwi5Hp4ptE1scvBNXFPiY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160452302948.20888.7072534511935618124.git-patchwork-summary@kernel.org>
Date:   Wed, 04 Nov 2020 20:50:29 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: spi: fsl-dspi: fix NULL pointer dereference
  Submitter: Qiang Zhao <qiang.zhao@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=372907
  Lore link: https://lore.kernel.org/r/20201029084035.19604-1-qiang.zhao@nxp.com
Patch: [v2] spi: fsl-dspi: fix wrong pointer in suspend/resume
  Submitter: Qiang Zhao <qiang.zhao@nxp.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=375995
  Lore link: https://lore.kernel.org/r/20201103020546.1822-1-qiang.zhao@nxp.com

Total patches: 2

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


