Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFE6C47094
	for <linux-spi@archiver.kernel.org>; Mon,  7 Jun 2021 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3073260FEB
	for <linux-spi@archiver.kernel.org>; Mon,  7 Jun 2021 11:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFGL6l (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 7 Jun 2021 07:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGL6l (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 7 Jun 2021 07:58:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7000960FEB;
        Mon,  7 Jun 2021 11:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623067010;
        bh=LNX3Sau+QyBzRGBlgMHQyD9xygFAyDz7jAG41CBztD4=;
        h=Subject:From:Date:To:From;
        b=BMajFob20rQxgEa+sVQKWsOCvU3UPF7zALvRCsxGEdQRTl7dKdwVNMPYNFm+mJ5NJ
         t3Pbi9SVO9ZhcQPu74BZIkI3L2S7vpWDFc2hU7iClOE35XNgL42dEGGsp2jroXSAIN
         vjCEqvaxXwUJF3d7UdQnfhpnqzUDuypPuGCp1fRyakMqyCxpFw8ZJr+h6kHUCF8Oye
         ZdO5kGAAwPin5zUC1gQGstDLYIbamC+NQyMkqfjKS2E6tqeBuLzbz7vlnbCB+oEqe9
         arnKzPTWFrTShcl7YlcUg+gRq40L+okncMToXmuPiIrcS4f0MG8zBZPIs9DgzpfjB2
         hY/sbGcuhXPpw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162306701038.29931.16776187076507373445.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 07 Jun 2021 11:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v6] Support ROCKCHIP SPI new feature (2021-06-07T11:18:31)
  Superseding: [v4] Support ROCKCHIP SPI new feature (2021-06-07T06:34:42):
    [v4,1/6] dt-bindings: spi: spi-rockchip: add description for rv1126 and rk3568
    [v4,2/6] spi: rockchip: add compatible string for rv1126 and rk3568
    [v4,3/6] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
    [v4,4/6] spi: rockchip: Wait for STB status in slave mode tx_xfer
    [v4,5/6] spi: rockchip: Support cs-gpio
    [v4,6/6] spi: rockchip: Support SPI_CS_HIGH
  Superseding: [v5] Support ROCKCHIP SPI new feature (2021-06-07T10:57:56):
    [v5,1/6] dt-bindings: spi: spi-rockchip: add description for rv1126
    [v5,2/6] spi: rockchip: add compatible string for rv1126 and rk3568
    [v5,3/6] spi: rockchip: Set rx_fifo interrupt waterline base on transfer item
    [v5,4/6] spi: rockchip: Wait for STB status in slave mode tx_xfer
    [v5,5/6] spi: rockchip: Support cs-gpio
    [v5,6/6] spi: rockchip: Support SPI_CS_HIGH


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

