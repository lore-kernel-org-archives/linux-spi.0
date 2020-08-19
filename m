Return-Path: <SRS0=w6ou=B5=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B45C433E1
	for <linux-spi@archiver.kernel.org>; Wed, 19 Aug 2020 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C033A206FA
	for <linux-spi@archiver.kernel.org>; Wed, 19 Aug 2020 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597843314;
	bh=NOaZzwfwL2S4+MGer2LKS20kh67l8Lh2b2GLa2kgxOE=;
	h=Subject:From:Date:To:List-ID:From;
	b=UxAlZuRBTZIBkfVLzsQkTceC+WdU+WaSCBC/n4kdYh9J8n5e08/1NQ7xpSjIu82xX
	 LvLmVbKb0ILh1zT0AzkNEvby8FWG6Y5hYg+vn3JpoC/WUeqSEtLLsrekxwV9Z/Z4Y4
	 HP5kFtY2toHSkapn9kwRczhZ92oauZWO0NJoc2so=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgHSNVx (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:21:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgHSNUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 19 Aug 2020 09:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597843217;
        bh=NOaZzwfwL2S4+MGer2LKS20kh67l8Lh2b2GLa2kgxOE=;
        h=Subject:From:Date:To:From;
        b=e3Z7Zn5vWa7anDAJCI4rtVNAvtVawPt3obmNl40C9EabfbShDUzhDx9OI5KYFV4HQ
         cg4EL5Uao7ANnRP24vNZ61i+ANCoa9R1j7yRlaVDAbjO2YF4g6h4RZexoRrojHLyaU
         8yrn/TcfUiCpE0g5tkHB+yKjTrY02ka0TW5Y1zak=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159784321735.4613.12688607643735375068.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 19 Aug 2020 13:20:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: rspi: Bit rate improvements (2020-08-19T12:59:04)
  Superseding: [v1] spi: rspi: Bit rate improvements (2020-06-08T09:59:40):
    [1/8] spi: rspi: Remove useless .set_config_register() check
    [2/8] spi: rspi: Use requested instead of maximum bit rate
    [3/8] spi: rspi: Clean up Bit Rate Division Setting handling
    [4/8] spi: rspi: Increase bit rate accuracy on RZ/A
    [5/8] spi: rspi: Increase bit rate range for RSPI on SH
    [6/8] spi: rspi: Increase bit rate range for QSPI
    [7/8] spi: rspi: Fill in spi_transfer.effective_speed_hz
    [8/8] spi: rspi: Fill in controller speed limits


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
