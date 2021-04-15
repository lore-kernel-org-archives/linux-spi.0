Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9505CC433ED
	for <linux-spi@archiver.kernel.org>; Thu, 15 Apr 2021 07:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F029611F1
	for <linux-spi@archiver.kernel.org>; Thu, 15 Apr 2021 07:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhDOH47 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 15 Apr 2021 03:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhDOH47 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 03:56:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8DE136113B;
        Thu, 15 Apr 2021 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618473396;
        bh=5cBtGt+aM9kTtqzRtwlFMLJsQYCiZ6AwZaV+Ui6/7TA=;
        h=Subject:From:Date:To:From;
        b=sfzT3eE+0mnKu7wTrrSgv0l42RZ1tiXRau6y2IjBSaMC0tZHZtpwKk+WNJt1ca/uS
         x6Tip/hm+onlhvLZV6xuVgihbL6JVa7u7s8oJTedfYUhCUddRrJQ3v+rq9cSVhomrx
         aegqbBqMBwGr+e7Ty7IovJ4FCOvOG077A00pOEgJKQcBUXivfku0/srUAhYMO1p6Kd
         b0OhpYtRIwSvy0kcDxmPJe3nyshlQnyb6/t8niInFRwaZujKaoE7uwxFBN/z3J5HCD
         Zy8aP1W4Bmn0fDUJAkMECMJacn+6VFqpSZVbRD4heJIQ3UHPXw3ebBS6OS7fBlgXu7
         kBIFuFGOSU1MQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <161847339653.11579.12226899756871182628.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 15 Apr 2021 07:56:36 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v4] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe (2021-04-15T07:46:44)
  Superseding: [v2] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe (2021-04-12T07:31:54):
    [v2] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
  Superseding: [v3] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe (2021-04-15T07:17:14):
    [v3] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

