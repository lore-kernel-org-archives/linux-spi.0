Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8747C7EE23
	for <linux-spi@archiver.kernel.org>; Fri, 24 Feb 2023 18:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjBXSae (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 24 Feb 2023 13:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBXSad (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Feb 2023 13:30:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DC96BF5C;
        Fri, 24 Feb 2023 10:30:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 685A0B81CAB;
        Fri, 24 Feb 2023 18:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30EFC433EF;
        Fri, 24 Feb 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677263426;
        bh=O4Mwg3w0JpRgJui6yoNsXmx/h3NhYcrFggVezAyqKTc=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Dd3v1cAycWoH9PcbX9WncZTrSPPZCUF6mqNHAigNs55MehLmbwMTFjiM8qxaX0liF
         SnwY5yPxSq2k9p7R0m/lH5lZa46NWGtacvEY89mmAPBRyTxTrz6+hhCNR+3ZiRIDhK
         VFMAKxR1rYqw7e4lrSbV9eQ4FjPWUAteYPYGhB0rVeciEY2AHjewYPr4irhvcNCQDQ
         g6r1j+Y+b8A65iWc1OH+/WhEBXPg/ah0am1fJafoi07ZNsxT2E9ZtKFo0ang3701BR
         vISUSpjyw0dlUbIGa72R6NRmGwkSedxM7k50dTNLBUBDOmCMEXn2pTaDUUQcy+vdcR
         SxIsQwb2fNoPA==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        skomatineni@nvidia.com, ldewangan@nvidia.com
In-Reply-To: <20230224164034.56933-1-kyarlagadda@nvidia.com>
References: <20230224164034.56933-1-kyarlagadda@nvidia.com>
Subject: Re: [PATCH] spi: tegra210-quad: Fix validate combined sequence
Message-Id: <167726342439.539434.8001216354479584360.b4-ty@kernel.org>
Date:   Fri, 24 Feb 2023 18:30:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 24 Feb 2023 22:10:34 +0530, Krishna Yarlagadda wrote:
> Check for non dma transfers that do not fit in FIFO has issue and skips
> combined sequence for Tegra234 & Tegra241 which does not have GPCDMA.
> 
> Fixes: 1b8342cc4a38 ("spi: tegra210-quad: combined sequence mode")
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: tegra210-quad: Fix validate combined sequence
      commit: 047ee71ae4f412d8819e39e4b08c588fa299cfc2

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

