Return-Path: <SRS0=1/NZ=EL=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D067C00A89
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 07:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E193C21741
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 07:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQT1WmbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKEHLz (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 5 Nov 2020 02:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgKEHLy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Nov 2020 02:11:54 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A10FC0613D2
        for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2020 23:11:54 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id t13so431205ljk.12
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2020 23:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WNBLtQhx0lIFZsfU2449a/+PzoBFm8WIuwQ69CU7rMc=;
        b=ZQT1WmbXOd3h+w+nHhJ1Vt1wtFDtE/mjJXAk3jAt2FGb0tLGDkEZJA9vr0UOxMJish
         8ii1IbOpAn0cbLZ9pCu4GcErW25ODUZam+oFxBZJvQ0UxoSB69UopiAj4o8l5CrAlTsY
         2gI+iNB8RUd8Pm3qH9WXxldgchh2IC3D/8tc5FWen4NyKWHmXWVP7ClT29/K8YeMoUbF
         YRear4W1ywXxsn8x2uJCzjPu5UcrZ7P26pW+AR9wohFxpS1uy/M16oooCzBNDITBJRNg
         AgJtZN3qVpdKC5FCW3i6N1ag2HjSXsjUqwcgUnWsoim4ZpYYvORCcaDMntQQjr4eV4Yt
         b11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WNBLtQhx0lIFZsfU2449a/+PzoBFm8WIuwQ69CU7rMc=;
        b=jxhxTDMm0Ij9+qM8JxBm4jwUaUIdu7TugKX6ogGehkOHdFVO3xR4DEIkNRny3welUb
         zjlabEv39y0cS9VSY2jL1z18zrM4GgqqE769cZBSHXn1aeXJkqiInythWi2QYZpDs3L8
         rYH1V8taORvMTU7t8X8CilmCEXuurj/otA3fiMtf28AXThHqtflOwEPyWJjzNpuqFCDE
         TYjo9/o6RQladS/mIuoOQKFNwjAegpak+4WL/QeXZl11ADr34U6sbEh2W15g9uKKfpor
         V/juDH/chM8gbm4PXrZWIyMPoNXAjktrF/IG8vHJoZ2j+Wh4MCZky+3/wk/iirqrQX1Y
         XR3w==
X-Gm-Message-State: AOAM532D8h4lY0CeCK+7uGDUf2ojcwPibUtmwAxeX9m02C8wmtGwRxgy
        sSTx+I72d/ug+YUgWjisQ+8jn8l0he2e2MAlTD806w==
X-Google-Smtp-Source: ABdhPJwYr72s3R4wIoyLlWiPnehmVLojv0mw4p7dpc7yNaYK2lfaYqyj0E3H340JMs3ERbhuf3MCk8LH9YBkbX7UVaQ=
X-Received: by 2002:a05:651c:1050:: with SMTP id x16mr388615ljm.100.1604560312669;
 Wed, 04 Nov 2020 23:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201030053153.5319-4-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20201030053153.5319-4-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 08:11:41 +0100
Message-ID: <CACRpkdZnAfogewQt83wDMmkhb4kZD=qdbq26nHcam3401WGiOA@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] spi: cadence-quadspi: Add multi-chipselect support
 for Intel LGM SoC
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

On Fri, Oct 30, 2020 at 6:32 AM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:

> +       ddata  = of_device_get_match_data(dev);
> +       if (ddata->hwcaps_mask & CQSPI_SUPPORTS_MULTI_CHIPSELECT) {
> +               if (of_property_read_u32(np, "num-chipselect",

The standard SPI bindings in spi-controller.yaml already has a binding
for this "num-cs" so please use that. It is also what your device tree
binding is referencing, so if you were using "num-chipselect" the
YAML check should give a warning?

Yours,
Linus Walleij
