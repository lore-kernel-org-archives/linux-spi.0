Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00052C433FE
	for <linux-spi@archiver.kernel.org>; Wed, 13 Apr 2022 17:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbiDMRit (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbiDMRis (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 13 Apr 2022 13:38:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99AD6C94C;
        Wed, 13 Apr 2022 10:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6621FB826A5;
        Wed, 13 Apr 2022 17:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F2CC385B7;
        Wed, 13 Apr 2022 17:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649871384;
        bh=MBcWRxUolzcfSKREW6xxBe0TvpgZQFRlBbpGjn/l6g4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=inArnGd+35bl0jDczQH1KgxPnhcODMLyjr6CMcX3ydH7kvTFHWFzzICO7d21Q5e+h
         7iVRKktJcPz3q9lx7DGW2ZbSmXkWKTaliZT4aYBNENjdGi/R3e0g7qY/d9+bFmYgrZ
         L2MtwELMlFdBh7hCyo5JhDprI4ONer63SUsxzWcBAn/OP+01sIT8Z2H2SBZpnqdGGl
         cPepCPJMjtgbQWtJQGdROw257sq/HGagoHOQ8mYmlXnaEegFoRpJVYOEpNQ2KWUEVI
         ZVPkfMdyVoeHP3YlbKlUOUio4h359sXVDiJSIEKKJSiTAftZ0Kk1h+x8kmAGKmPxIQ
         KXapUjuZCBrPA==
From:   Mark Brown <broonie@kernel.org>
To:     tudor.ambarus@microchip.com
Cc:     linux-kernel@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com,
        stable@vger.kernel.org, claudiu.beznea@microchip.com,
        linux-spi@vger.kernel.org
In-Reply-To: <20220406133604.455356-1-tudor.ambarus@microchip.com>
References: <20220406133604.455356-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH v2 1/2] spi: atmel-quadspi: Fix the buswidth adjustment between spi-mem and controller
Message-Id: <164987138232.70105.12556585565339891509.b4-ty@kernel.org>
Date:   Wed, 13 Apr 2022 18:36:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 6 Apr 2022 16:36:03 +0300, Tudor Ambarus wrote:
> Use the spi_mem_default_supports_op() core helper in order to take into
> account the buswidth specified by the user in device tree.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: atmel-quadspi: Fix the buswidth adjustment between spi-mem and controller
      commit: 8c235cc25087495c4288d94f547e9d3061004991
[2/2] spi: atmel-quadspi: Remove duplicated DTR checks
      commit: f4cf11df69c048948b73ff0bebaf9fc5fa5caddd

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
