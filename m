Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CA2C433ED
	for <linux-spi@archiver.kernel.org>; Thu, 22 Apr 2021 13:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 374FD613C8
	for <linux-spi@archiver.kernel.org>; Thu, 22 Apr 2021 13:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhDVN52 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 22 Apr 2021 09:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236721AbhDVN51 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 09:57:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 521F4613C8;
        Thu, 22 Apr 2021 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619099812;
        bh=o5kegHqxFCw6UyhyTlJLSSUDEK5wBbL43LeBSoNwMA4=;
        h=Subject:From:Date:To:From;
        b=BrvdSC5zrR+IRasNH5yyfs7+S9VZa5/p/xnpTBhXXdLEumJh/ypLhnBcZVdVNCRnb
         gTw+8ShjdAR+RoEDEzbXhJByiF/H02Fb2TH2VJue9xflAPKgFNiCczFbaXWnMLSN16
         SRW9cuibpgj87kj3JGsWEWvw6Iu2whuHBS3FiBlHeqCquwQRj9DTB8N4F8AWm1/5qN
         ACucvPN2wYJVq0ySfkEfPLEbhL3RSBhBVHH0/8eOr2GCFxUDTILCz2DOJhrKFGyOGQ
         bdNoahiNu+7SGj+ojMIRpdrYRf8E8tUkcXs+ShcEfq8zMgGjNgouv7NDs7gHuPt1Uj
         km7/PhLPgRNHg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161909981231.20184.11428209641855634334.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 22 Apr 2021 13:56:52 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: stm32-qspi: fix debug format string (2021-04-22T13:38:57)
  Superseding: [v1] spi: stm32-qspi: fix debug format string (2021-04-21T14:06:48):
    spi: stm32-qspi: fix debug format string


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

