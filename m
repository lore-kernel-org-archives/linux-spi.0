Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF9AC32772
	for <linux-spi@archiver.kernel.org>; Tue, 23 Aug 2022 18:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbiHWShy (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiHWShc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Aug 2022 14:37:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1820B90193;
        Tue, 23 Aug 2022 10:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41C97B81D65;
        Tue, 23 Aug 2022 17:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DCCC433D7;
        Tue, 23 Aug 2022 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661274022;
        bh=uPmXrDY9eZ1gDQcnTT7Qg/K0fgjJnRiXqZdiPuQwP0A=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=O1gslRCjWYYZlOwYBW8ZuoMYVWGFJaHfj0dFZh8USFtOMnb1PDYWjb2xAfmaHMV7S
         7qfEqZ29edLBRpp+qE/yA4p8THw2LzDF8EAt70Stxi/DdQaDbISU8fhbu6xRy2oPJa
         5/zpbumyvOfQQ/T4e87G5CTu6Hiplq3fREdirbWGjTEpYkh0715Guq/WiUfacwxaeh
         RKSzKbm8MPEK1fgTFHSjKNITj25HjYdnzXLWqfN+1Bg5p3ZAykiXaqyhDczk8Q3sNA
         JKvFA2Iu8iAayBbhUNzkB+qhTbSoJWyPVnbgPGbT1swqwlh9HTzi646nOFSxqd7jAe
         GEK4zykpptF/g==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20220823100937.386880-1-krzysztof.kozlowski@linaro.org>
References: <20220823100937.386880-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] spi: dt-bindings: snps,dw-apb-ssi: drop ref from reg-io-width
Message-Id: <166127401918.469144.499806525796246360.b4-ty@kernel.org>
Date:   Tue, 23 Aug 2022 18:00:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 23 Aug 2022 13:09:37 +0300, Krzysztof Kozlowski wrote:
> reg-io-width is a standard property, so no need for defining its type
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: snps,dw-apb-ssi: drop ref from reg-io-width
      commit: 52069b2a869ebdcaedf829730730c5998d56b910

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
