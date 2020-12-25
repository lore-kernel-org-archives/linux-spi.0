Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89821C433E6
	for <linux-spi@archiver.kernel.org>; Fri, 25 Dec 2020 10:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D37230FA
	for <linux-spi@archiver.kernel.org>; Fri, 25 Dec 2020 10:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbgLYK5k (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 25 Dec 2020 05:57:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729087AbgLYK5k (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 25 Dec 2020 05:57:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 88C26230FA;
        Fri, 25 Dec 2020 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608893819;
        bh=54idllpJQWfkJUa0o41vlUhyCEX67heeSPx74jRQnx0=;
        h=Subject:From:Date:To:From;
        b=tM0ZFty6RYwM1A4BNOj12FUy72RGqJ7i2W0hfXS5FepJAYZHio1cU9QHSUC3H7iv7
         zq8qNVZ0d9byny5N42x6kaQG96tTE7C84AkbDJMsCxZGw16ywUb5utveHuHqxTRB7f
         RMYycquwy2lJJ1JyYixJHtl/RF24sXtbHAniuTq62PnaMaLLWX0yQkkqdQ0wJLGs2r
         NZ/xTZgb0zKrMUgZyQ52WlcjxSu8vViN7+21bxodNcpZ3gS/VO7jkWRk3SyOFPdHJj
         gsQVCjOx0FM5It25Ez7yX5gD6P8JMvwc5fTt5cL0KDq5e8e+ZbFLv2CWsfLGcfpWvQ
         6guWl2qzIeLLg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160889381952.10385.9659882564455176457.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 25 Dec 2020 10:56:59 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: LS7A: Add Loongson LS7A SPI controller driver support (2020-12-25T10:35:51)
  Superseding: [v3] spi: LS7A: Add Loongson LS7A SPI controller driver support (2020-12-14T05:58:51):
    [v3,1/4] spi: LS7A: Add Loongson LS7A SPI controller driver support
    [v3,2/4] spi: ls7a: Add YAML schemas
    [v3,3/4] MIPS: Loongson64: DTS: Add SPI support to LS7A
    [v3,4/4] MIPS: Loongson: Enable Loongson LS7A SPI in loongson3_defconfig


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

