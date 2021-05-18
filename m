Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BDEC433B4
	for <linux-spi@archiver.kernel.org>; Tue, 18 May 2021 16:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798A160233
	for <linux-spi@archiver.kernel.org>; Tue, 18 May 2021 16:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350921AbhERQ6J (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 18 May 2021 12:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244114AbhERQ6I (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 18 May 2021 12:58:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9F83960233;
        Tue, 18 May 2021 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621357010;
        bh=TkT2zWelHSgVvaTQA/twoLaarKFI9i+3Qdrap7Y0NvE=;
        h=Subject:From:Date:To:From;
        b=SPHQSem5ZBbcuT8XYvCIRkVel9fbH+TgzUn+JAoglDJwdcud4Bi3Xx7TZg0fK9vZE
         dqfsC40T1h4NfKlAU/Ssx90X4kvJLDIbwJIbIPQo68kLkXmKDxgc9T/qwJ0KyPndR0
         8Ky9oo3gyDSEzs8f2I4pAFiqhmAusuX+2rAAYx570vtP4WMDnoIMN4i8474ns/4nRL
         JcR+L34rEIGPK/JZ9l2crWy80ULhvPNrhUYugLc0XA8F1b9dXA/VzGuN7zUcR4yTMr
         95WrKAbDNQjDajvVM3doRhWJLJjXVjuu+uRFUIve0Ztki9g7kqBEvC9Qof7AgQZ0JZ
         S/8KldFzZGSEA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162135701052.16608.85962963282352115.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 18 May 2021 16:56:50 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v5] MTD: spinand: Add spi_mem_poll_status() support (2021-05-18T16:27:53)
  Superseding: [v4] MTD: spinand: Add spi_mem_poll_status() support (2021-05-18T13:43:32):
    [v4,1/3] spi: spi-mem: add automatic poll status functions
    [v4,2/3] mtd: spinand: use the spi-mem poll status APIs
    [v4,3/3] spi: stm32-qspi: add automatic poll status feature


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

