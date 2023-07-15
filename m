Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164CEEB64DC
	for <linux-spi@archiver.kernel.org>; Sat, 15 Jul 2023 11:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjGOLx3 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 15 Jul 2023 07:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjGOLx2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 15 Jul 2023 07:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AFC35BC;
        Sat, 15 Jul 2023 04:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52D1A60B86;
        Sat, 15 Jul 2023 11:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333B8C433C8;
        Sat, 15 Jul 2023 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689422006;
        bh=qghMVI8NRcAKDY8XdDTEQeqW3TKWyCTYNcDkttkSEUw=;
        h=From:To:Cc:Subject:Date:From;
        b=u1Yj7HhTIXwfJHuANWCE/ziiKXk9T00CTWrDdnh6kEKy9xuW5rR3QCA8dkhUlD+h7
         gTpa3ZXeWtQV/oHnsWahbm4PMs9CBduwgAoogZUyRC1ZfOFunmmegLaJ0+wFl04sQc
         ftRnnEklVYMmCOz/Ch+gQhbVr3BF1CcQC+GQrmWz6m/Fn3kWo4+uJADL0lVzT1+dx2
         bvk1mQARKH61jd00RCe148iszNK31bgMla3Qbhpl7QdZK/PGvqnwja0064ayL08R9i
         WUImXHqk5fI3rxadrlwhI/RDQN9XE1k+FFv3eRsVg+83fqUaeqRFlzSOYP4Flm+k4l
         oYKvDXVRAITOw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.5-rc1
Date:   Sat, 15 Jul 2023 12:53:19 +0100
Message-Id: <20230715115326.333B8C433C8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 879a879c216a41f5403d8d3dbc204a48501912bf:

  spi: bcm{63xx,bca}-hsspi: update my email address (2023-07-04 13:54:19 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.5-rc1

for you to fetch changes up to 54ccc8758ef4d29de9e8fdb711c852abbdd4103a:

  mailmap: add entry for Jonas Gorski (2023-07-12 13:11:08 +0100)

----------------------------------------------------------------
spi: Fixes for v6.5

A couple of fairly minor driver specific fixes here, plus a bunch of
maintainership and admin updates.  Nothing too remarkable.

----------------------------------------------------------------
Jaewon Kim (1):
      spi: s3c64xx: clear loopback bit after loopback test

Jonas Gorski (3):
      spi: bcm63xx: fix max prepend length
      MAINTAINERS: add myself for spi-bcm63xx
      mailmap: add entry for Jonas Gorski

Ryan Wanner (1):
      MAINTAINERS: Add myself as a maintainer for Microchip SPI

 .mailmap                  | 1 +
 MAINTAINERS               | 9 ++++++++-
 drivers/spi/spi-bcm63xx.c | 2 +-
 drivers/spi/spi-s3c64xx.c | 2 ++
 4 files changed, 12 insertions(+), 2 deletions(-)
