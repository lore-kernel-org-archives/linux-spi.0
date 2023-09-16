Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FD3CD37B1
	for <linux-spi@archiver.kernel.org>; Sat, 16 Sep 2023 01:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjIPBMh (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 15 Sep 2023 21:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjIPBMF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Sep 2023 21:12:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE7E3;
        Fri, 15 Sep 2023 18:12:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C602EC433C9;
        Sat, 16 Sep 2023 01:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694826720;
        bh=bYO59QCoX4XqFb5BucbBKtrS3lsg1tXwdOkE59vdUkI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Fnn/2QslaMEHclg29ykrYpVMCfJgIF+O169JKMrM4svS1H4ZM1q014Kjjl3BOHmRU
         iQ68uDmaKGMFZic98LyRgEF6ckEexLAPQ3bvuS8Ertutb6uhqkCBWlsB1b8rf7qNuj
         zvpKTm4OJosbkfBLPH8ftyvmnCSYUEPPXGudmN44GCSvJveY46IJGQk/zqxtZ+PDbx
         6hVZx7Kf0Up1KCl3o6Vfx8L5/GVIzgTHScVaDzdJJVjtsSOGnBEuHsYpNLieHMc7gQ
         Zlnby+VMzBAPdKELC8bJ4t7fQwZiBBblVG4wnaSKE/l5TFNVdVQTZ0e/LhMeR203O4
         1mi/8+LMi0PpQ==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230914190033.1852600-1-robh@kernel.org>
References: <20230914190033.1852600-1-robh@kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: arm,pl022: Move child node
 properties to separate schema
Message-Id: <169482671852.606665.18307676908315471963.b4-ty@kernel.org>
Date:   Sat, 16 Sep 2023 02:11:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 14 Sep 2023 14:00:17 -0500, Rob Herring wrote:
> In order to validate SPI peripherals, SPI controller-specific child node
> properties need to be in a separate schema, spi-peripheral-props.yaml,
> which SPI peripheral schemas reference. Move the arm,pl022 child
> properties to their own schema file and add a $ref in
> spi-peripheral-props.yaml.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: arm,pl022: Move child node properties to separate schema
      commit: b0ef97ac89a794ae786eb1ff1cd2b07e9d9ab3c4

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

