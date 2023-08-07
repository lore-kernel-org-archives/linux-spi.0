Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21A3C04E69
	for <linux-spi@archiver.kernel.org>; Mon,  7 Aug 2023 21:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjHGV5e (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHGV5d (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Aug 2023 17:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AEABB
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 14:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8D786227C
        for <linux-spi@vger.kernel.org>; Mon,  7 Aug 2023 21:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DE6C433C8;
        Mon,  7 Aug 2023 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691445451;
        bh=1nJJknRDR+JbubjhZSOkDrFbGTIXQ9+qW2SygZD00jY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VBUVVRtJftEYCrHCsLFZEk+Isp8o1Hcd+Jii6oa1chU+FSYZrXufY0pcMatpx7K5b
         dEQH0wE/kuUvMl1I84J5lNqokN0Pv1OBXGwwS1Q8mhJGn7VAMLycm3X/HEMf3BXhsW
         ShWBh3aw80cSRHhWmAnSmpGWHuP0vwVm3STs2KnyRewPw4OciFK4RCHXzdMgT2ss4v
         4lbMRaTxrwsWSH2HnI4TD9afxyyrdc7hJUi8yYLlLxtX41pxIMwxe/qZSGyFCbluqN
         AxzdT/AMPK6GPa4Icbe/2iEIY2V7l2uux06lOsOq/IErdNF7s5fcO4vCKvL762V3bO
         PnXi4G33XbhTA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de
In-Reply-To: <20230807140717.3484180-1-yangyingliang@huawei.com>
References: <20230807140717.3484180-1-yangyingliang@huawei.com>
Subject: Re: (subset) [PATCH -next v2 00/21] spi: switch to use modern name
 (part1)
Message-Id: <169144545021.329334.17124295830749612007.b4-ty@kernel.org>
Date:   Mon, 07 Aug 2023 22:57:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 07 Aug 2023 22:06:56 +0800, Yang Yingliang wrote:
> I'm trying to rename the legacy name to modern name used in SPI drivers,
> this is part1 patchset.
> 
> After introducing devm_spi_alloc_host/spi_alloc_host(), the legacy
> named function devm_spi_alloc_master/spi_alloc_master() can be replaced.
> And also change other legacy name master/slave to modern name host/target
> or controller. Each patch compile test passed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[10/21] spi: cadence-quadspi: switch to use modern name
        commit: 1c75d749b5ebd2352cc72ed33d4fb522c624d974

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

