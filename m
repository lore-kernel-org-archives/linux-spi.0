Return-Path: <SRS0=TAp4=7I=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16752C433DF
	for <linux-spi@archiver.kernel.org>; Tue, 26 May 2020 16:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67BE20873
	for <linux-spi@archiver.kernel.org>; Tue, 26 May 2020 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590511569;
	bh=T9Ezc7a1r4TivHOwjldsbyoxjBD6NDs54wx5Hd/nAUw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=yaJKrJassP/ulQIPaWiVvtvWLiwwi64I55Ywm14cMXV0O7JyRC4mE0dO6XHqe1Iu7
	 LBc9AW3/mvWYDIdt1bef1sgal7lOEU+Bq/ht26IW5LPNkpKcseWd20TWlBHpLfBmMn
	 vz9qnBjXYwwRpbfgUeWjdmPCY9HXF8SWZj7cyavA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbgEZQqJ (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 26 May 2020 12:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388339AbgEZQqJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 12:46:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C409207D8;
        Tue, 26 May 2020 16:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590511569;
        bh=T9Ezc7a1r4TivHOwjldsbyoxjBD6NDs54wx5Hd/nAUw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=icoQ2hIogxa6UBGwFV5F6Lcz4MR1dDM/ZWl1u4SPtQsRaFSXt5aMAKLJqLc67uLYc
         utHegEFlgjwO7vGIMkGBpBDlU4mj1A+mrfSSFObTmrMphWbdqAjCvtfD3SNZpuykRk
         mREjprM+g/wX37zzFT5QafmEVZY9HO62nMp+7xSA=
Date:   Tue, 26 May 2020 17:46:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200523133859.5625-1-dinghao.liu@zju.edu.cn>
References: <20200523133859.5625-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: Fix runtime PM imbalance on error
Message-Id: <159051156064.36444.17809778699218535545.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 23 May 2020 21:38:59 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-fsl-lpspi: Fix runtime PM imbalance on error
      commit: 8d728808194a12186ce5af0b72c8a47b42476bc3

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
