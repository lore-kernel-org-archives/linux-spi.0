Return-Path: <SRS0=7jt5=BD=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F161C433E1
	for <linux-spi@archiver.kernel.org>; Fri, 24 Jul 2020 11:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DA72065F
	for <linux-spi@archiver.kernel.org>; Fri, 24 Jul 2020 11:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595589621;
	bh=arRSEr8IPPX809toYRR8JHHDg8+UT/cO7e1sfsNAsA4=;
	h=Subject:From:Date:To:List-ID:From;
	b=U0KgMdCmTyp8vi88zx6QZqrgUt3eJL3fYRZPnvgETHJj3kRs/7O6TVH5ClPaC/bhs
	 p08Y2F9Hz9UIW4QYLRS/qpC4bfP0/OZPjOZPFk848ePLALVBDsXDt8+WeOftR8cqcx
	 oielf5T/FBkCT/yg5puN4RARFy/DFsd32AfLMY3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgGXLUU (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgGXLUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Jul 2020 07:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595589619;
        bh=arRSEr8IPPX809toYRR8JHHDg8+UT/cO7e1sfsNAsA4=;
        h=Subject:From:Date:To:From;
        b=fp5BcXhWu8lV+EeU6fK9d1gCysQBxsxohZZbIl16aqgfCKLTfRZEpG419o8+JD10m
         xo1tmlyIJ+1An+qk6B7F6GgVAXKbLLNOBraa6oe8+Sxb56PS7pgdVZp7S1eoGDP0uu
         zlv0tACwGpnam3q5ZTwxfnrndQSGzHYk5TS8Nwf4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159558961908.24236.2589222503612810455.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 24 Jul 2020 11:20:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: Adding support for Microchip Sparx5 SoC (2020-07-24T11:13:58)
  Superseding: [v3] spi: Adding support for Microchip Sparx5 SoC (2020-07-02T10:13:23):
    [v3,1/8] spi: dw: Add support for RX sample delay register
    [v3,2/8] arm64: dts: sparx5: Add SPI controller and SPI mux
    [v3,3/8] spi: dw: Add Microchip Sparx5 support
    [v3,4/8] mux: sparx5: Add Sparx5 SPI mux driver
    [v3,5/8] dt-bindings: snps,dw-apb-ssi: Add sparx5 support, plus snps,rx-sample-delay-ns property
    [v3,6/8] dt-bindings: microchip,sparx5-spi-mux: Add Sparx5 SPI mux driver bindings
    [v3,7/8] arm64: dts: sparx5: Add spi-nor support
    [v3,8/8] arm64: dts: sparx5: Add spi-nand devices


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
