Return-Path: <SRS0=/X/+=DH=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EAFC4727E
	for <linux-spi@archiver.kernel.org>; Wed, 30 Sep 2020 15:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D084E2071E
	for <linux-spi@archiver.kernel.org>; Wed, 30 Sep 2020 15:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601478858;
	bh=20hVTAxNHIbbLo1KoLt7DBWKDyOMxLVh+tG3kh/LsKY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=xTh0EBkq5QjEZ9RqkWVGdmKfeSkqbt+IB5zKndTDSYvLSfSIauX+WN30QA0doJTmK
	 TEgnUL5pTZPKy86FUwjHIpw+rIBXhj904dung4kLWif2x2/POASCi07G5gOPPanmli
	 QU4seVW2NWVwOIEZuG9NnZ8Nt9v6t10/ziiHRgKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730626AbgI3POH (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 30 Sep 2020 11:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgI3PNw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 30 Sep 2020 11:13:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C45F20657;
        Wed, 30 Sep 2020 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601478831;
        bh=20hVTAxNHIbbLo1KoLt7DBWKDyOMxLVh+tG3kh/LsKY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=V0pS8kLOq2Vgb/KHuR46WzIccN2RuUSsQFHf5OYixz9Kf1KVGpoix/eX4W1fucobY
         WzqGwdS/9nZ+XurbUJ5WCIv+lcTfqAFbCiqI+7NO1LTtNwsXbiCnp5p8lFj85oIaT4
         caTvN7z9ZtFy+eEK3BUViNveLGX3vGvf6OQgIMKU=
Date:   Wed, 30 Sep 2020 16:12:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200930145353.3043699-1-alexandre.belloni@bootlin.com>
References: <20200930145353.3043699-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: remove unnecessary include
Message-Id: <160147877281.10117.17929784495637755359.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 30 Sep 2020 16:53:52 +0200, Alexandre Belloni wrote:
> Since commit d5fab59cab18 ("spi: atmel: trivial: remove unused fields in
> DMA structure"), the driver is not using any definitions from
> linux/platform_data/dma-atmel.h, stop including it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] spi: atmel: remove unnecessary include
      commit: af223edd07b619749f7abc3e1db1933ac56d2e3e

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
