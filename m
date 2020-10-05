Return-Path: <SRS0=HfFK=DM=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B609C46466
	for <linux-spi@archiver.kernel.org>; Mon,  5 Oct 2020 17:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A5620853
	for <linux-spi@archiver.kernel.org>; Mon,  5 Oct 2020 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601920558;
	bh=FD1Z2L6GBgUx39XjAEGMkg821R7+nSUHP9MIuFaZ6ns=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=XE1u8jXg/Jjw2fklt3GICkgSGbTCK+YUcMp/tkh5FA78lHXbKJ4doA+Tz2qNw16oI
	 IcAEn70VjcMTiR3FVFY/MfJGJfalGQQ5jd6bdNd//3xOV3jR3d8VfBSTOLm9Ql1J6r
	 ULrgOI0vsblzV0kgfRuFEdXHmOb3MAbR8aFMAZWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgJERz6 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 5 Oct 2020 13:55:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgJERz6 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 5 Oct 2020 13:55:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8433E20B80;
        Mon,  5 Oct 2020 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601920558;
        bh=FD1Z2L6GBgUx39XjAEGMkg821R7+nSUHP9MIuFaZ6ns=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=um48qCyaocW25/ixTszKwJvLesJ8VILKkn86htQKXhtV0pGAvt/MyyZ99rZSc9m6h
         EuhFC60OozkxBHI9p+j0jx4Vvkox4+PgYtg2XZJ4VLP408Q4VARBpcUYz5xh9K8zFl
         wEztX4MTU4Ax39FeKD1sZJc/31rxjj/3jGG7bGbc=
Date:   Mon, 05 Oct 2020 18:54:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Jean-Hugues Deschenes <jean-hugues.deschenes@octasic.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
In-Reply-To: <20201002211648.24320-1-Sergey.Semin@baikalelectronics.ru>
References: <20201002211648.24320-1-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] MAINTAINERS: Add maintainer of DW APB SSI driver
Message-Id: <160192047989.23319.2518589634425010273.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, 3 Oct 2020 00:16:47 +0300, Serge Semin wrote:
> Add myself as a maintainer of the Synopsis DesignWare APB SSI driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: Add maintainer of DW APB SSI driver
      commit: 1c33524f79853f41e80390b1a223254aadd30bd4

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
