Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E61C43334
	for <linux-spi@archiver.kernel.org>; Thu, 30 Jun 2022 14:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiF3Od4 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237077AbiF3Odp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jun 2022 10:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271544756
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 07:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26A54621C6
        for <linux-spi@vger.kernel.org>; Thu, 30 Jun 2022 14:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F30C34115;
        Thu, 30 Jun 2022 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656598663;
        bh=DMARbHWICjlHAAjX7xlU9O+Gkn32rmMGhUsWAGmk9bg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PjrN5OBMcMapOlIMZb/kmVTUhoagATx/uk9wq9O8zYYWDKr6d3fLhkWmMXa16e0FR
         SwQvVX1tIb7TyJAFy0fhCay11MhwCC69EJo0xgINHyqDyScqoOZ0Cxjz+Hx5Oo/zZi
         Em1k2QAQBzKByH5A5OU9UAsoixkqL3GX4m8usH2j9C+nTq7pvpt8qIBlUf7BKNbBqu
         0eKUQbEvPEb9wAK5JWD/pJood4PELzM4WeEAh1iCqZ4Oyp0D8f0eMCpwyu+6imdgdt
         dpw0mzG8Qbdz+Z80eNJ4HXrMBaZBdFdlaabF7ZTiQkmFD4RHHBM7QhvKmpWuTz/kt4
         GE9BpieTuySjg==
From:   Mark Brown <broonie@kernel.org>
To:     david@protonic.nl
Cc:     andy.shevchenko@gmail.com, linux-spi@vger.kernel.org
In-Reply-To: <20220629142519.3985486-1-david@protonic.nl>
References: <20220629142519.3985486-1-david@protonic.nl>
Subject: Re: [PATCH 0/3] Fix some coding style issues
Message-Id: <165659866258.602102.6154448463517417589.b4-ty@kernel.org>
Date:   Thu, 30 Jun 2022 15:17:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 29 Jun 2022 16:25:16 +0200, David Jander wrote:
> This series fixes some coding style issues. No functional change.
> 
> David Jander (3):
>   spi: spi.c: White-space fix in __spi_pump_messages()
>   spi: spi.c: Fix comment style
>   spi: spi.c: Remove redundant else block
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi.c: White-space fix in __spi_pump_messages()
      commit: c191543e99fc03a36ccf7869392957a7182e0ada
[2/3] spi: spi.c: Fix comment style
      commit: 95c8222f0e52b09b7607616274e7cae84d519a9b
[3/3] spi: spi.c: Remove redundant else block
      commit: 31d4c1bdf157421b26d51f61a4da95dd20d171e2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
