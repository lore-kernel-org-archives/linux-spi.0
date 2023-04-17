Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D17C77B72
	for <linux-spi@archiver.kernel.org>; Mon, 17 Apr 2023 19:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjDQT2h (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjDQT2c (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Apr 2023 15:28:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075249034;
        Mon, 17 Apr 2023 12:28:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D20162991;
        Mon, 17 Apr 2023 19:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42946C433A1;
        Mon, 17 Apr 2023 19:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681759706;
        bh=NaEpV7md2fFf2NAvFZ80rIV5tItCszPCwFIYfaLb+0k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lFbVFlzzR1yTP3V417gNR3mcCexU4rps12BIDS+560RQYy2d4ahim1e4JFHfgNihw
         lWHXQCw/6dHiUlEGf0CqGshnugUHy3pvXPYa6v14KYBkBnDc5KlLSamFsXdu5Mzkmf
         fuJk3rYJsX+UGlOCEL4fUkyYB6KR40UmYjVNQ/F0GCog1e6EAFuSQKfZzewsA7HSox
         f1qERbzW0ulX28f5utgNBuV6MT7LdmqjcijVzcuxKfeqcTbqBMgPlUotLgAXc5oJ+/
         vdUNEOx53gcoAYxoUUC2sKET/uvsq+P1TMsec1ZXShpcd8bQCfyDHfyACnlZGkJmRl
         dNFdqdAYyjxew==
From:   Mark Brown <broonie@kernel.org>
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com, saikrishna12468@gmail.com
In-Reply-To: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
References: <20230320095931.2651714-1-sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH 0/2] spi: cadence-quadspi: Fix random issues with
 Xilinx Versal DMA read
Message-Id: <168175970492.1284440.7735201840102180045.b4-ty@kernel.org>
Date:   Mon, 17 Apr 2023 20:28:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 20 Mar 2023 15:29:29 +0530, Sai Krishna Potthuri wrote:
> Update Xilinx Versal external DMA read logic to fix random issues
> - Instead of having the fixed timeout, update the read timeout based on
> the length of the transfer to avoid timeout for larger data size.
> - While switching between external DMA read and indirect read, disable the
> SPI before configuration and enable it after configuration as recommended
> by Octal-SPI Flash Controller specification.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: cadence-quadspi: Update the read timeout based on the length
      commit: 22c8ce0aa274cea2ff538ffdf723053ecf77d78b
[2/2] spi: cadence-quadspi: Disable the SPI before reconfiguring
      commit: c0b53f4e545e4c6106aab553eb351138d46211cc

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

