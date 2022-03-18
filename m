Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE6FC433F5
	for <linux-spi@archiver.kernel.org>; Fri, 18 Mar 2022 11:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiCRLcS (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Fri, 18 Mar 2022 07:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiCRLcR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Mar 2022 07:32:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B5F1FC9E2;
        Fri, 18 Mar 2022 04:30:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A31DE1F45EB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647603058;
        bh=8Q3rOPDXcy3uNIQL2Ds1Uyaer0s+nvv7ZJ0TUaccgYs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FS8DV4fs6ReTMDT843pIjrTELcrbprHy+UxYNc1O6uGP3HJJGSHLsBETvgSz9TVwf
         8DFkrgxX6XnGH4/jGVhlgeMvihST2+CYIO8nxnXxPCAVMXFy76U8Jh4dRb24HBkZWY
         HSJkh0E8iON5Pq4o99PNJ2MmahjFB8GEyWQh3mXfs9kfAX1ADQ01jxpe3Eiwn/V8C3
         Ro0y332WXTiiM+qa7D1BxQj5GnRt6SfnPGlzsK64Z9QNNdIS5WrWYAHSqW9sOOA9AK
         UOhEu9wBLm4U7RJm04WJuSVj1eifKG7X09zpVkH+EOSNWgLIdle51KQF0VChuvpN9z
         lxzpmLeECfDEQ==
Message-ID: <0772f5e2-3a0e-6156-627d-d037ab275634@collabora.com>
Date:   Fri, 18 Mar 2022 12:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V5 3/3] spi: mediatek: support hclk
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220318025027.31281-1-leilk.liu@mediatek.com>
 <20220318025027.31281-4-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318025027.31281-4-leilk.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Il 18/03/22 03:50, Leilk Liu ha scritto:
> this patch adds hclk support.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/spi/spi-mt65xx.c | 85 ++++++++++++++++++++++++++++++++--------
>   1 file changed, 69 insertions(+), 16 deletions(-)
> 
