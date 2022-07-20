Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A3C43334
	for <linux-spi@archiver.kernel.org>; Wed, 20 Jul 2022 13:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiGTN4l (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 20 Jul 2022 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTN4k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 09:56:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34E928E04
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 06:56:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C03EB81F6C
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 13:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20798C3411E;
        Wed, 20 Jul 2022 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658325397;
        bh=noUDan786b3msc7gJzT/DR9MRTmpIcG3mLcVMjDbMzE=;
        h=Subject:From:Date:To:From;
        b=aXWtcyqU76Kw+IPuZXLLB3czG2PoUPZ+EL5kvU1E53dEDQ6Fq07JaT6pnoAeJe8Wp
         hgsR6LavpSSFycW5c4Y6y1452MdH2CjlGwlEaykpcQUT5yH1itL24CCnEvm+vYGqZz
         uySoIVI7d1fObkChi+LgnpRIN9fk50FwkRv5yxEZAPMNRrfM4s5DZLCVpvlq4JyNkL
         Q8Cd4CN9n34Q/NdP+wQY5edhIN+LPJ7U/CsN9k2xO6abQ6hNZXLnPBowAFmxisQ/NR
         w7xSnwtCfL9j4cdIQskaSCP+UVSGP0iq5Kj88d+8fVXXq4T86ZN9QMXc+5AQiOUm7F
         DmW5a3c6OgHgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB075D9DDDD;
        Wed, 20 Jul 2022 13:56:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <165832539687.25821.14270595354523570061.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 20 Jul 2022 13:56:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers (2022-07-20T13:34:16)
  Superseding: [v1] spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers (2022-07-19T07:22:35):
    spi: bcm2835: bcm2835_spi_handle_err(): fix NULL pointer deref for non DMA transfers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

