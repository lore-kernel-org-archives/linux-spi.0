Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07529CCA479
	for <linux-spi@archiver.kernel.org>; Tue, 28 Jun 2022 10:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344896AbiF1Kbe (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbiF1Kbd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jun 2022 06:31:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751F331DF2
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 03:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2404DB81DD1
        for <linux-spi@vger.kernel.org>; Tue, 28 Jun 2022 10:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59CFC3411D;
        Tue, 28 Jun 2022 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412289;
        bh=UwMfvTzxCbRskfDzXTHBNCOc93HIFJ0LrHKhe1ivZos=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kHFH5iWt4lFyR//vf5el+n+0ayyvEJOnwkGNxmObaGK4Cc0e+0Ir68Th4VtNB2CMj
         aGtZlaE/UV7mGSjhMywmK34X9re1h87+7fCv45IQK+VZAmM4qE6U9q2hyBs7bwjcAw
         /SIawBNlqWJns76VydPqDGFUUlrF1PNQ7jny8mYt1ffk5o2yf/X7IbNy34S6Y80jL+
         x7BRwmGk9moHcr34mXJ/E24W6KhAX+3Y0v+J1qMwYx1qJ5OVXiGT6xVJjV2AmY89Dk
         pJT7gNDsi3hGY39JZBqwTq9Jx8wSkVvdOSQHbQxdoOq6n60gehekBZJvPHsepYxIpC
         AkLojWlRKKEzw==
From:   Mark Brown <broonie@kernel.org>
To:     guomengqi3@huawei.com, masahisa.kojima@linaro.org,
        jaswinder.singh@linaro.org, linux-spi@vger.kernel.org
Cc:     xuqiang36@huawei.com
In-Reply-To: <20220624005614.49434-1-guomengqi3@huawei.com>
References: <20220624005614.49434-1-guomengqi3@huawei.com>
Subject: Re: [PATCH-next] drivers/spi: Add missing clk_disable_unprepare()
Message-Id: <165641228853.254742.12887457813004361833.b4-ty@kernel.org>
Date:   Tue, 28 Jun 2022 11:31:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 24 Jun 2022 08:56:14 +0800, Guo Mengqi wrote:
> Add missing clk_disable_unprepare() in synquacer_spi_resume().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] drivers/spi: Add missing clk_disable_unprepare()
      commit: 917e43de2a56d9b82576f1cc94748261f1988458

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
