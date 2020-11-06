Return-Path: <SRS0=zI59=EM=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055F0C2D0A3
	for <linux-spi@archiver.kernel.org>; Fri,  6 Nov 2020 11:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9823720728
	for <linux-spi@archiver.kernel.org>; Fri,  6 Nov 2020 11:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604663696;
	bh=+u2z0yudhfZycRMaRiRaDHANg7zMAeNdQNXSLXgEj+4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=OKti9pYQIgr156bFxj27XSaAjCv1RqA6DVMsTpZ213G95eq7osXw3viZNHW/Zq993
	 cDSqF1ArQa2p5ytH3KsCmxEQQGvz/0a9PgAsec3QLYjaUBALTM2189xsKNmrTHKakE
	 Fk563aWOEtGO581Bt/PI1pbmoKQ1HcoMnLDyBWWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgKFLy4 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 6 Nov 2020 06:54:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgKFLy4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 6 Nov 2020 06:54:56 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F66F20719;
        Fri,  6 Nov 2020 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604663695;
        bh=+u2z0yudhfZycRMaRiRaDHANg7zMAeNdQNXSLXgEj+4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JKDAsK79ChrdB7Vc8+00CuF7oVsfZWnL97SEkh58nhsnnsA/LdOgwy1d4svMqkYgk
         zGUUWWwyH52uMA6nIYp8DkRwnAxTqQsbIulVxbgF2vp2ONFQTAfzcFlBtGBXLXRF9y
         AAYknHncXhNT+BVIzgUr9NO1Zay8afma6PmDA4E8=
Date:   Fri, 06 Nov 2020 11:54:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Zhang Qilong <zhangqilong3@huawei.com>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <20201106015217.140476-1-zhangqilong3@huawei.com>
References: <20201106015217.140476-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH] spi: stm32: fix reference leak in stm32_spi_resume
Message-Id: <160466368373.23003.15732275055213604298.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 6 Nov 2020 09:52:17 +0800, Zhang Qilong wrote:
> pm_runtime_get_sync will increment pm usage counter even it
> failed. Forgetting to pm_runtime_put_noidle will result in
> reference leak in stm32_spi_resume, so we should fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix reference leak in stm32_spi_resume
      commit: 900ccdcb79bb61471df1566a70b2b39687a628d5

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
