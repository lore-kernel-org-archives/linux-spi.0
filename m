Return-Path: <SRS0=3Imn=DB=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC1C47420
	for <linux-spi@archiver.kernel.org>; Thu, 24 Sep 2020 12:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E88C2344C
	for <linux-spi@archiver.kernel.org>; Thu, 24 Sep 2020 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600948893;
	bh=Gbv2myf3mm/YelzUd5RFwsmoYebMix9wSgM9SCsvMZ0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=lqWS9sDLBu2dG0WQWwaJKAoQK85kvbl2NK5ZXQftZEUt4IgX/+WPN/NO3k5Pbvh5o
	 gEx2ctazyGi1iedImYkndLyyS6q5fmZf4KAjFjkorPDXAhEXpns+G8BjK7VCNXCrum
	 HVu3NrpRsnYycgIli0ScOMXtEJMG81V1OwfVbNE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgIXMBc (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:01:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbgIXMB3 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Sep 2020 08:01:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C542344C;
        Thu, 24 Sep 2020 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600948889;
        bh=Gbv2myf3mm/YelzUd5RFwsmoYebMix9wSgM9SCsvMZ0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=p/AGj8P41FOeOSee1kJ6P+5EvMNOP4CHcur8Z2oIVg7Z0AaDtls7e/ExE2rpe3IMX
         6ein54SpZ6cfmX8Tgw4pKJoIQGWDC9hMqRlHG1eSnlXkP+l3tnpIdlVlFx9bvG3oyH
         6xXlqDwP7D7O2QjosHQFFjHvzFUPPyrPyZu+Quo8=
Date:   Thu, 24 Sep 2020 13:00:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
In-Reply-To: <20200910152539.45584-1-ray.jui@broadcom.com>
References: <20200910152539.45584-1-ray.jui@broadcom.com>
Subject: Re: [PATCH 1/4] dt-bindings: spi: Add compatible string for brcmstb SoCs
Message-Id: <160094881929.50579.14070314073431135713.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 10 Sep 2020 08:25:36 -0700, Ray Jui wrote:
> Add compatible string for brcmstb 7445 SoCs.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: bcm-qspi: Fix probe regression on iProc platforms
      commit: 00fb259c618ea1198fc51b53a6167aa0d78672a9

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
