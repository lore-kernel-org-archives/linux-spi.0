Return-Path: <SRS0=1/NZ=EL=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D76C00A89
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 12:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8693A20756
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 12:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604580970;
	bh=Rbs/MHUd4lPbCitOsaOTUzoqvs1TbxkkSOwTO3WJND8=;
	h=Subject:From:Date:To:List-ID:From;
	b=1NQwgcwulrc91OdUyGEFdBrtyLIsqKzkAS7JJV3ijKM3LLt2HleXt/OPQrHfQLqX+
	 E8wE9PzMCsfyxnGTlZDLxqc6Uxzg2/0tHuDKenBxnBQg8tBar69hlhlIQGqHZ918yk
	 rpZUwu/XD5nS+yO7vo1z/O6Z3PYc9ps8Aoblw17k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgKEM4K (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbgKEM4J (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:09 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604580968;
        bh=Rbs/MHUd4lPbCitOsaOTUzoqvs1TbxkkSOwTO3WJND8=;
        h=Subject:From:Date:To:From;
        b=H1rIEpJAxZneK+0uizXmQarD5k/WMHMCgZgbfvoz8QRHPTUw6zE/K1l+keNQRKOXH
         EW0HX9D+r0yveBFP5nrWLJC4fFlBsHGymKniqVPXWFrnUI4DZC7JVimVyAmLziobDA
         8vDJRGq/xfjn14AJZK+G3/+WFbDckdY6PxaspRRk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160458096880.28452.10910451926774968421.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 05 Nov 2020 12:56:08 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Porting ASPEED FMC/SPI memory controller driver (2020-11-05T12:03:27)
  Superseding: [v2] Porting ASPEED FMC/SPI memory controller driver (2020-11-03T07:21:58):
    [v2,1/4] dt-bindings: spi: Add binding file for ASPEED FMC/SPI memory controller
    [v2,2/4] ARM: dts: aspeed: ast2600: Update FMC/SPI controller setting for spi-aspeed.c
    [v2,3/4] ARM: dts: aspeed: ast2600-evb: Adjust SPI flash configuration
    [v2,4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

