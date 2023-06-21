Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB0EEB64DC
	for <linux-spi@archiver.kernel.org>; Wed, 21 Jun 2023 13:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjFUNYJ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 21 Jun 2023 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjFUNYI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Jun 2023 09:24:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C72191;
        Wed, 21 Jun 2023 06:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F671614C7;
        Wed, 21 Jun 2023 13:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CB1C433C9;
        Wed, 21 Jun 2023 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687353845;
        bh=PK2Q9rLKjKer9YEWmryJ25tGPzX9SXDt3JrNu6UDuAA=;
        h=From:To:Cc:Subject:Date:From;
        b=hS4QEI5VFEbmFmiIYGKr3OHBWOYeFFqKiywdQmR9V9Rf2djX5cIbwBjmdG3VtaDnk
         jognR97OXw29YRpuwR3ES64aWWQ/rvlFAR/08SxCQUzMCf5/odi374WR4HEk5A5N8l
         BQ8VKM8eK0nrdi8OP5Gq5BJfhXnorjmPKRn8DPyjdw9C299MhTnZ6io6UVAefbYqdN
         vfKuD6hgNIlG0K17E8kff2fjMDsmKyqybX/aq2c+hVJ1w+o+fB0e5d4/OfNlPsvrvW
         /1bKJsznpyWUpyD0dwMrV+ixszRndZXslNbACWUSkkEZsTg01RmqlM4ty1yRQF8uHP
         z+cUQpV/b0JEg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.4-rc7
Date:   Wed, 21 Jun 2023 14:23:50 +0100
Message-Id: <20230621132404.E6CB1C433C9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit eee43699217504ba69cadefc85c6992df555e33f:

  spi: dw: Replace incorrect spi_get_chipselect with set (2023-06-13 20:19:26 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc7

for you to fetch changes up to 9d7054fb3ac2e8d252aae1268f20623f244e644f:

  spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan() (2023-06-15 14:58:45 +0100)

----------------------------------------------------------------
spi: Fix for v6.4

One last fix for SPI, just a simple fix for incorrect handling of probe
deferral for DMA in the Qualcomm GENI driver.

----------------------------------------------------------------
Neil Armstrong (1):
      spi: spi-geni-qcom: correctly handle -EPROBE_DEFER from dma_request_chan()

 drivers/spi/spi-geni-qcom.c | 2 ++
 1 file changed, 2 insertions(+)
