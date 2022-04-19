Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA22C433F5
	for <linux-spi@archiver.kernel.org>; Tue, 19 Apr 2022 22:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358302AbiDSWsa (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358296AbiDSWs2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Apr 2022 18:48:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AA1245B2;
        Tue, 19 Apr 2022 15:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9202DCE1B13;
        Tue, 19 Apr 2022 22:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCA4C385A8;
        Tue, 19 Apr 2022 22:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650408341;
        bh=7G4T9HDH5KBY1sbgZAXpSndGbsIkBTRKpbuepme/H4M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=JpPwnMHEWo44yCOMfT5Sq093mU9oR+fwyPLMMDFox8qvXNWwMLgrPDgi8frZYTsto
         tx9CivkZc93GsncmHtN04ei67wqBaBaMY2XEgrVU31jT2C2e/7UnwGfkvoetf0Z6si
         vqP/c8xjb5GwhOwaoIt+eV6wt1oneBQ4j0xFOPCTFcTV+WwClHyMxQcnvehI2Vbucq
         Vb0j/jQ6qJFgMnSnYPTPBrC/ciDP8VyTBFPE35iY3M+Ll//z73hj3I/7suymTfxVZc
         Hbf6Gw7p79JAnqHDt+SXwMW0FoJk0I5isfemuU4OQbXyh9dNwKXf+xuf/jEvRtwEAD
         eYVBL/foR8Lfw==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     zealci@zte.com.cn, chi.minghao@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20220413093656.2538504-1-chi.minghao@zte.com.cn>
References: <20220413093656.2538504-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <165040834044.1910395.6017402635359899721.b4-ty@kernel.org>
Date:   Tue, 19 Apr 2022 23:45:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 13 Apr 2022 09:36:56 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-cadence-quadspi: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 3a2ac5809935e6043dae916bab6cf4741d9dcdeb

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
