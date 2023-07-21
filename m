Return-Path: <linux-spi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38B1C0015E
	for <linux-spi@archiver.kernel.org>; Fri, 21 Jul 2023 16:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGUQai (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 21 Jul 2023 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjGUQaR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Jul 2023 12:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E080830D6;
        Fri, 21 Jul 2023 09:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F6FF61D2A;
        Fri, 21 Jul 2023 16:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC39C433C8;
        Fri, 21 Jul 2023 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689956808;
        bh=iKn+OfuYg0Q2K9Wfol/dvpn8rCd3C49VeDo70O8Lqi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qL32q1cvGF+Ksf+s+pmMKZhN+4IMrRlywFKRaFA3QW21CTe1TtIChVgCHWsa6jr8j
         inEQlmPYesd0GZUMsJsaOzhBMDjZrgYGQqVM67n3pe+seUhN8t2kZtx/YtuIqaqpTy
         Eg6vcgfoLrokzqq657B+ssn5oTZMMCBV6DR6i95UQ14oaZsKzrliKyP6YZHmnCo3b+
         TA5PIjYcb6hp3MkEc4sR2yORD+LTiqWkse4onxBCuKVWCnQ3lJEOIzUdRp29dF7fzp
         4nrH0j1w71bFZcCnQTTFup+Wfc0z3RkFqkvnS3APzD+6/1fAOyEGew9Y5aFMBXArw4
         FfNKJDL8/GoRg==
Date:   Fri, 21 Jul 2023 17:26:41 +0100
From:   Lee Jones <lee@kernel.org>
To:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, vkoul@kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     robh+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-ID: <20230721162641.GD1908841@google.com>
References: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
 <168992615492.1924396.13464534208592126033.b4-ty@kernel.org>
 <20230721075854.GA1908841@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721075854.GA1908841@google.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 21 Jul 2023, Lee Jones wrote:

> On Fri, 21 Jul 2023, Lee Jones wrote:
> 
> > On Mon, 19 Jun 2023 10:56:17 +0100, Charles Keepax wrote:
> > > This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> > > SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> > > branch.
> > > 
> > > Thanks,
> > > Charles
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
> >       commit: e62ba8443b11f12b45c61444249458a2f8c2f4ef
> > [3/6] mfd: cs42l43: Add support for cs42l43 core driver
> >       commit: 843079209e1506c94fde797fc0ff914e2c9e6645
> > [4/6] pinctrl: cs42l43: Add support for the cs42l43
> >       commit: 85f034dd7ff0a66aded653cc91dbc406fba7cf1a
> 
> Pull-request to follow.

Doesn't build without the Soundwire header changes.

-- 
Lee Jones [李琼斯]
