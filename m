Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C52C001E0
	for <linux-spi@archiver.kernel.org>; Wed,  9 Aug 2023 16:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjHIQ3m (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjHIQ3l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Aug 2023 12:29:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1371B2135;
        Wed,  9 Aug 2023 09:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C32664058;
        Wed,  9 Aug 2023 16:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE360C433C8;
        Wed,  9 Aug 2023 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691598575;
        bh=NzgcHUUZOX+VYfBoHP7NLY8e72NmRPh4DdS2d1SjmTk=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=A2XFBAmbYrxo9zNanDn3hG9CGcjL29E1QXD3xGGN2vopARSS7PrkzZfTkkwM/RRyr
         t09Htk41r35uOEw1QrlKMivToPMjVekL6hH9SBTSNMfjtBtBr2vO3hjllVQWFnq/hF
         95x2xBqd/BGXW0TZ3DEplHDrI/a79cOO9NPSBtRM6nd5RykuXSSv2M14JzO7R4M9wb
         ArSqXa59L/vWymke4tebmqyFI9YzJwkrIJ1Awun9/KobZZPJp+BWpGkVcUB33pEbAx
         UgY65a+pw7CiGSP6OmolyoFcpRgb8p35sgcX1pYD/79QIW3TPGdNZYnmvrql9t/TV6
         N0SdU5zKTNHsg==
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>
In-Reply-To: <18a65dca9134f6fc35932408066d4a8284cbfa65.1691571190.git.christophe.leroy@csgroup.eu>
References: <18a65dca9134f6fc35932408066d4a8284cbfa65.1691571190.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] spi: fsl-cpm: Properly define and use IO pointers
Message-Id: <169159857463.143658.5802489571235545071.b4-ty@kernel.org>
Date:   Wed, 09 Aug 2023 17:29:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 09 Aug 2023 10:54:27 +0200, Christophe Leroy wrote:
> Sparse reports several issues with IO pointers.
> 
> Fix it by adding missing __iomem flags and using iowriteXXbe()
> generic helpers instead of the powerpc specific out_beXX() ones.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-cpm: Properly define and use IO pointers
      commit: ddaec4e44d4e2a556b51159d48788a85ff67179d

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

