Return-Path: <SRS0=zI59=EM=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EE6C2D0A3
	for <linux-spi@archiver.kernel.org>; Fri,  6 Nov 2020 17:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD5D2151B
	for <linux-spi@archiver.kernel.org>; Fri,  6 Nov 2020 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604684304;
	bh=bPGMLQiYxNcNw2HcpqKI8QwxMlP7Ov1y7TcQduSzZYk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jns8vndUntn34LBybQxfIaKVhbYgEVAZDbEUnX1mMPyUB5yvQPaVT1rDgsSPiKL6e
	 ygQzTfqd4/MEwGHpY5GEFUcfAiZE92CqbCFve75dRs1mu7fv7h4jKzJl4kcKzJdP5C
	 tEpyDW0daAkeIBk1rT3Opp4NrUMUm0l13iH80whA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgKFRiY (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:38:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKFRiY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 12:38:24 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48AD72151B;
        Fri,  6 Nov 2020 17:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604684303;
        bh=bPGMLQiYxNcNw2HcpqKI8QwxMlP7Ov1y7TcQduSzZYk=;
        h=From:To:Cc:Subject:Date:From;
        b=m/EidZyaYAefHIPkvoeSAJjg3vfrTDOIJiVfyoJWD2DyDXU7uBktQD7nj9efnKLVl
         Q/J/2VaRzJi0SKtFvebXz66NZTrIUIoqQQW6686yrdJhmA8wE1Vwvwj7gy+uQpAtdz
         cjYDGPWtrDiREM59QGjqsaex8OAS6uvaigTInyhE=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.10-rc2-2
Date:   Fri, 06 Nov 2020 17:37:59 +0000
Message-Id: <20201106173823.48AD72151B@mail.kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The following changes since commit 9bd77a9ce31dd242fece27219d14fbee5068dd85:

  spi: fsl-dspi: fix wrong pointer in suspend/resume (2020-11-04 17:50:24 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.10-rc2-2

for you to fetch changes up to bc7f2cd7559c5595dc38b909ae9a8d43e0215994:

  spi: bcm2835: remove use of uninitialized gpio flags variable (2020-11-06 11:23:26 +0000)

----------------------------------------------------------------
spi: Fix for v5.10

This is an additional fix on top of 5e31ba0c0543 (spi: bcm2835: fix gpio
cs level inversion) - when sending my prior pull request I had
misremembred the status of that patch, apologies for the noise here.

----------------------------------------------------------------
Martin Hundebøll (1):
      spi: bcm2835: remove use of uninitialized gpio flags variable

 drivers/spi/spi-bcm2835.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
