Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043A6C4332F
	for <linux-spi@archiver.kernel.org>; Thu, 20 Oct 2022 12:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJTMtX (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJTMtV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Oct 2022 08:49:21 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84005231
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 05:49:19 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z8so13575101qtv.5
        for <linux-spi@vger.kernel.org>; Thu, 20 Oct 2022 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7zzLiSLuWDpRehAEZWWY+YVaKXFqQFcIBPnNnew2YXA=;
        b=PdZuxs6MjlDnlNzQz5OvgwlDa4ipQHz3SJcbSHa8GGxbWqYSCrOhrIpgIRmL0bbZyh
         cQ/sT3Wlegy+jRZn9G1hxurXh/athUMdenfE1TvCD29eTKmi6c8pjsNRtPhrotLNmDyI
         Ogiai7InvvtM1nydktd0c3f6udis80eG18SRwTqONqnpXIzVkCOtQd7VCOHq6vwPnThU
         L6zklbV08bsN+NZcOAe15qsbT0g24eNmyKRzjz5G3amKpMkDrQGfNK8lySHp4iVl+7p0
         BuAzVzXn8CEI4UPcx8eE6mZfJ4AZlZXZpqiyZYQ78xKYVX0Mfu3M7j6TgM4q4Cqf9M92
         3+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zzLiSLuWDpRehAEZWWY+YVaKXFqQFcIBPnNnew2YXA=;
        b=pxVEf3GJnKrZZKAojQZBaIStbuaBhon9MrmrZMbrNNh5aOJJ/NFnZwggVEvy6J46q/
         y20MCMeK/Fi/dwfp0/ugNlyZ7tXPOd1Q2SA/dXxZTxTFOQYy8mfYnfljaY1zA3/TExDI
         jUwSFZhFS5HzdE4v74Xu2De1rXOh8+Okpa7Hwhthz8+F4DupRAwBv1r5ChJEDIl5sH4H
         YrjET3u5A9LvyB2jNpDSw0Ru78dObkWvFMWWe1j7Gr59VsOwTafs1Hds+XdisXeDrJ6g
         uqEvKmq4WAU/6nvBLs/5DpA6siedt9/4jjjatMZvahGMt0o0gDZkWFGdEg0X49x8dNxE
         AUog==
X-Gm-Message-State: ACrzQf0zWxHyPy7lJhY1v6O6u2tLcwFHw8L+xhBp+D04xklJYcYH/WDi
        thCtzdLtX+cNufNoK2A00vF/vj78kOHcgg==
X-Google-Smtp-Source: AMsMyM4t+vrwAcBb+25n+go7JZPtlChxYQtXIsomDdytCwaeNLSbAoJXk3x6Ke4EBw9HmsWcmg8Jnw==
X-Received: by 2002:ac8:5a42:0:b0:39d:136e:8a43 with SMTP id o2-20020ac85a42000000b0039d136e8a43mr1118096qta.372.1666270158481;
        Thu, 20 Oct 2022 05:49:18 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a430700b006cf8fc6e922sm7133652qko.119.2022.10.20.05.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:49:17 -0700 (PDT)
Message-ID: <20c115e0-0acf-dac2-2a30-0f394fa513ab@linaro.org>
Date:   Thu, 20 Oct 2022 08:49:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     neil.armstrong@linaro.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com>
 <20221004-up-aml-fix-spi-v3-1-89de126fd163@baylibre.com>
 <d355ee40-5905-4d10-8300-81e9a63117ee@linaro.org>
 <dc918114-8b89-441b-5ba1-aaf3ae084860@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dc918114-8b89-441b-5ba1-aaf3ae084860@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

>>> +      properties:
>>> +        pinctrl-names:
>>> +          minItems: 1
>>> +          items:
>>> +            - const: default
>>> +            - const: idle-high
>>> +            - const: idle-low
>>
>> You should also define in such case pinctrl-0 and others.
> 
> Ok I thought it would be covered by the pinctrl-consumer.yaml
> but yeah we should allow pinctrl-1 and pinctrl-2 here aswell by adding:
> 
>              pinctrl-1: true
>              pinctrl-2: true
> 
>

Yes.

Best regards,
Krzysztof

