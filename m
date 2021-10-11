Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E276C433EF
	for <linux-spi@archiver.kernel.org>; Mon, 11 Oct 2021 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A35860F23
	for <linux-spi@archiver.kernel.org>; Mon, 11 Oct 2021 16:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhJKQwu (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhJKQwu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 Oct 2021 12:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 44F8860C4A;
        Mon, 11 Oct 2021 16:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633971050;
        bh=6zcQk5D/eGjlQ+lkUZnUuXB39bmz7ycDGSqGJK2F2u8=;
        h=Subject:From:Date:To:From;
        b=bcIbhmyJneUXZnXfbQyAvp7lgXZcN/hLkoGvulkwsv4+1fDMz9smhOs+Qc+I/IVqL
         3M1Py6LMZZuZP2vPFJ9tnS/NC7uzd7/kOXXeTtAJPXCyzLvWJWGUVlhDV9l0h77NBi
         b+LEOa8QESreWVHu1AD/FF6lJWo9SWQ+ziMIHn+kHwA69BJXY2phW8LHNOr+Nx2GpJ
         TednisHvpINA1Xj76Rg8JPGIjqgFrKAi71RK3B24amazhFErU9t+dQB+QWQ8pFn13L
         vwZ8+Kj6OiaU/Xc5K47mVhwlUxdiGANvNhKYSrI8tdVLyhxYtuZ3lXnInW58+LFkZl
         RoS4DPzJR+7Jg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <163397105014.30259.9203798709158747616.git-patchwork-summary@kernel.org>
Date:   Mon, 11 Oct 2021 16:50:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi-bcm-qspi spcr3 enahancements
  Submitter: Kamal Dasu <kdasu.kdev@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=560175
  Lore link: https://lore.kernel.org/r/20211008203603.40915-1-kdasu.kdev@gmail.com
    Patches: [1/3] spi: bcm-qspi: Add mspi spcr3 32/64-bits xfer mode
             [2/3] spi: bcm-qspi: clear MSPI spifie interrupt during probe
             [3/3] spi: bcm-qspi: add support for 3-wire mode for half duplex transfer


Total patches: 3

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


