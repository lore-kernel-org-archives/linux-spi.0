Return-Path: <SRS0=cekb=EB=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96EAC2D0A3
	for <linux-spi@archiver.kernel.org>; Mon, 26 Oct 2020 23:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FD420714
	for <linux-spi@archiver.kernel.org>; Mon, 26 Oct 2020 23:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603756072;
	bh=FHIZ3Vt1pWYjq2h3YM8JdfcWOG/qzEVQVwcGJCzBaN8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=zhIccOcpVHd52GZ8hAu7qVCcJpSxSo7WrnUjWDoMby04HMlkfTk2OPzOc3ta+J+P1
	 OTRhZXtgO3cmNXCkO+P3fpmKCC0PO8n4Ged0vCmkRPh+A+ZZqLkK3zNUJcFLxw/Mxy
	 IcD4m6vyvhFnOwDUkEGSyZn+UMPKAQvSfgIw3EAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408527AbgJZXrw (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408518AbgJZXrv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Oct 2020 19:47:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 016EE20773;
        Mon, 26 Oct 2020 23:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603756071;
        bh=FHIZ3Vt1pWYjq2h3YM8JdfcWOG/qzEVQVwcGJCzBaN8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LDIg9D+0URGQ42rjldhyXjNZfYJu3kQ/7G5ltIQeEA0hcXHmzCn/FUxXXQ8Xdz1Gz
         t+o6l0XfmDrVDgxeNbqZaRSviMLqGHM2GEwYR2I660l3wj2Lji1EQDNYra8vtuh8r2
         Eqn7PHPxXEDccBiBQ84yiAveXeyD39SmGJEn3Xyw=
Date:   Mon, 26 Oct 2020 23:47:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Alexander Kochetkov <al.kochet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20201016083826.31427-1-al.kochet@gmail.com>
References: <20201016083826.31427-1-al.kochet@gmail.com>
Subject: Re: [PATCH] spi: spi-sun6i: enable autosuspend feature
Message-Id: <160375605708.32342.2884764124923263492.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 16 Oct 2020 11:38:26 +0300, Alexander Kochetkov wrote:
> If SPI is used for periodic polling any sensor, significant delays
> sometimes appear. Switching on module clocks during resume lead to delays.
> Enabling autosuspend mode causes the controller to not suspend between
> SPI transfers and the delays disappear.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-sun6i: enable autosuspend feature
      commit: ae0f18bef30d0e76dd62be46c59b24c75f175092

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
