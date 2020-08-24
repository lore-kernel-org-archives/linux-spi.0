Return-Path: <SRS0=I8nA=CC=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FA1C433DF
	for <linux-spi@archiver.kernel.org>; Mon, 24 Aug 2020 20:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E2C204EA
	for <linux-spi@archiver.kernel.org>; Mon, 24 Aug 2020 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598301617;
	bh=98TAs3394Angwdo/CJWv15bKYp6uQTcoa35G85xZqHo=;
	h=Subject:From:Date:To:List-ID:From;
	b=inP+LLBn6/s2U46NXB7UKq0P3+aKnkk+HcSwdP3hqkfunecrQDqtrE3RmRo4YI8cX
	 1offXkmqWRaveP3W1Gam9/+/PgLPb3sbCfxA1fUZTfyo/s4u7Hv2XaAaBBvsJBGGiQ
	 OI8+B2l3fo8eS/gHgwIdHfKVihdmYNNZ0EcraXNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgHXUkR (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgHXUkO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 24 Aug 2020 16:40:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598301614;
        bh=98TAs3394Angwdo/CJWv15bKYp6uQTcoa35G85xZqHo=;
        h=Subject:From:Date:To:From;
        b=aMYC3n3sjT3DTmpxH32394Qc7K6K12yMY/Ccdwq0qvVJmmh9paTqEBUdSBwl6Kt8K
         oOU6Wkfz4EI+cnT+N2pyHSRos3XTOQkI2e0UvpvQUkaY6KhQY/+x57Ns7xEfDpm6o6
         qO7gmdgprkZj+/ND7BlZeE0dqPmk35Nob58CCwSI=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159830161458.12786.4590556112929641157.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 24 Aug 2020 20:40:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] spi: Adding support for Microchip Sparx5 SoC (2020-08-24T20:30:04)
  Superseding: [v4] spi: Adding support for Microchip Sparx5 SoC (2020-07-24T11:13:58):
    [v4,1/6] spi: dw: Add support for RX sample delay register
    [v4,2/6] spi: dw: Add Microchip Sparx5 support
    [v4,3/6] arm64: dts: sparx5: Add SPI controller and associated mmio-mux
    [v4,4/6] dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus rx-sample-delay-ns property
    [v4,5/6] arm64: dts: sparx5: Add spi-nor support
    [v4,6/6] arm64: dts: sparx5: Add spi-nand devices


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
