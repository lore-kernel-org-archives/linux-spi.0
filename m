Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E19C636D4
	for <linux-spi@archiver.kernel.org>; Mon, 13 Feb 2023 14:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBMOXa (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 13 Feb 2023 09:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBMOX2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Feb 2023 09:23:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FBD17CF6;
        Mon, 13 Feb 2023 06:23:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 656B960EB1;
        Mon, 13 Feb 2023 14:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2E8C433EF;
        Mon, 13 Feb 2023 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676298202;
        bh=CyoNoaGM8xImmx8WS0avknOJxiZYv7jXksqIurwGJ3Y=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CUsCOJZ6qTuYDPoK3j1icXiNdU4/xNlV1UBgKGxmDBmJkabQry+gQma+aizyCkcEZ
         15CObt8usQVP0PP7BICuznclxFWca2CJUkj4ELRJSHGfdSA1OpH/zTLtgsP/3q0rgm
         4AVyrRnisGdSTAnWONW6YFvv/ieb9os5gKDZ/nJIDjWc1CMu8BSI6KvVb/emn8U1ww
         UKHq08/jnKFBj9HuwcX4xAwpt6tl+yJUPeoGCbYZlZcP1qJK4kBxu8RL2cDKj0/6T6
         sYypJb6/AtaIS0QyZ4hwGOCpXUHaLfPqwhetQex0jFAlu9XMRu8mpciaNvvRtxhlWX
         cVh8fe1Oeuirg==
From:   Mark Brown <broonie@kernel.org>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>
Cc:     dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, anand.gore@broadcom.com, jonas.gorski@gmail.com,
        joel.peshkin@broadcom.com, kernel test robot <lkp@intel.com>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230211032759.72967-1-william.zhang@broadcom.com>
References: <20230211032759.72967-1-william.zhang@broadcom.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: bcmbca-hsspi: fix _be16 type usage
Message-Id: <167629819904.2707397.9836890482883162209.b4-ty@kernel.org>
Date:   Mon, 13 Feb 2023 14:23:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 10 Feb 2023 19:27:59 -0800, William Zhang wrote:
> sparse tool report warnings: drivers/spi/spi-bcm63xx-hsspi.c:197:31:
> sparse: sparse: cast from restricted __be16.
> 
> The controller requires big endian 16 bit data. Define an intermediate
> u16 value and use __be16 piointer dereferncing for the data to avoid
> directly casting to u16 and sparse warning.
> 
> [...]

Applied to

   broonie/spi.git for-next

Thanks!

[1/1] spi: bcm63xx-hsspi: bcmbca-hsspi: fix _be16 type usage
      commit: 2cca486cad4bf51da57cdad150697476a702ab69

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

