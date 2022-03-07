Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B4C4332F
	for <linux-spi@archiver.kernel.org>; Mon,  7 Mar 2022 20:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245373AbiCGUkp (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbiCGUkk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Mar 2022 15:40:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620957A992;
        Mon,  7 Mar 2022 12:39:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DB19B8170D;
        Mon,  7 Mar 2022 20:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D084C340E9;
        Mon,  7 Mar 2022 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646685582;
        bh=MFEDq2n1I3WmHMz8Kow++qRNInnWnoXDBUgAcH7XvzE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=b4tO1DNqOx/0jhQZuhWK5AlDL887sre7rBG6ciHsdXbBiGvNZtYOflpJX6RnSu1lm
         vCdHcm3TeOYF6pdSYo+ob1FPbahCG9anHTxgsP70KPidlmVNcNZrADA66oeqYux1iN
         denyUai9gHEbP0euUe90hxwYKGDc3mv3fFTpFgTxQNfbNokAQYh9/Lib2S3XLQnLzQ
         Rg7+Y+vlfgFEyN/Nz5v23maT/f+U2dQfexhpKaFRBj2GYDfgI1L2fSt1/pcBm1l4O4
         VEsmsLdGy2C8xTjCih/bIXaXV8gXnMJxh5/CIIzRKDhPtvz13UYC/u1+Hg1PIgTdF/
         pxlbspMhMa2tA==
From:   Mark Brown <broonie@kernel.org>
To:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Han Xu <han.xu@nxp.com>, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20220302192915.6193-1-singh.kuldeep87k@gmail.com>
References: <20220302192915.6193-1-singh.kuldeep87k@gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: Update NXP Flexspi maintainer details
Message-Id: <164668558136.3137564.9240243225598212483.b4-ty@kernel.org>
Date:   Mon, 07 Mar 2022 20:39:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 3 Mar 2022 00:59:15 +0530, Kuldeep Singh wrote:
> Add Han Xu as flexspi maintainer.
> Also, update my email address as previous one is not working anymore.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: Update NXP Flexspi maintainer details
      commit: af524ae5ad13a9c28acf0b2ec4489d5903c4fbed

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
