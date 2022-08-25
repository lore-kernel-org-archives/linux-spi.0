Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4976C3F6B0
	for <linux-spi@archiver.kernel.org>; Thu, 25 Aug 2022 13:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiHYNJp (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 25 Aug 2022 09:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbiHYNJj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Aug 2022 09:09:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B8FA220F;
        Thu, 25 Aug 2022 06:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 441D6B82955;
        Thu, 25 Aug 2022 13:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513FCC433D6;
        Thu, 25 Aug 2022 13:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661432974;
        bh=Xyie5/E7rDJnNkWTaH7FOrXqEqAuMyfRz3fRYZvgsHY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OO8CYSAaWV7zOvt824Lg0YqFTjfmkXkQQ+wsMCE3bNF1rsTq2Ue/347iUgFHMsxG/
         4Cni+CgVf7hTt7PyEZU/Y5VhYxnQ57ZJaWPT3cmrMI1GkMmQZ/LV53j5DRa10p/yC6
         JCPgbHByc/UxI0CKUxhG2SE1wz3IbIf5BtvSvx/Tib4KqDBHEMwIo4cow+0OphfPFt
         o7AodMO4JeW2cOC1mUjwrNosTPryhK25QYZxYUg6+DA8UxNw/LcGdQuV4hPLKS4lpe
         TWGR9SAeJkBA90TIqCH//ceR6Qg7iiO0BMbb3iIU8BCht0jRgkxq/A40GyhZr6A02M
         Tkh56UvJCIwOA==
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     daniel@zonque.org, linux-kernel@vger.kernel.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        Zeal Robot <zealci@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org,
        ye xingchen <ye.xingchen@zte.com.cn>, linux-spi@vger.kernel.org
In-Reply-To: <20220825072828.229294-1-ye.xingchen@zte.com.cn>
References: <20220825072828.229294-1-ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] spi: pxa2xx: Remove the unneeded result variable
Message-Id: <166143297206.103379.9117489337566702065.b4-ty@kernel.org>
Date:   Thu, 25 Aug 2022 14:09:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-0c1df
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 25 Aug 2022 07:28:28 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value clk_prepare_enable() directly instead of storing it in
> another redundant variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: pxa2xx: Remove the unneeded result variable
      commit: d294e99cdc823f368530b8169e33a599fa2a1afe

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
