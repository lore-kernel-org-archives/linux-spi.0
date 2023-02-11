Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F924C61DA4
	for <linux-spi@archiver.kernel.org>; Sat, 11 Feb 2023 23:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjBKXZ2 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 11 Feb 2023 18:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBKXZ2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 11 Feb 2023 18:25:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820FA12846;
        Sat, 11 Feb 2023 15:25:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 42ADCB80B03;
        Sat, 11 Feb 2023 23:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8DEC433D2;
        Sat, 11 Feb 2023 23:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676157924;
        bh=e4wjNKz+lNpXFkGW45k8O521ZMwggG5GHVudmevaWK8=;
        h=From:To:Cc:Subject:Date:From;
        b=Ob5dVR1r87sz4ELODkaa+AOsPjnqzoIqZejWHAHkHqFnSOMiqlZcY6Dl4vo+o8sZz
         MTXoJf+UmRsZZvoaDbek+ClvUXnLUO92mo/ixByh2rMtKvKBQEP9GZ0VQAgFGM/VRA
         PI5LUcU0M/2OnuncEMxWh5llc7U1Cli4pLCCd8NbysooVOyECkuwSq83kmaAcFIhgd
         TOwHkziJ4zqeVgSSiHfR21dDJjVxxXrL3gNzb0Dtdajv1S6Z+wAZQZYPVjdLZEiebd
         ZBdXk/6o9f/hYqbVotx5EIKpde34PlRE0rTM4yBrLjvvcn7Ct/yT9eFvtDXgQtsStL
         5pxVYbvMwAGDA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.2-rc7
Date:   Sat, 11 Feb 2023 23:25:10 +0000
Message-Id: <20230211232523.6A8DEC433D2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit b442990d244ba2ffe926c6603c42deb6fcc3b0db:

  spi: Merge rename of spi-cs-setup-ns DT property (2023-01-11 14:15:22 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.2-rc7

for you to fetch changes up to eede42c9459b58b71edc99303dad65216a655810:

  spi: spidev: fix a recursive locking error (2023-01-27 16:38:05 +0000)

----------------------------------------------------------------
spi: Fixes for v6.2

A couple of hopefully final fixes for spi, one driver specific fix for
an issue with very large transfers and a fix for an issue with the
locking fixes in spidev merged earlier this release cycle which was
missed.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      spi: spidev: fix a recursive locking error

Serge Semin (1):
      spi: dw: Fix wrong FIFO level setting for long xfers

 drivers/spi/spi-dw-core.c |  2 +-
 drivers/spi/spidev.c      | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)
