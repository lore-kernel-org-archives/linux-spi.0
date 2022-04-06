Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2171C433F5
	for <linux-spi@archiver.kernel.org>; Wed,  6 Apr 2022 19:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiDFTkO (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiDFTjf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Apr 2022 15:39:35 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62EB1A3967;
        Wed,  6 Apr 2022 10:45:13 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-e1dcc0a327so3746539fac.1;
        Wed, 06 Apr 2022 10:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L5TvrQjpMWSCvDIj2tp5HdoUF6y6vYimFqx2SemcKe8=;
        b=U8EDWZGrOhyYcDyd0nLKND9znK9AbRVolGZ8Nf/mIbB+8XJvs3EWdYjLxFehq+14z3
         ZZzG1qrZW2bI8voW7Q7JHk1N833DoP+LqKUaDNRXZBVWnDzybUnX0KMl3w/TTarlSjRs
         AAzgwpOj/46iHJ4IZG/yF/7bG24IgdHGK1jDmPRjR0m5DW/QKjtXQb8FPo79lw3ZiPnE
         fRGXWt5T9Z92SvIGKuBjmi0YYowGVBlLouGOTVMZVMOj2L/4PtglqeXiExxjYMn7BJJO
         h6slRrskX9TSs4+rId56jpuPCiwfAuofW5TEILdr9/UUe55oMOlNBVqTVduhgX1VNWua
         R/7w==
X-Gm-Message-State: AOAM531VtMy+yroPWIWLTn9ccR+x4LQE+I5m9i9pzprfUybomeIZMsj6
        K9TvERxkDVtrhCU9B9m6nA==
X-Google-Smtp-Source: ABdhPJxevK8UXw8048KxmB62o7gsRRl5YC6His46gPTV8+KpOCTt5xixSjhRHKnoLPd4JALpA8l/5w==
X-Received: by 2002:a05:6870:210b:b0:de:6ec1:3f59 with SMTP id f11-20020a056870210b00b000de6ec13f59mr4505084oae.171.1649267112959;
        Wed, 06 Apr 2022 10:45:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id hg14-20020a056870790e00b000e1c070a73asm6082977oab.55.2022.04.06.10.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:45:11 -0700 (PDT)
Received: (nullmailer pid 2481762 invoked by uid 1000);
        Wed, 06 Apr 2022 17:45:10 -0000
Date:   Wed, 6 Apr 2022 12:45:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: qcom: qcom,geni-se: refer to
 dtschema for SPI
Message-ID: <Yk3RpmKj0eRKnCdU@robh.at.kernel.org>
References: <20220404064017.68634-1-krzysztof.kozlowski@linaro.org>
 <20220404064017.68634-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404064017.68634-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 04 Apr 2022 08:40:17 +0200, Krzysztof Kozlowski wrote:
> After adding DT schema for the SPI controller, the Qualcomm GENI Serial
> Engine QUP Wrapper Controller bindings can reference it directly for
> full schema validation.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> 
> ---
> 
> Changes since v2:
> 1. Add tag.
> 
> Changes since v1:
> 1. None
> 
> Patch depends on previous patch (DT schema conversion).
> ---
>  .../bindings/soc/qcom/qcom,geni-se.yaml       | 22 +------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
