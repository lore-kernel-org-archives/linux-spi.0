Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81316C47087
	for <linux-spi@archiver.kernel.org>; Fri, 28 May 2021 06:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D60E6105A
	for <linux-spi@archiver.kernel.org>; Fri, 28 May 2021 06:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhE1G6Q (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 28 May 2021 02:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhE1G6Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 28 May 2021 02:58:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9B3926105A;
        Fri, 28 May 2021 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622185001;
        bh=0OgBskT9dg26zkMOwDoaBfI0FKFhTLNmoE+YWPB+eHA=;
        h=Subject:From:Date:To:From;
        b=hsQZSP576CIcqsK1Ft/t+aKvRjRx6PzJUS/QRxKcxEb4dQYeAXFp6dHXckIfNEpnE
         0tkvnmxHIsomrJHTQDJZigW/5aSLlrYjyrk3R1rK9rEpFA4GRfcUwHkPNfCEjIXCLB
         KGAEsOILFhne8H8OY+LmjWj7LM6Ehmd3AHdtePxLr74AlfwpmEKI7jGfS3gYqh0Odr
         QipdQ665DAd/WhanrCuFUCcooX0TCGyrQjhVgWNKMBG/9Nl5d5Ys+fzHtpWrKroY8U
         pEysB3UBZQwqTc73Suykw5uXrB7/RFLOO7PSfuedW9X0kNL7OUDUkwEJ1qRFdArpVD
         M+nJElH9mbhsw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <162218500149.22551.7624009427186157226.git-patchwork-housekeeping@kernel.org>
Date:   Fri, 28 May 2021 06:56:41 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: Fix use-after-free with devm_spi_alloc_* (2021-05-28T06:26:27)
  Superseding: [v1] spi: Fix use-after-free with devm_spi_alloc_* (2021-05-28T06:23:43):
    [v4.9-stable] spi: Fix use-after-free with devm_spi_alloc_*


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

