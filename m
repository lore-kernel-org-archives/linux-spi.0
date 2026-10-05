Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229419CC0F
	for <linux-spi@vger.kernel.org>; Mon,  5 Oct 2026 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791169689; cv=none; b=h5G8qJmHA9mn6q2N1OOrGNhQt0I6a8dHYzkQuXJ9gb2GkD/D63bc0kMakClrVGJ8ExLMACBvJLqYCFhFry/dQyYXhMq4n34VglbmnSFnnYjEJqtuy47rzeMY+bMYMq+ZH3O2C8A0DnHoD0vavhm8N8oIIZGm1tphpVvs2VzbMvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791169689; c=relaxed/simple;
	bh=3yFEDiOLVMsJyEOVraTu9nOIGvr8skJyU0mQeCxspoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQEnrbM0cBPnsrCa3qdXvV1pBa1XvE4OKTkaG0+hBMhdZoX/ZKliTMdDUKYL4iFlsdxaEHcwB0T2eWjOUh0lF9rST76zt2NHgqlHlDgk/VAP4Fwfhfl7SzihepPR72dl+GrjMTQnFdVupRD+PkG51Z2H+5pltR6K6JhbqPJZWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuEPmH9g; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuEPmH9g"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so430775a91.1
        for <linux-spi@vger.kernel.org>; Sun, 04 Oct 2026 20:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791169687; x=1791774487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUwgITrS/KUPi15l4I3iar5grcNqp8PamuCjtCJWXOI=;
        b=OuEPmH9gjMyt8ZuIRBKsASCMQkSyJaZG7JIb9h6TBkpl6F39W4ASAVBWnM6K37K2KX
         xjCoNoqgI82TUmTdqJR+R5bvBhJbmEr3/y5zP6YQGSPDB0KzRqTHAFaFvEwmWAX/AGYg
         5dbokoi/0iBcaa7SV4IZOxTpXOw4TKUKA77LRqnKTo+5NuRyKceq6ek9wqYb1IzmBnOW
         hgQ+AWb0AqeujX7RlIkXkfD8MCSkwVQZhOu8Ea1saqRvyOtM3nRFiY0hCu2u9Ax+uKqj
         TcnWWNm+rL15H4mycUJj4HV8PdYdOiD4RJ2Ho5w5pYiW04+vduPZamUjZP7uvX4rRQdu
         P9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791169687; x=1791774487;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUwgITrS/KUPi15l4I3iar5grcNqp8PamuCjtCJWXOI=;
        b=MhThRtLY+4Y5NTROyRkJMu5YtSUiGUpEC7/hWkBAVcoTm7yaugHzg/1x401fGVLfiq
         tSi532tSUv+orr2mIc9954j4qdNcOXmM49T0blh/Y46Fczb/d1apwnhZlQHshEH1DA+U
         1kxxfTqPNIj6EGGI4DfLD5Iq/8kSaNZMS/AMgD+0QL4IMba1SqW6/+/JnFMpW7JgZYkT
         iopRI7sZ+KqXSTN1wH3UXcJ6xclUjxix7PBV7uTmsisWRUHoyOqrrBS3yDjzku5GCHBh
         lCGBjMeBx3+KFulpS312ytg6xeiIL/kGpO6fkXwOPL5c2Kjgcn+n1IIJOo3BiJTzmfC6
         QA6g==
X-Forwarded-Encrypted: i=1; AKwUvBwkAbBjzhBEt3wMXsEphVdSGIhQoHm2/2+MLmFKXyhvv9bAo4q0R8QNf3Ms66k4s5zN0/JSNLuu1u8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvuhEwGCw4DBfGGQ6LCK9rwXF9UA9iY2+xV+A2mpvwT5WSpHRe
	lLE/xLPLtXl/phm0QQL796tsY9F8v3iO1dKokhxcSbRSnpO2RjD5pBpz
X-Gm-Gg: AYBFou0tiwixPeo80NMLqMbTijBowEXhv+78e734H3WdMIh8kHv8qr6Xj1AIg/XY11K
	/rnilNdjIgTst2B4ZwLpSg2AimAIg98/rGlTCiPt6L7cKLCqShx0pHiFeAoIPzdf3r9lqFUSq1B
	xVy6H39K9tVI1PYDkmYvUytTc2ceIUNRH4NnSixww+40YmHKakzTUhQNotZp3mx+ymeh5SO5D6D
	W2rm7WqqDUGKt8yk0/hEuKvCPnRkbkAOraPpcFYIBtC/tWO6zla1D5X3Faqir43Q+iosIWOjHpT
	Yl5UvfPaM9n08JfGFranDJEfnDrkvfN7P1Ti/p7gspUBhr17+zhUygUvJ9+tirfdrOWBZReSffD
	2hpIj8fU7v2T6ZyC2115Rt8p/dQlwwwryaj2DgvRZ/fbFU0wq7lTWgmQCtHQO/VBcV+ZbugPwti
	tUYyCM/b1o/uJj86ZIV2Ct+L9ZC0BU1M2sh5YLKAMYDaaEcj1kTp7mOYEa5IpTBgIe19htRXwNW
	CKQ+jLqbwzymnoKWM3ZECahuaigEVp/UakL/vYDk3J89s6qbg==
X-Received: by 2002:a17:90b:4ac1:b0:3a0:ddd6:896c with SMTP id 98e67ed59e1d1-3a6ce6af244mr7716297a91.17.1791169686748;
        Sun, 04 Oct 2026 20:08:06 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e497230sm8991834a91.11.2026.10.04.20.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 20:08:05 -0700 (PDT)
Message-ID: <9706e01c-9c90-4dbc-a694-7f88bf7ee38c@gmail.com>
Date: Mon, 5 Oct 2026 11:08:02 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: nuvoton,ma35d1-qspi: Add MA35D1
 SPI controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20261001131818.110028-1-cwweng.linux@gmail.com>
 <20261001131818.110028-2-cwweng.linux@gmail.com>
 <20261003-innocent-placid-markhor-e7c6ec@quoll>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20261003-innocent-placid-markhor-e7c6ec@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Krzysztof Kozlowski 於 2026/10/3 下午 10:25 寫道:
> On Thu, Oct 01, 2026 at 09:18:16PM +0800, Chi-Wen Weng wrote:
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> Extend the existing MA35D1 QSPI binding to also describe the MA35D1 SPI
>> controller.
>>
>> The SPI and QSPI controllers are separate hardware IPs. QSPI additionally
>> supports dual, quad and DTR transfers and a target-mode timeout function,
>> but these differences do not require additional controller-specific
>> Devicetree properties.
>>
>> Both controllers expose the same Devicetree-visible resources and provide
>> up to two native chip-select signals. GPIO chip selects are supported
>> through the generic SPI controller binding. Since the MA35D1 QSPI driver
>> now supports GPIO chip selects, also remove the existing restriction
>> on cs-gpios for the QSPI compatible.
> 
> This has to be a separate commit.
> 
>>
>> Add the nuvoton,ma35d1-spi compatible and update the binding description
>> and examples to cover both controllers.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
>> ---
>>   .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 41 +++++++++++++++++--
>>   1 file changed, 37 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>> index 40965ec5163b..72f2e1e1219a 100644
>> --- a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>> @@ -4,7 +4,17 @@
>>   $id: http://devicetree.org/schemas/spi/nuvoton,ma35d1-qspi.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: Nuvoton MA35D1 Quad SPI Controller
>> +title: Nuvoton MA35D1 SPI and Quad SPI Controllers
>> +
>> +description: |
>> +  The Nuvoton MA35D1 SoC contains separate SPI and QSPI controller IPs.
>> +  Both controllers expose the same Devicetree-visible resources and provide
>> +  two native chip-select signals. GPIO chip selects are supported through the
>> +  generic SPI controller binding.
>> +
>> +  The QSPI controller additionally supports dual, quad and DTR transfers and
>> +  a target-mode timeout function. These capability differences do not require
>> +  additional controller properties.
>>   
>>   maintainers:
>>     - Chi-Wen Weng <cwweng@nuvoton.com>
>> @@ -14,7 +24,9 @@ allOf:
>>   
>>   properties:
>>     compatible:
>> -    const: nuvoton,ma35d1-qspi
>> +    enum:
>> +      - nuvoton,ma35d1-spi
>> +      - nuvoton,ma35d1-qspi
>>   
>>     reg:
>>       maxItems: 1
>> @@ -33,8 +45,6 @@ properties:
>>       maximum: 2
>>       default: 2
>>   
>> -  cs-gpios: false
>> -
>>   required:
>>     - compatible
>>     - reg
>> @@ -59,7 +69,30 @@ examples:
>>               interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>>               clocks = <&clk QSPI0_GATE>;
>>               resets = <&sys MA35D1_RESET_QSPI0>;
>> +
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +        };
>> +    };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +
> 
> No need for a new example, for exactly the same node. Difference in
> value of a property does not justify it.
> 
> Best regards,
> Krzysztof


Hi Krzysztof,

Thanks for the review.

I will address both comments in v3.

For the binding changes, I will split the current patch into two 
separate commits:

1. Extend the existing MA35D1 QSPI binding to also describe the MA35D1
    SPI controller.

    This patch will only update the title, description and compatible
    list to cover both the SPI and QSPI controllers.

    The existing `cs-gpios: false` restriction will remain in this
    commit.

2. Add a separate binding patch to allow GPIO chip selects.

    This patch will remove the existing `cs-gpios: false` restriction so
    that the generic SPI controller binding can provide GPIO chip-select
    support.

I will also drop the additional SPI example. Since the SPI and QSPI
controllers use the same node structure and only differ in property
values, the existing example is sufficient.

So the v3 series is planned as:

   1. spi: dt-bindings: nuvoton,ma35d1-qspi: Add MA35D1 SPI controller
   2. spi: dt-bindings: nuvoton,ma35d1-qspi: Allow GPIO chip selects
   3. spi: ma35d1: Add Nuvoton MA35D1 SPI controller support
   4. spi: ma35d1-qspi: Add GPIO chip select support

Thanks,
Chi-Wen

