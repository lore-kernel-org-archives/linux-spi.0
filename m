Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B50C12002
	for <linux-spi@archiver.kernel.org>; Fri, 16 Jul 2021 23:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E05A2611BE
	for <linux-spi@archiver.kernel.org>; Fri, 16 Jul 2021 23:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhGPX7b (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 16 Jul 2021 19:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhGPX7b (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Jul 2021 19:59:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 06D846128A;
        Fri, 16 Jul 2021 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626479796;
        bh=wSKjWaU73JwJPyvCDiiJbFvdKLiF9p7W7LQtc9QV9tA=;
        h=Subject:From:Date:To:From;
        b=MRNRBdIk7HpU9qmgiL0Q3PrMQGDuFIQEHlmknPgsCrT5jZcLVG2JYkYioi0CXrgYr
         2lUSDYyIjND5KXwsFC451FzW3nyYzGI2zJ/bvaF1eIKEx/8ieSVj+zo9EcLmu0Fauo
         +o0RmftioSMfC267kzAtmfiomk1Ti4vT3s6TQWEIxvgp92tddX8uPaF4+oukllSacW
         mPsZd5pxhl2oWG9HTUUBCgTCGtMHWCa/AtXGe5NJ+/NsxZMPIDBFlR2cf2YrvWAUTG
         FdBmnEESf8aRoWVavjejol8G0ntbCMtrLZAKugmHLNX8JXQqsZ9EOha31j3dwIwKRG
         hDad/L6Bwfvlg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162647979588.2110.3316478581019218440.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 16 Jul 2021 23:56:35 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: cadence-quadspi: Fix DTR op checks and timeout in SPI NAND write operations (2021-07-16T23:25:01)
  Superseding: [v1] spi: cadence-quadspi: Fix DTR op checks and timeout in SPI NAND write operations (2021-07-13T12:57:40):
    [1/2] spi: cadence-quadspi: Disable Auto-HW polling
    [2/2] spi: cadence-quadspi: Fix check condition for DTR ops


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

