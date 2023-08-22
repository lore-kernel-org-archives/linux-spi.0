Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54094EE49A3
	for <linux-spi@archiver.kernel.org>; Tue, 22 Aug 2023 16:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbjHVQeG (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 22 Aug 2023 12:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbjHVQeF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 12:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3FACFF
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 09:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8304865CCC
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 16:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D862C433CA;
        Tue, 22 Aug 2023 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692722030;
        bh=2P162gUINpGqWj9ZHhYWRG52G1XI4AJ+ZF89lntXWYc=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=JaqM5Ye/A9teu+TvwAEAFH1F0qC9201NGnk0LhA33536oA75gAmDz2d+CHT15O//x
         lR9HRhggYn8YjWM3kTrFC2oI8LyOGNosL5Rr4U97Fav7B8hOSRAIjDgE3Uk3Cnfjy/
         z7B/lfeMrTMGkyoSfcSewQ3v7RzmXnDy395e7OPs/+ohW2t3JIWVkEiE2Am4xPGSRS
         tyCTtibYex94P/sK92HsAvSmvmdNGXnfFVXAzJKARIcoJGBDz00z/cdNlJCC4Yelpo
         9lS6R2zpNLCgsIJ2FjW4KTlJWLfDEFTA35wsnGErC8scKrq7HSDX5V0nfITYdzOGWQ
         ndhjTwbbX76Uw==
From:   Mark Brown <broonie@kernel.org>
To:     kamal.dasu@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zhang Zekun <zhangzekun11@huawei.com>
In-Reply-To: <20230810131650.71916-1-zhangzekun11@huawei.com>
References: <20230810131650.71916-1-zhangzekun11@huawei.com>
Subject: Re: [PATCH] spi: bcm-qspi: Simplify logic by using
 devm_platform_ioremap_resource_byname()
Message-Id: <169272202923.71899.7963649162845586115.b4-ty@kernel.org>
Date:   Tue, 22 Aug 2023 17:33:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Aug 2023 21:16:50 +0800, Zhang Zekun wrote:
> platform_get_resource_byname() and devm_ioremap_resource() can be
> replaced by devm_platform_ioremap_resource_byname(), which can
> simplify the code logic a bit, No functional change here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm-qspi: Simplify logic by using devm_platform_ioremap_resource_byname()
      commit: 246f74bb11e7df33946443a21c03463937867a09

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

