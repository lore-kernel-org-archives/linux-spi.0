Return-Path: <SRS0=SzkN=EI=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37257C00A89
	for <linux-spi@archiver.kernel.org>; Mon,  2 Nov 2020 11:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1BC2076E
	for <linux-spi@archiver.kernel.org>; Mon,  2 Nov 2020 11:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGm0D/az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgKBLRh (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 2 Nov 2020 06:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgKBLRd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Nov 2020 06:17:33 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663F8C0617A6;
        Mon,  2 Nov 2020 03:17:32 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id dk16so17777797ejb.12;
        Mon, 02 Nov 2020 03:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GhkGIFuPCQH1ApZ0OEdak3cupRfMDnYm6i9v+8WlGe4=;
        b=RGm0D/azCDx/+F9Bxtb05bsbLj63EOhboPhK1LtfSVIBdpy6By7w6EHObeFCl1xOfX
         L5MnL2//34WM0z++cSQNa4pn170lNHiOIFn/kv90RoYKiLtKoPH4/0Hfr6eWjwCuDLo2
         NuV3bsM3jUdJA/mT6hKjSa70HZxRuhfuTlcTzCedxqvxR9KVfvaKBaBxNn3stIl0XqfV
         aEWlwDxRMUPCzqeoVQjvTly8UNSqCsF9mepnxc40s6iM5/w5QCNZo0R4c84x8vccpaIn
         jb7ivJjc1zr/U2oiAJobsF5CAZJF8mqQf/pM0grDdSLtBXNXtwoYMSbd9GT664BOt5kG
         3UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GhkGIFuPCQH1ApZ0OEdak3cupRfMDnYm6i9v+8WlGe4=;
        b=P3DhdroNWJZ17RPmkPxDsDCn6UAyoEFmyR1WKpCkSB1aoGveyd3f+b2cZydrZhH2qA
         PZKNDiCaG+KUcO48pbcrbsTV+K1OBfTm9OVnGj13WIqMl0XFM0dNMZVyCEnc9IQ4daPp
         ebjK1l7q6tYI9OO6Kh+wg65tMioda63uqjFgkjO7gIM2EO//DBh9RO8ybCNGe8sXa7wQ
         fNH2j2pHvLuuCzrafy5vNkQhsSw2bc+5pMc4eTYVNunIoAqW0lE4W2r3RDWwwtauew9R
         vO5wPoa337pDMYo3kvG70NtAjTG7RgO22c+SIOeV1Xzacty8Cy35T4aCkIgoKhYJsmay
         oa1Q==
X-Gm-Message-State: AOAM532NQC8v+KniaCaClMpW2dSVIcDovdMCFLOywtbcaiBANlqgg9Kt
        lBKqCSftL2tBZZlq9ncoTsKWL2eOcq4=
X-Google-Smtp-Source: ABdhPJxfyKXglpYAvBVzNZEI2IIKfQ7kp7OVt7i8YTiqQIwT+Pw7CRKt3Rq9fheLYjamTp14X9R0IA==
X-Received: by 2002:a17:906:c8d8:: with SMTP id gc24mr5556078ejb.417.1604315851176;
        Mon, 02 Nov 2020 03:17:31 -0800 (PST)
Received: from skbuf ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id pw17sm9481559ejb.116.2020.11.02.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:17:30 -0800 (PST)
Date:   Mon, 2 Nov 2020 13:17:29 +0200
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Message-ID: <20201102111729.psxu6cx2mccbtra2@skbuf>
References: <20201029084035.19604-1-qiang.zhao@nxp.com>
 <20201030131828.7h25eps7wuf655eh@skbuf>
 <VE1PR04MB67686E6B184C4EC4076172AE91100@VE1PR04MB6768.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB67686E6B184C4EC4076172AE91100@VE1PR04MB6768.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 02, 2020 at 02:19:28AM +0000, Qiang Zhao wrote:
> How about it looks like below:
> 
>     spi: fsl-dspi: fix wrong pointer in suspend/resume
> 
>     Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in
>     remove path"), this driver causes a "NULL pointer dereference"
>     in dspi_suspend/resume.
>     This is because since this commit, the drivers private data point to
>     "dspi" instead of "ctlr", the codes in suspend and resume func were
>     not modified correspondly.

Looks ok.
