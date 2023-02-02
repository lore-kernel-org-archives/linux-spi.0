Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F6AC61DA4
	for <linux-spi@archiver.kernel.org>; Thu,  2 Feb 2023 15:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjBBPAI (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjBBPAG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Feb 2023 10:00:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D83FF16;
        Thu,  2 Feb 2023 07:00:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66112B82668;
        Thu,  2 Feb 2023 15:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB93C433D2;
        Thu,  2 Feb 2023 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675349999;
        bh=CnUBlFZhISK+wfDeUEEFaanpxxSxzsCaFAeWIcOTX3E=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=FhEzZT1Y1yOboVcZwqN1KloTtfVDv2fYazSn7YxIVfE4ih/OBlm5pDQLGyI2KLAnd
         O+svJyQ3jKl0nXOFI7EJdP2zXmO2igGoAguiGGS0PSY8V3WBLgbWTMfd5Xb0WykrJU
         1aEmDhpDj9Z3SNTdTNXKYExADCsgeA5hltkA8auZUJshy7+/gLfrcYzkJSa5NEbG+C
         971Ke4vYHhE/J+DSZIC4jNAqP/RU9UJTGq5H1/XorktPKzqJKf9t9s17S0KGL9Hpvv
         h+CFbKonikP2LjB/3+eAl8hgSwNMRx9Lj3CDqr9BqF+lIABa4HkLiDDXtx9p2DEfzF
         oKA2nMAjR6SQg==
From:   Mark Brown <broonie@kernel.org>
To:     mika.westerberg@linux.intel.com,
        Mauro Lima <mauro.lima@eclypsium.com>
Cc:     alok.a.tiwari@oracle.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230201205455.550308-1-mauro.lima@eclypsium.com>
References: <20230201205455.550308-1-mauro.lima@eclypsium.com>
Subject: Re: [PATCH v2 0/2] spi: intel: PCI driver housekeeping
Message-Id: <167534999769.359854.6364951616234994334.b4-ty@kernel.org>
Date:   Thu, 02 Feb 2023 14:59:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 01 Feb 2023 17:54:53 -0300, Mauro Lima wrote:
> Found some controllers' private data that were wrong according
> to the documentation. Also, the number of Protected Regions from
> Broxton types was changed.
> The second patch adds more Device IDs to the module table.
> Probably good candidates to stable?
> 
> Changes since v1:
> 	* Change BXT to Broxton in commit message
> 	* Sort new Device IDs by hex value in the driver's module table
> 	* Add ack from Mika Westerberg to the first patch
> 	Link: https://lore.kernel.org/r/20230201050455.505135-1-mauro.lima@eclypsium.com
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: intel: Fix device private data and PR_NUM for Broxton controllers
      commit: b4c58d540777124f31ab0cb37a14c6573438d381
[2/2] spi: intel: Add support for controllers
      commit: 7c62a2279b9e88f2cbfa3b92dc49c8b7806c56f8

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

