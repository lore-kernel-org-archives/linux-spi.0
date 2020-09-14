Return-Path: <SRS0=909V=CX=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E202C433E2
	for <linux-spi@archiver.kernel.org>; Mon, 14 Sep 2020 14:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BEEF20732
	for <linux-spi@archiver.kernel.org>; Mon, 14 Sep 2020 14:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600095416;
	bh=iB4uoVqwoeOFsag4iQb11btoN3adksoNl245S5+nSp4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=NZBAUNFgnneTnmSY0rTF84LtHH7hLNUmzrBjvFPG61u2KN4QzHqWX5Yq/Yr14cVA6
	 vq303LNclO+tdOe+RpY42B8oYVgpilfmh1GgztYy7vREDl3Sam5JlugSQnRMgs4X6I
	 yijNymbvxAaXHbdeExWD5yF/9zsatvbwfL44pYdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgINOzj (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 14 Sep 2020 10:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgINOxV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 14 Sep 2020 10:53:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12143206BE;
        Mon, 14 Sep 2020 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095201;
        bh=iB4uoVqwoeOFsag4iQb11btoN3adksoNl245S5+nSp4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XRW+qN5QBxuMEaMNYLde6OBINJHVgJNCzzHrBQcAjaQn5CEh5E0D5jGkbVWRdpSid
         3RpW1Wl8SM96BO4SF0NqOgBpCWGtFpn/m35QVyS8YpoaIHqGpVWaKUv89ayAFOH+L8
         I/lDoFCAXpr2SAHojmhLPEjJW3jKxYtSwoYElcAo=
Date:   Mon, 14 Sep 2020 15:52:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-spi@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>
In-Reply-To: <20200910160706.5883-1-krzk@kernel.org>
References: <20200910160706.5883-1-krzk@kernel.org>
Subject: Re: [PATCH REBASE] spi: sprd: Simplify with dev_err_probe()
Message-Id: <160009511676.5702.17349845882121414868.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Sep 2020 18:07:06 +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sprd: Simplify with dev_err_probe()
      commit: 9d99e55833dddf76dd6470e7ce97201abb612c03

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
