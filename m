Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F54C97
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 01:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486300; cv=none; b=eME/eVv11ULckmvnLHzLgW9R3vywYvPumnCgmGuvEY7YZSysD8NDLYJsirclmMdeczqrSxBZ62mUUWetkXoogJgxcnAi8Td+VSXFhGkDMTQ+IJJZ3MQcm2RmOB2MNEfoy84F7zqwBlZPm5ok9ZYY6Ect5lz4R4H+/y9wzCz0GQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486300; c=relaxed/simple;
	bh=/pzSwr19+VdrcX+IqjZIPPA/r+0axARzOy4vWIKuvpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeG/M7zm2mWJT9QPimfSn7ZglTIKQkeduqsUfBtO1rIuDP15H3gOIf9sIZJ/5+Tpv2G4EyMo+pkdWR7PUM3F+81djiM0KpzHR4cqtVGGG7XHL8rv0RhfmQ97em74TwzLepJWiBFEAeScjySEdt26a8P/NDOW+O3oKf361D74vsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4M0ubql; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4M0ubql"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1397e093f90so1118650c88.1
        for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 18:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781486297; x=1782091097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xD2K3MV/ImpTfNxgjLbCTNSQAYJN87stcDsw5szY+bI=;
        b=c4M0ubqlNp/XFMMAgTtdVKxagQYgzROC8FdyWXPH8MhLz64WbjbhN3iKpk4HKfRd/v
         VFrq1gexltBqMKCJijcLsq59rCLVRkT+yy2LA1B2N3lG6x6v0DdgM1Mh3WtCVJ1HPY94
         jm/x82unjkyPUR8XPudaVn+8Qf5H/XVJ+Zvy6MaPv9J0Ue7Z3FmghfB5XfNCqDRkcmSq
         MfVyATKeSKdfoLlUgb65chtYpNETkNcTe/yBc9r5BTqOi4Qlx09yjnm1blRbkT/RBh2a
         xpLJf1SljzFyklbytsZpTBrohqOh/mguxQqWGjR2eDo/2U7I5oAXIytw0qBFhg+qNywo
         ACTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781486297; x=1782091097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xD2K3MV/ImpTfNxgjLbCTNSQAYJN87stcDsw5szY+bI=;
        b=cAr/XcwCH7EzU4+DsGZZvj0QT6kanMSKaKAguskS2dhW2xRdkF7CGYJ7w5+RiCgnpp
         l7SgW40BUDAhQiaxBgH42Onb9+UD+zJQLEQKWbxVnF6k8TES7IGszxsUr5ub4qkMJsPa
         lC3sKo5ttXaPnjAS3Ituwe5yGiSi8WTU33EQWAdjf038FG9xzvXM+ir2nwsbYooP9SMr
         RWBQz8wthDZ2hsTLPtbG5KCOHQqG5RhHShw/MfCgTYCRv6ZoGpUA7qSpXmVDrt4dqCtl
         dArwVlByMWVQpfVHFnnmP9R35CSHcSQYQ+/d93f1RdObJlk97AC+HLMJvCIjiPjWFBip
         ojDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+n7IRUNQm0NuwX2m+aYQ39SBCDtRSp5L/V8xWNjM+6LRW5NxebaWdf2X+D0ECqq/57eMnGZJkDyg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4AvKltfZMBdY3xwWbIPjw1DIgaFzB2CdvBKF4/gnru3yFJDVK
	Lqoz8HoJtcW4hNzEAUzTaCSeCMvZh+1qMXBtF4Xz+2/9Uisbop29kmGj
X-Gm-Gg: Acq92OGfFrx82sP7wTLRZNHvRe8YPF1N0DHK8ncCHf1+XiZrjOGc25Xp7Kjd2oRFd/8
	ZLunwtzOCImdUK8J9yrckIBWWWAeYHRodJmNc9j0ebXDhSzTlLlwKmd/VDM9D4sRQha2Ib+kA6E
	MXxK7N8dPlo5jtFvVlHoUYWa50hAkGHT+cEfWItmHdNiOLrvGynGMP+4iA2Nq+DcsMENDgBkrUL
	hAusoUuGhDJ/LPqyrfiv4TncPocE7Ht8Q99JCm+sus2Oe5su63gZrBRa81GxQxHx6cLIvD7TaSl
	gZr+LKqzCxcZbX4q+3BQ7wRuESH3Vo6hhvpkOAQSEPysQQJFtHBgOZJs4Ik8gd2VtVowVJ5It17
	qHhOXkw5PQwVUmmnP2FsGFC8Sx5bwVqA9s04qE8+9cuNoGwK8IoybNRtJ20l2QWBQbVIUruEwXg
	xH8RB8I9YRgDBqaoGqe2ChPh2v6QFl8GYhORYHR3AbiXBUHmKlrQBjRKmyVH4BYDETek0Pq4R4f
	4E=
X-Received: by 2002:a05:7022:629f:b0:137:6bdb:5842 with SMTP id a92af1059eb24-1384b97f25bmr5877161c88.0.1781486297416;
        Sun, 14 Jun 2026 18:18:17 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b964862sm8982362c88.10.2026.06.14.18.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 18:18:16 -0700 (PDT)
Message-ID: <59dbf955-56d5-4d72-85ca-0ed8407de295@gmail.com>
Date: Mon, 15 Jun 2026 09:18:12 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton
 MA35D1 QSPI
To: Conor Dooley <conor@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260611091246.2070485-1-cwweng.linux@gmail.com>
 <20260611091246.2070485-2-cwweng.linux@gmail.com>
 <20260611-decoy-glamorous-81903a5fd1f9@spud>
 <0031379c-0cc3-40c8-8145-5b1991b42f05@gmail.com>
 <20260612-diagram-florist-01a0e8f923d8@spud>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20260612-diagram-florist-01a0e8f923d8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Conor,

Thanks for the clarification.

I will make the driver read num-cs in v4 and fall back to the hardware
default of 2 when the property is not present. I will also keep the
binding default in sync with that behavior.

Best regards,
Chi-Wen

Conor Dooley 於 2026/6/12 下午 11:48 寫道:
> On Fri, Jun 12, 2026 at 08:33:01AM +0800, Chi-Wen Weng wrote:
>> Hi Conor,
>>
>> Thanks for the review.
>>
>> I will add a default value for num-cs in v4:
>>
>>    num-cs:
>>      maximum: 2
>>      default: 2
>>
>> The controller has two native chip selects and the driver currently uses
>> that hardware default.
> The driver should handle the property and fall back to the default.
> It's not complex to support, so surely there's no reason not to?
>
> Cheers,
> Conor.
>
>> Best regards,
>> Chi-Wen
>>
>> Conor Dooley 於 2026/6/12 上午 01:34 寫道:
>>> On Thu, Jun 11, 2026 at 05:12:45PM +0800, Chi-Wen Weng wrote:
>>>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>>>
>>>> Add a devicetree binding for the Quad SPI controller found in
>>>> Nuvoton MA35D1 SoCs.
>>>>
>>>> The controller supports SPI memory devices such as SPI NOR and SPI NAND
>>>> flashes. It has one register range, one clock input and one reset line,
>>>> and supports up to two chip selects.
>>>>
>>>> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
>>>> ---
>>>>    .../bindings/spi/nuvoton,ma35d1-qspi.yaml     | 62 +++++++++++++++++++
>>>>    1 file changed, 62 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>>>> new file mode 100644
>>>> index 000000000000..d3b36e612eb0
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>>>> @@ -0,0 +1,62 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/spi/nuvoton,ma35d1-qspi.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Nuvoton MA35D1 Quad SPI Controller
>>>> +
>>>> +maintainers:
>>>> +  - Chi-Wen Weng <cwweng@nuvoton.com>
>>>> +
>>>> +allOf:
>>>> +  - $ref: /schemas/spi/spi-controller.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: nuvoton,ma35d1-qspi
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  clocks:
>>>> +    maxItems: 1
>>>> +
>>>> +  resets:
>>>> +    maxItems: 1
>>>> +
>>>> +  num-cs:
>>>> +    maximum: 2
>>> Missing a default of 2, unless you make the property required.
>>> FWIW, your driver doesn't appear to read this value.
>>>
>>> pw-bot: changes-requested
>>>
>>> Cheers,
>>> Conor.
>>>
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - clocks
>>>> +  - resets
>>>> +
>>>> +unevaluatedProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>>>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>>>> +
>>>> +    soc {
>>>> +        #address-cells = <2>;
>>>> +        #size-cells = <2>;
>>>> +
>>>> +        spi@40680000 {
>>>> +            compatible = "nuvoton,ma35d1-qspi";
>>>> +            reg = <0 0x40680000 0 0x100>;
>>>> +            interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            clocks = <&clk QSPI0_GATE>;
>>>> +            resets = <&sys MA35D1_RESET_QSPI0>;
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <0>;
>>>> +        };
>>>> +    };
>>>> +
>>>> -- 
>>>> 2.25.1
>>>>
