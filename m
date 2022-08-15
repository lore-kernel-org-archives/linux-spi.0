Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE3C25B0D
	for <linux-spi@archiver.kernel.org>; Mon, 15 Aug 2022 15:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiHOPp7 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 15 Aug 2022 11:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiHOPpS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Aug 2022 11:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C0C16;
        Mon, 15 Aug 2022 08:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B70B610FB;
        Mon, 15 Aug 2022 15:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC428C43141;
        Mon, 15 Aug 2022 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660578314;
        bh=0Q6eADI3Tco1PDxr5yvf++mMgHZkrwSUpLo7KbmRoAk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=uEU5JWu8stgqm5pe2bGYE0zdMHlrmz3BbgTES4nmXzlN5YrCX8tj7Lr5jqxvyV+6X
         Kz7xZRVKiKMOF08AAre2L7Q9ozAV8elPeXoM9tErWQpfxJn01P4GEbrqIW2m6ZDpAH
         BhazzIxFUKfCC1YK6e7cRIVLVK1BGBNfmp7zJ/dUdZAda4ExS01sWCL9SvRfZN3D0R
         wS4TnQIpQymmUJ9EA9oQojz73UDJpGfBvuDHY6Jl/FKjWQlf9kHi81MZUge7kolGtf
         iSVdINnViO85yYjVjeh6WEn6AelC08/Muou3TrriqS1hM7ZODabeWDhm553492eYFu
         4C8fze+HUCI9w==
From:   Mark Brown <broonie@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <253543c462b765eca40ba54c66f4e3fdf4acdeb7.1659735546.git.christophe.jaillet@wanadoo.fr>
References: <253543c462b765eca40ba54c66f4e3fdf4acdeb7.1659735546.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: lpspi: Simplify some error message
Message-Id: <166057831362.697678.10418733101562971754.b4-ty@kernel.org>
Date:   Mon, 15 Aug 2022 16:45:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 5 Aug 2022 23:39:19 +0200, Christophe JAILLET wrote:
> dev_err_probe() already prints the error code in a human readable way, so
> there is no need to duplicate it as a numerical value at the end of the
> message.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: lpspi: Simplify some error message
      commit: 0df874c6712d9aa8f43c50ec887a21f7b86fc917

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
