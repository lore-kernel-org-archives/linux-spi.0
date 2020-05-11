Return-Path: <SRS0=csd4=6Z=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCBEC54E8D
	for <linux-spi@archiver.kernel.org>; Mon, 11 May 2020 11:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC6D208DB
	for <linux-spi@archiver.kernel.org>; Mon, 11 May 2020 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589196311;
	bh=axzFcp862ivBEqBZfANOieja1Y9dpnhcBwtdnREXY+0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=QHj1XEqdYPyUGQ/wYWLZY6yS7DEcv0KqDCsn7q3jF+fPZOLD3Sh8bWo9kyl3J934i
	 vVNVBKAiRjLLhIwxNdVBweLd28UkWa9hiJMiGan7xXwcXycjJLZOvmUOz5k2+dT5W3
	 p9EN8In5qiGG+2wJAuBUSSPIFWQEFT3pnrSpt/Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgEKLZJ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 11 May 2020 07:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgEKLZJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 11 May 2020 07:25:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF6820736;
        Mon, 11 May 2020 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589196308;
        bh=axzFcp862ivBEqBZfANOieja1Y9dpnhcBwtdnREXY+0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mZVF+81kOc1WTLOhTagcWWBaji4NYGD2Of6t46KZM0fWLf5O4Dd1UYaMKal/aPcGY
         tcgvnDn2vgtAxh26ax1oVFtZ9zBjL6AZnM1utDHVY6onLbkEVM/arln/PVEuAl3ROz
         u0wfhf/s02X+20GVT0EsDR36IM85jg9ylwQVeniU=
Date:   Mon, 11 May 2020 12:25:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jay Fang <f.fangjian@huawei.com>, linux-spi@vger.kernel.org
Cc:     huangdaode@hisilicon.com, linuxarm@huawei.com
In-Reply-To: <1588991392-24219-1-git-send-email-f.fangjian@huawei.com>
References: <1588991392-24219-1-git-send-email-f.fangjian@huawei.com>
Subject: Re: [PATCH] spi: dw-mmio: Do not add acpi modalias when CONFIG_ACPI is not enabled
Message-Id: <158919630591.8372.13162390322267160286.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 9 May 2020 10:29:51 +0800, Jay Fang wrote:
> Reduce unnecessary static memory allocation when CONFIG_ACPI is not enabled.

Applied to

   local tree asoc/for-5.7

Thanks!

[1/1] spi: dw-mmio: Do not add acpi modalias when CONFIG_ACPI is not enabled
      (no commit info)

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
