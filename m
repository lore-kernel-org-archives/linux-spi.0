Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B861C433DB
	for <linux-spi@archiver.kernel.org>; Mon, 21 Dec 2020 15:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 128D322BF3
	for <linux-spi@archiver.kernel.org>; Mon, 21 Dec 2020 15:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgLUP50 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 21 Dec 2020 10:57:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgLUP50 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Dec 2020 10:57:26 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608566206;
        bh=euJ0FfyeiqHfY9JYUDJRiY6kvvusScDmF8TCLx8VoBY=;
        h=Subject:From:Date:To:From;
        b=JwabUpeAM9XbVyqEgJoOGBlCFFSpBPm//uJ87xOFGX6g1Z3f2BZuma0vS0KnRd6pD
         gstDpz0HWFcLW4DeNKoEBnFlY6iyeFIdhnnxtkxif+4xUSRbt+wsepmP/8Hj3xn6W2
         T41UexAZI0HvwGPy3eXbUi7V2FdxtpSqZ3TcKbfOwdIgmHqw8scL9sDjosEcj4G4Pl
         F+yanSVj8s5KraL6CCgKWsM8xzELEfPEkrgpdT+erdPMst6kNiv7VVsbU1Bie+XpfO
         SSbFVfWob5nJvo+NMBZTm+CC9+Q388EEs3cTw3w5satbRAKoznc7K2QL5NVpzbUTj9
         WVEcKTbtQ7ohA==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160856620592.1969.13992690310017645107.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Dec 2020 15:56:45 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] spi: uapi: unify SPI modes into a single spi.h header (2020-12-21T15:29:34)
  Superseding: [v5] spi: uapi: unify SPI modes into a single spi.h header (2020-12-21T14:19:04):
    [v5,1/3] spi: uapi: unify SPI modes into a single spi.h header
    [v5,2/3] spi: Add SPI_NO_TX/RX support
    [v5,3/3] spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

