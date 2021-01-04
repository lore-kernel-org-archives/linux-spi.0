Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0897C433DB
	for <linux-spi@archiver.kernel.org>; Mon,  4 Jan 2021 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1802206B2
	for <linux-spi@archiver.kernel.org>; Mon,  4 Jan 2021 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhADRuu (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 4 Jan 2021 12:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:38614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhADRuu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 Jan 2021 12:50:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B3129206B2;
        Mon,  4 Jan 2021 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609782609;
        bh=gEllBuRkYIWXy7HBWZn05PFFDTbyEb/K5HHS2G5oxkg=;
        h=Subject:From:Date:To:From;
        b=MLEiWnpf41wL5ICa7ZgT15MP1KQxERjuk8SVIJINOVsjqmHDz5jdXyMWgcoR8amZh
         4vpbkO2NKd3zdhxwcgjkvKPRZMtnB9YVJspnPpntH0CO/0x/aIFjObP+pZLh00mXax
         KincY/nF1kmcPGwIJz4LAvcS3yuQiapW4W1xFQ5l8Z6yodz6JNnQMNw5vDPbbIWV8n
         KYC7BoEO3+EgohT06b4t81z9QaZDdG4xbklR0EXv2lGGEDh2Un1DrDfJJ2hq4o1GKR
         lcKTlon2bP+LVaUB84wdrbw1oKJV4WZdjuobOCh86w555zx1A4UWVRqP5u0nMsiU+t
         VoRMhIdA+HeZw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160978260960.6020.7966844421204881811.git-patchwork-summary@kernel.org>
Date:   Mon, 04 Jan 2021 17:50:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v3] spi: fix the divide by 0 error when calculating xfer waiting time
  Submitter: Xu Yilun <yilun.xu@intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=408401
  Lore link: https://lore.kernel.org/r/1609723749-3557-1-git-send-email-yilun.xu@intel.com

Total patches: 1

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


