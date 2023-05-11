Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBAFC7EE24
	for <linux-spi@archiver.kernel.org>; Thu, 11 May 2023 05:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjEKFkL (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 11 May 2023 01:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKFkL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 11 May 2023 01:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCEAD;
        Wed, 10 May 2023 22:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC86564AB0;
        Thu, 11 May 2023 05:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43465C433D2;
        Thu, 11 May 2023 05:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683783609;
        bh=cnwaPvJcu6guyEf9NqX8F6+9/TD4en/lP/amfTvDi7Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=NsG5+VEq1Ng8NWZ3+pL7QO6FiKYwu+Lm/FUeXe58wNkj+kw9jkru3dh+hbcauYoeq
         jdkkei/F7Agv5OJNPSmGHKdQP2/Woffbs7/7Hou2XIQUa/vnEsZL9nLAo9Qt5HHkL0
         6fJ4SRtUVkI1lmDytETSO7SR/uk39KIsJMdOpjLoDYsQewrnG3YSzItp3zPu4wz7Fd
         6nybldN50tGpFJdpIIqOfNfp0rfUsZgpzcSKmBtuMldihY8o/hK0n4YRrnGIeLEMwH
         XejDdKMiHrT7jUESc2R/rI7gPp/WNk05MW/e0gieJwi6cvtQbzFcbQwQDXyINLc615
         ZYZ7P7QH+2kjQ==
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20230510113942.89994-1-jaewon02.kim@samsung.com>
References: <CGME20230510120245epcas2p2cea91a04ef2fd46f0fa9f22f73c5b2eb@epcas2p2.samsung.com>
 <20230510113942.89994-1-jaewon02.kim@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: Disable IRQ mode when using DMA
Message-Id: <168378360579.326766.7361923325048622391.b4-ty@kernel.org>
Date:   Thu, 11 May 2023 14:40:05 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 10 May 2023 20:39:42 +0900, Jaewon Kim wrote:
> Fixing the problem of enabling DMA mode and IRQ mode at the same time.
> In this case, a value of more than 6bits is written to RDY_LVL, it can
> cause an invasion of other registers, potentially leading to SPI
> transfer failure.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: s3c64xx: Disable IRQ mode when using DMA
      commit: 26cd10a0b9761bffd4669a429f8a33cbccef5bbd

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

