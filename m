Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611A7C433E0
	for <linux-spi@archiver.kernel.org>; Mon, 18 Jan 2021 17:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F55522227
	for <linux-spi@archiver.kernel.org>; Mon, 18 Jan 2021 17:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436653AbhARRxt (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 18 Jan 2021 12:53:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436713AbhARRxs (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 Jan 2021 12:53:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44A5320829;
        Mon, 18 Jan 2021 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610992387;
        bh=0OQWgKZQ6VGf6zu4G8sKJqZ/sYzVV9HDJ8zCK16fQbU=;
        h=From:To:Cc:Subject:Date:From;
        b=Q5bFs066xeFa+TKXr8qDQf+VNQtJ5K0GJM7YsMKAtVElRfaEF3Kp7ZixzKQj9jqHB
         HCxjziWB494pclOdRf0LSXzlTgOi0fBEf8fodxZoXm9z304Xvn8if5mAd2S/GTXR09
         IVZxhs2xWys0B57e7KqoXjDjCxe7D/BxSHV2qK9McGFdCGQmbPGi9igJu3xLyMR0Qp
         xaTB+XneI0/V6p6KtfYtIFkFmq0xcsyfg4mszbmKOW6QtmGyWxlSqSl3uIDikYoHQj
         36ZVzbO83L3z1/egKnn9qNlzsY0GDCOBsWCvgcyyDHnVgYRtjTHaRoxyuUOsiNZ9zj
         4OpxwlI1pgZ6w==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.11-rc4
Date:   Mon, 18 Jan 2021 17:52:20 +0000
Message-Id: <20210118175307.44A5320829@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.11-rc4

for you to fetch changes up to 4d163ad79b155c71bf30366dc38f8d2502f78844:

  spi: cadence: cache reference clock rate during probe (2021-01-15 14:14:38 +0000)

----------------------------------------------------------------
spi: Fixes for v5.11

A few more bug fixes for SPI, both driver specific ones.  The caching in
the Cadence driver is to avoid a deadlock trying to retrieve the cached
value later at runtime.

----------------------------------------------------------------
Christophe Leroy (1):
      spi: fsl: Fix driver breakage when SPI_CS_HIGH is not set in spi->mode

Michael Hennerich (1):
      spi: cadence: cache reference clock rate during probe

 drivers/spi/spi-cadence.c | 6 ++++--
 drivers/spi/spi-fsl-spi.c | 5 ++---
 2 files changed, 6 insertions(+), 5 deletions(-)
