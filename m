Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29BFC433ED
	for <linux-spi@archiver.kernel.org>; Wed, 21 Apr 2021 18:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 750D5601FD
	for <linux-spi@archiver.kernel.org>; Wed, 21 Apr 2021 18:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbhDUSko (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:40:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236033AbhDUSko (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 21 Apr 2021 14:40:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 873A661440;
        Wed, 21 Apr 2021 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619030410;
        bh=abGli1SVsng6MpmeidLcd+yxm05wCHwJLhFuV91krWc=;
        h=Subject:From:Date:To:From;
        b=BKwT2VRQmb3+z4J7df2cCLmetsnoe8ciIoxIgM2RutyVZydUWH7GWnCuNsTfuUpn1
         QcZgR/9AmQ8zJNvhiRhVwPD15TrrSEujAkRPZJfsbguj0/XGAnahr6Rh3GKDmbYovM
         T9vhByRT+bdEn696PXAeDJKRIcuvQ4YKcl1dDbq1qQv3WZvjaacPrZRs2BlGHSmJbE
         6F0HMY1XdTAngLuWV9tc2pMSqF4ytZkj/RK/GNdLtM+6/FhltgkKuN6Mi+6AS55Kj+
         HXJ9D56g8OwF4M61zSXpn2EuKg3OP0rK9S1CksCnDIKNHW8QFRnYtuuEyzdEKoRLwy
         wD1W45/LiMsgw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161903041042.9540.14318038003885316581.git-patchwork-summary@kernel.org>
Date:   Wed, 21 Apr 2021 18:40:10 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Patch: [v1,1/1] spi: Don't overwrite num_chipselect with error code
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=470279
  Lore link: https://lore.kernel.org/r/20210420131901.80233-1-andriy.shevchenko@linux.intel.com
Patch: [v2,1/1] spi: Make error handling of gpiod_count() call cleaner
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=470387
  Lore link: https://lore.kernel.org/r/20210420164040.40055-1-andriy.shevchenko@linux.intel.com
Series: [v2,1/2] spi: Allow to have all native CSs in use along with GPIOs
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=470391
  Lore link: https://lore.kernel.org/r/20210420164425.40287-1-andriy.shevchenko@linux.intel.com
    Patches: [v2,1/2] spi: Allow to have all native CSs in use along with GPIOs
             [v2,2/2] spi: Avoid undefined behaviour when counting unused native CSs
Patch: spi: Make of_register_spi_device also set the fwnode
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=470809
  Lore link: https://lore.kernel.org/r/20210421101402.8468-1-ckeepax@opensource.cirrus.com

Total patches: 5

--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


