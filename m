Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B252222584
	for <linux-spi@vger.kernel.org>; Thu,  4 Jun 2026 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556857; cv=none; b=W/lsDxLpUbWbEEwO37lXCAugntTg6bODag+YcBLNWVqTsdFrAtDpvG4mY5WN3rV4ZJ3r/deNl4CwknUNzcGl2wiJfO5aKSDpEvl10eeGON+jJn4IE2d/IhqlGlNMWWOiNxJoZyJXVstrp+6FDcwfaFtOYoJbqsgPRgwfHYVj64s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556857; c=relaxed/simple;
	bh=dy8cCQDWGXikDQuCu/eKmyhfLPAO5i68J9FbfZ42WbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSshrcWkrMaf+MrwIYUmT217haDzigCYI8XWMSpknPm8iP/7/7NPIHikjpe1+g6q6bKH8UPN9aHOfo8ikshziL9Cfk1uIcpv4VcuVxapXcb94tQ3XcDzoegLwYh9YIYJ8XDbnnqs1jINiXGn/V5heo/pOEVYLDO/B36Jqajo5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GK1BrRAx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GK1BrRAx"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf114b0cf9so3032115ad.2
        for <linux-spi@vger.kernel.org>; Thu, 04 Jun 2026 00:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780556854; x=1781161654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KeCLb7DuMaDPrPdy8QMk7HQ5zSUfNkiDFhEooBB+e/A=;
        b=GK1BrRAxCjCdZ5tGnMjekjp4VX8YoQ8oA7UTVumvAkoFs5Stnkej02NotDi00HBw17
         e3WC6aUlM1koP56+1cw8VJy/reee+jUZKomLrj1lREWbhIfv9jIsA9LaUrJ3WzzbXsgG
         C6E6jr1LTMmdnN13zjV1rnTEoaQT/cB/ZVmUgIWQbJRzznLXTgn4MwqwtNoeGuu5RsMU
         UiDyvbysLRf7HuY60zfwU7ZwHhtL4cbFsA2Z+VoIk4gEF4OXi2pqpa2dFDcRF4NS0/Tx
         wfieVTKDPdlEVfLVIgPhKCzDo/h2EId7KobJpnGhoZ5/1RRFdRKB9iq/s+5UhJx/NJyl
         snQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780556854; x=1781161654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeCLb7DuMaDPrPdy8QMk7HQ5zSUfNkiDFhEooBB+e/A=;
        b=AGkEcbtB7hVJmzXvvS6O6NG3eSqTl1Eje6knLXL/HU0RljPJUdgA0jtOTslMeKbs+r
         x0j4VY5iZST+G3mtRJjjo3R5Swh6/+0VYL821MzE4mVpkmMQFflXhjXAqWYAUZ8K7DHo
         H5hUke7UmCgJdAl/0ugD3s05DKS4BjFggEs2LZei8EQaFHN5ANLS8mjQDiJ+P5f+sriT
         LGelj18PMAkhnK5C0L15qK69wge0KJPigrT0tRgx1J5gIkhjuhwBJ7w6Dq2o3JAxnitT
         FoPVmBt95st1fkiuymaJBPl/UCxCT81kaPdtgAILSPwvSM5+ZixkzyhczI4cNPlo6TUC
         r4jA==
X-Forwarded-Encrypted: i=1; AFNElJ80rBLsrfj2f/494NbjIbGCF1JB7nDwDA/t/sAcKHmZwLwaGM6CVAEfiv4ZBvw18ZeNOb2v2e66MM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VkfW0s04T+IGZ+J14U+E4yjY8WRsG0o7tOecVtQBK0hDj7O9
	S4CufQviglNVgWSnZ6I+STX8MV6Jc1y5zGKdHwGsdr0LCWa82hxNPXCH
X-Gm-Gg: Acq92OEwUKD7oyRpTlY7bbr4a5ruBh3HxS8epfPcAfReM2qyCPyycouyoosINvhLH2f
	I5yhVL12Meo79SJOuUKbI5L4Ked/v6/DqcZmb5tQwxYGsiN/1aoKnXT/RUUmYh++CrwRTrw6jIz
	+v4rPmKuw5SN0d3FjpZlj7EaDBFdoshwuUOf6RlxJDz5Xe0PtGUL7dBmELwSVqugYkUDspn/ybo
	f1h+tLUztjBZNEHghBDwRWPZFdI8RgWIWzhYX468imCj+8GNO0oSXx/SQwHGxfuYEB8ukJxQYTf
	1CGXHn6y69d9L5fgC6pSuLlznxKRxWojXiG/Hc1NZLJ7z5hLlkoK9kORBtIUQFKNW3HpLv/Burd
	z2O+Ox4UgF8sJB0Ux1ehjFJcQ9ikclO39rKXIFpQGAeTa+XIK2RoJ4anbKJhSK5yTFD26gS5pi2
	/oBJi+1fE/Z4bk4RJ/ILk1oyOXEimMN2aNeQRzdrrhySYGkiUBN0KrtV2gbpAWARORypGdlw4qI
	lPeQr2eCfYOAg==
X-Received: by 2002:a17:903:2410:b0:2c1:737:bed9 with SMTP id d9443c01a7336-2c1644a83b5mr69929655ad.30.1780556854379;
        Thu, 04 Jun 2026 00:07:34 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649ca4dsm46159235ad.76.2026.06.04.00.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 00:07:33 -0700 (PDT)
Message-ID: <41914879-5fd0-41dd-b097-2be80096e464@gmail.com>
Date: Thu, 4 Jun 2026 15:07:31 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add for Nuvoton MA35D1 SoC QSPI
 Controller
To: Conor Dooley <conor@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260603043551.1062112-1-cwweng.linux@gmail.com>
 <20260603043551.1062112-2-cwweng.linux@gmail.com>
 <20260603-daybed-absentee-1b64f5caabe0@spud>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20260603-daybed-absentee-1b64f5caabe0@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Conor,

Thanks for the review.

 > Missing commit message for one, but why can't your Nuvoton mail be used
 > here?

I apologize for the missing commit message; I will add a proper 
description in v2.

Regarding the email address, my Nuvoton mail adds a corporate 
confidentiality disclaimer to outgoing
external mail, so I use my personal address for sending kernel patches.

 > Sashiko had two comments about resets and num-cs that looked valid.

Noted. I will add the `num-cs` and `resets` properties in v2.

 > Drop this flash node, it serves no purpose here.

Understood, I will remove the flash child node from the example in v2.

Thanks,
Chi-Wen Weng

Conor Dooley 於 2026/6/3 下午 11:24 寫道:
> On Wed, Jun 03, 2026 at 12:35:50PM +0800, Chi-Wen Weng wrote:
>> Signed-off-by: Chi-Wen Weng <cwweng.linux@gmail.com>
> Missing commit message for one, but why can't your Nuvoton mail be used
> here?
>
> Sashiko had two comments about resets and num-cs that looked valid.
>
>> ---
>>   .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 61 +++++++++++++++++++
>>   1 file changed, 61 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>> new file mode 100644
>> index 000000000000..f7b9cb52d8e5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/nuvoton,ma35d1-qspi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Quad SPI Controller
>> +
>> +maintainers:
>> +  - Chi-Wen Weng <cwweng@nuvoton.com>
>> +
>> +allOf:
>> +  - $ref: spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-qspi
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        spi@40680000 {
>> +            compatible = "nuvoton,ma35d1-qspi";
>> +            reg = <0x0 0x40680000 0x0 0x100>;
>> +            interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&clk QSPI0_GATE>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            flash@0 {
> Drop this flash node, it serves no purpose here.
>
> pw-bot: changes-requested
>
> Thanks,
> Conor.
>
>> +                compatible = "jedec,spi-nor";
>> +                spi-max-frequency = <30000000>;
>> +                reg = <0>;
>> +                spi-rx-bus-width = <4>;
>> +                spi-tx-bus-width = <1>;
>> +            };
>> +        };
>> +    };
>> +
>> -- 
>> 2.25.1
>>
