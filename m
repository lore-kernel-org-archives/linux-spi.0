Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FF1C2D0A3
	for <linux-spi@archiver.kernel.org>; Mon,  9 Nov 2020 19:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F78E2074F
	for <linux-spi@archiver.kernel.org>; Mon,  9 Nov 2020 19:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcYgJ+Pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgKITsh (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 9 Nov 2020 14:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729899AbgKITsh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Nov 2020 14:48:37 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 157B2206E3;
        Mon,  9 Nov 2020 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604951316;
        bh=e6AtaRbKq0BHW2zVKVpEgVu0o9ZE80SKGtkiHFRIGnE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CcYgJ+PbQ69GE/1BA++mzs/k0wfI424RSpMFYpowVkrp62Lp+ddSPWJx2KLhu+c1H
         6qXRaRTHbhkpa03tWJ2++JxBV4Z5+EDuK7YvPL2742GNyl6oYBHrUmnBAazemfOZjs
         dSbaeQks/F2JuvO5qMUVK8XEP7eSZ+HgXWwLBk60=
Date:   Mon, 09 Nov 2020 19:48:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>
Cc:     linux-spi@vger.kernel.org
In-Reply-To: <20201103140947.3815-1-zhangqilong3@huawei.com>
References: <20201103140947.3815-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: spi-ti-qspi: fix reference leak in ti_qspi_setup
Message-Id: <160495129749.49337.6906868883042164608.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 22:09:47 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in ti_qspi_setup, so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-ti-qspi: fix reference leak in ti_qspi_setup
      commit: 45c0cba753641e5d7c3207f04241bd0e7a021698

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
