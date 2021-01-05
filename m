Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DBDC43331
	for <linux-spi@archiver.kernel.org>; Tue,  5 Jan 2021 16:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6191522CA0
	for <linux-spi@archiver.kernel.org>; Tue,  5 Jan 2021 16:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbhAEQJY (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbhAEQJX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 Jan 2021 11:09:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5532622CA0;
        Tue,  5 Jan 2021 16:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609862922;
        bh=olx3sStOYZ7JD7sihmFq5o08FyuUWbQWbvXHSdgR84g=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=RR8N4lzXoFQq7oh4HIMwPgL9dpd3wRzAKRL4b3zFEjeEtTEXKEc7YaGKjLcJV/b5/
         ZLj8W1HZLwn+/uN0JXz84mReRZpq5r581Z/+lul2bzUZzNykR8FgjIPM1dWhHYjFiu
         iafwk8wyu/ZdBolxvtgdjzX3kxhzRXwfJMMvCOmlG4t1iEm6Mt1VpuFwvYMcaUS9n/
         mMA0imAt3FeVet+aUeTKOob9YxnoqFtzBaTclHI924PXqaogBvE++zVxs7saWc0cRE
         o2gCht1BB4VU28t5qjrY3lRNX1FsKtFZ6c1VIfdWywt5B8GGubez/FAsMKrjymutcY
         IeXZgkqlYC4oQ==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     andy.shevchenko@gmail.com, sfr@canb.auug.org.au
In-Reply-To: <20210104085923.53705-1-alexandru.ardelean@analog.com>
References: <20210104085923.53705-1-alexandru.ardelean@analog.com>
Subject: Re: [PATCH] spi: stm32: update dev_dbg() print format for SPI params
Message-Id: <160986289006.50207.8088539580258005147.b4-ty@kernel.org>
Date:   Tue, 05 Jan 2021 16:08:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 4 Jan 2021 10:59:23 +0200, Alexandru Ardelean wrote:
> With the introduction of the 'include/uapi/linux/spi/spi.h' header, the
> type of the macros are enforced to 'unsigned long int' via the _BITUL()
> macro.
> 
> This causes some -Wformat warnings in the spi-stm32 driver.
> This patch changes the printf() specifiers from '%d' to '%lu' to
> accommodate for this change.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: update dev_dbg() print format for SPI params
      commit: 8b835da61774d4482864bc081dfb428104842ad3

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
