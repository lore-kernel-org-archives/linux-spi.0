Return-Path: <SRS0=1/NZ=EL=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BECC55178
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 07:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1540E20936
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 07:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZr14t3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgKEHPI (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 5 Nov 2020 02:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgKEHPG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 02:15:06 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF66C0613CF
        for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2020 23:15:05 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id k25so444696lji.9
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2020 23:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWG/H2FcV9+85Gv+l+usRIBA2/sArLkYfjgPcv0Ayyg=;
        b=HZr14t3YQaS6wmZGUGGg17F6YFQZb2bfQ0ZVcOAe3K3QLDNkgnakem9GKQqVifCXoi
         STNZDz8msWXRXzjPLk2dorsXnFOWv+cYTqj9SwP0FYXkvO56wXjbOi/oVEssEqCi1ZYD
         LzhOcfQ+fS+CwUTzK3AN8Sj7Y0i/pcwcBXGRXdCoAlbnDmaoPX30hUJSiOgUkJVvXwU0
         XS2Gq/vxN4oQwRmjKhARfz94fxVWwElpyCefw/fIxieFeDnt32sW5zCLpJJE8PVqkEK+
         EZWwQ7vpmdt+f3/KDMemYQogxXdNiw0wKVIKT8DMxIYPekR3ZTMMJYGW7b9eUc8WoFzx
         Uvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWG/H2FcV9+85Gv+l+usRIBA2/sArLkYfjgPcv0Ayyg=;
        b=Ws9x4vBSWVzTfG4OINK/Obl3dkbxZFzQcY0BnMjhDHPcKYzBJpJ7+Tzooh+9Zyc9AH
         8IT0WaJ4mb27/sBemA3D28KS7WKqcff8o4PWLmmgtB+7JT6BGgdZQX5YR/+LcJp5VC9c
         8A64d3Lcbc77UHeTzZ1OOPC0t1a1qA8xsmq21FwpVhRKjJLPPsModvnc0E/g1TrZtzLr
         o8zXbRf8nzbUERdtmZRGkRkgCCXcUHN/Ql9J6i0Ul3KE2R/3fzemeqghIM1Wg8qvFjvQ
         DvltWpgfHCMmuW3P74P/XD9xMLjd7Z0SnIjX77KpTcIBUHZV3NaHl5Msf7Vuu8q/yPoo
         CORg==
X-Gm-Message-State: AOAM532lCyIhLmduILBPLYn2Lp/Xrhyhzw0ZBHqxs1285zmSfZ//fxc/
        /FKkjnxlV6ZKhfFBh+DryfNVQfxr1COgU7fhJ3i+Iw==
X-Google-Smtp-Source: ABdhPJwJNn+o+smBtimGxgYjMVNR/yvh4E/UcDXbPfo1VNDoO19jZdQ6gL73qx33T8BX9/T0GwuSk6VIPutEd/pDQOw=
X-Received: by 2002:a2e:8905:: with SMTP id d5mr352399lji.144.1604560503549;
 Wed, 04 Nov 2020 23:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20201029062014.27620-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201029062014.27620-6-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20201029062014.27620-6-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 08:14:52 +0100
Message-ID: <CACRpkdaz9E2yc3GnN8wus3M+qQRknW2QMe8Kn-=o=czOQf7A-Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] dt-bindings: spi: Convert cadence-quadspi.txt to cadence-quadspi.yaml
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, Vignesh R <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Richard Weinberger <richard@nod.at>, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 29, 2020 at 8:39 AM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Convert the cadence-quadspi.txt documentation to cadence-quadspi.yaml
> remove the cadence-quadspi.txt from Documentation/devicetree/bindings/spi/
>
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

> +  cdns,is-decoded-cs:
> +    type: boolean
> +    description:
> +      Flag to indicate whether decoder is used or not.

Please elaborate a bit on what kind of decoder this is.
I am curious! :)

Yours,
Linus Walleij
