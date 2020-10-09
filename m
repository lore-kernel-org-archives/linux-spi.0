Return-Path: <SRS0=7IzD=DQ=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6611C433E7
	for <linux-spi@archiver.kernel.org>; Fri,  9 Oct 2020 23:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A57207CD
	for <linux-spi@archiver.kernel.org>; Fri,  9 Oct 2020 23:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602287279;
	bh=wTFIx2CSqh1G0MpOojsjedYTpM7bEW5o1sXijZJG0tA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nHY4HREqwjdlIZ0UYq1/5JNGuTQlA8pFak4LoaE5Vb+FBWneM9ntZ/g0nK+2fckGg
	 qhDdCxBm4U4wKO7DEwJTZbDlk15F5OkqhIkPk0JcMUcMm/TKo6jFPhPMmq8P0RXqPm
	 ODWPwta4UVagoNmJkQGddFPbPlDP3AOqxM8odAHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgJIXrD (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 9 Oct 2020 19:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbgJIXoh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 9 Oct 2020 19:44:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3827A2072C;
        Fri,  9 Oct 2020 23:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602287068;
        bh=wTFIx2CSqh1G0MpOojsjedYTpM7bEW5o1sXijZJG0tA=;
        h=From:To:Cc:Subject:Date:From;
        b=vbSf2cnnErHzJqQelOJtbP+hojyH0jdd+ljF03QVdBGGn/j94JYNagATE04SzmaBK
         BwF9WFsz5xlM05XrI8gV/SCpIwgjXw5mTpk4L6t2z8yKYmZtHCa01FU5mRxRPUZRk6
         xTYbzu83xG+Ilg3nuo2Xn3vDy3XeN72rJMH+Bb+Q=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.9-rc8
Date:   Sat, 10 Oct 2020 00:44:23 +0100
Message-Id: <20201009234428.3827A2072C@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 00fb259c618ea1198fc51b53a6167aa0d78672a9:

  spi: bcm-qspi: Fix probe regression on iProc platforms (2020-09-24 12:09:46 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.9-rc8

for you to fetch changes up to 1c33524f79853f41e80390b1a223254aadd30bd4:

  MAINTAINERS: Add maintainer of DW APB SSI driver (2020-10-05 13:22:59 +0100)

----------------------------------------------------------------
spi: Fix for v5.9

One last minute fix for v5.9 which has been causing crashes in test
systems with the fsl-dspi driver when they hit deferred probe (and which
I probably let cook in next a bit longer than is ideal) plus an update
to MAINTAINERS reflecting Serge's extensive and detailed recent work on
the DesignWare driver.

----------------------------------------------------------------
Michael Walle (1):
      spi: fsl-dspi: fix NULL pointer dereference

Serge Semin (1):
      MAINTAINERS: Add maintainer of DW APB SSI driver

 MAINTAINERS                | 7 +++++++
 drivers/spi/spi-fsl-dspi.c | 5 +++--
 2 files changed, 10 insertions(+), 2 deletions(-)
