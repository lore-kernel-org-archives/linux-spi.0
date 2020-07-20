Return-Path: <SRS0=D5D4=A7=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0172C433E0
	for <linux-spi@archiver.kernel.org>; Mon, 20 Jul 2020 11:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DC9B2073A
	for <linux-spi@archiver.kernel.org>; Mon, 20 Jul 2020 11:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595244010;
	bh=KkttNLB6GgZv+bqYkbg+MfQacJ8nhoC6bn1yiVv4cZo=;
	h=Subject:From:Date:To:List-ID:From;
	b=lD8y15ZDJgWuc2G+FoBiys+i/ZK/sa8AZNuNs332LpF4aMadBjUDI1SRMf69pjXMT
	 O8tKAKfiKRVgrvPodVjRHPfsSJJXPSKcFZpuREKlJJx/88EpaSJcweDg3mC2XfHJ0N
	 bmpA1Scm1zG+8/MyQFCBioc8Rv/ykWxqOlyHf1Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgGTLUK (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgGTLUK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 20 Jul 2020 07:20:10 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595244009;
        bh=KkttNLB6GgZv+bqYkbg+MfQacJ8nhoC6bn1yiVv4cZo=;
        h=Subject:From:Date:To:From;
        b=lMnnZOJpLMOXAT6inxceY2YIUHQJatrHOCmUIRDC45cYIs/j2NWYpH7pP6K6Mt2tU
         2NPrcWUrSRC+DPAT83iHenyQ1SAC4wiYBHhqacczOCozatl9dNRuLyndmbN6YnTdPV
         D5yIQVKpzOVaNZ8+TNeS1dI/+Nr5cT+DvCsHoreo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159524400974.32299.2168786724732041126.git-patchwork-summary@kernel.org>
Date:   Mon, 20 Jul 2020 11:20:09 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (refs/heads/for-next):

Series: Rid W=1 warnings in SPI
  Submitter: Lee Jones <lee.jones@linaro.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=320171
  Link: <20200717135424.2442271-1-lee.jones@linaro.org>
    Patches: [v2,01/14] spi: spi-loopback-test: Fix formatting issues in function header blocks
             [v2,02/14] spi: spi-bitbang: Demote obvious misuse of kerneldoc to standard comment blocks
             [v2,03/14] spi: spi-davinci: Fix a few kerneldoc misspellings and API slippages
             [v2,04/14] spi: spi-ep93xx: Fix API slippage
             [v2,05/14] spi: spi-meson-spifc: Fix misdocumenting of 'dev' in 'struct meson_spifc'
             [v2,06/14] spi: spi-meson-spicc: Remove set but never used variable 'data' from meson_spicc_reset_fifo()
             [v2,07/14] spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
             [v2,08/14] spi: spi-pl022: Provide missing struct attribute/function param docs
             [v2,09/14] spi: spi-zynq-qspi: Add description for 2 missing attributes/parameters
             [v2,10/14] spi: spi-zynqmp-gqspi: Correct a couple of misspellings in kerneldoc
             [v2,11/14] spi: spi-topcliff-pch: Add missing descriptions to 'struct pch_spi_data'
             [v2,12/14] spi: spi-at91-usart: Remove unused OF table 'struct of_device_id'
             [v2,13/14] spi: spi-pxa2xx: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
             [v2,14/14] spi: spi-amd: Do not define 'struct acpi_device_id' when !CONFIG_ACPI

Total patches: 14

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
