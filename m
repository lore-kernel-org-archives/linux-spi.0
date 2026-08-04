Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE46421239
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828832; cv=none; b=deui/d9lCmBiZYysiRAPXCh5MJwGp83x510IFwBw2lpNrAtooZtsxltLgN/SXly8mRPbU6OXKCGN5LF4qOaiNYhzANxL/gI57rpZGQS3vtNsAzoV/qZk5QaAA7QGwdFam2il8vr0E/yawtEGRnG6QV2P3NrbZROXAEvBjByuPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828832; c=relaxed/simple;
	bh=Pc1sG92KgU79aHglfgstbE9HbzWM0wDT1E3FvPcMdCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4uOqge9MUT6Z3COlS8w0KNolJTKdqDNEBRKk+5/qB6qcx1RH4DF8Y//PdHDfvC1oiTRC5ZL0pwhUNNUv/eDd7jSe3v8VHNmVnsHZ//DW+/+TbAtOmnjuAXs4qARb/GbsCzrte8+lxN3fGC56h71obD6z8ts2yvLJ80G3vfYMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6dxIkMB; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6dxIkMB"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e58034d05so4183198a91.2
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785828831; x=1786433631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XIv9dUKWHm/aOpY5+JLW7X8HZjzTHsriJBw+UKX0NNU=;
        b=l6dxIkMBPTDLyM1bbb2D5jbXlCk01ps//oB37enMRnaZDEmTLvR5mgfvNonzg/VJ7K
         2icEWARN5oyM829ESfg4j6sBs+s42kmWAjsm513QTddHxdgxodl5o2MyYOyewbTHHP06
         izkoYogC55pL9hOIZDVils6HlEeTnQcHUV+1pVlgU2KACLLGYMxTNb9GOXPGEQucLpg6
         BSFFk+AUzjgOoQkg/OwaCpdM0wB+PCEq/G5WS8nShksPKk5RWUD/tYMBmCIobAb4a0Pu
         2YfOYsNZvMujc/CpnDgqsYQFLBSC/TQEqSfwDBJp9eMs8k3bJjeNeEI1vms4AVou2WUQ
         Cx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785828831; x=1786433631;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIv9dUKWHm/aOpY5+JLW7X8HZjzTHsriJBw+UKX0NNU=;
        b=VJE2e7oWF9Qj3bk/NpptCsF8a492LLLbzRW69gLqf6F1bziQCw5M6k0HlAJYAHrRN8
         r4+XNDZVwfzmJaQI8qJqTXLfeMyy8aD4M/w8DIdYZ6osJg9JYyEbxM05XhuZKWxNqQIW
         Ra/aYf15dLZ1oIiXOf+K0s3WK/mY3LtVp7nanJ+VANlh5nK1JPvVpZs4UkXgBupKISlv
         vRlPWqWUHU3s29hgPGWO/6zD9pX+j1oNJZERZ6NjPPIlMeTji7mRYNjuFyIW4CSxTgub
         9llLwKWsshZRc3NFp8hiItWQcjhyYqLRa9lnRujirSNtUF/rbzSSnSG+q29BZw4VF2ZO
         upcA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8YUN9EcEFheqXjgnMytNOdZRzLOCt1k6CJ3YTXr8WUe1zAflS7DlvdUkyhvPg2rJE0Pm/MSP3F2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3UiskvpU86pHX47OdSBYLx6ctWblCeNUbm4v/Jgfo1FmSzlV
	ccMCCdA1wvB0szKwxns9cBEyleT/cp9YsicSUEvZshE5KglieNrt4Ees
X-Gm-Gg: AR+sD11Qmmej5X562Oa+LtYvWVu+qlL2GQnn2cHcjMaMzB4jOxRxer6kUSiO0+ryUf1
	GUmiwJErHX4UAH6qyKhbE7g7MAElh+Szp/VFxYYVotnHtebkx9dR6SVdvkkTDhF2ZExWI7Qfnex
	SxG1HKCRFdAmsinHlzDaw4D60LwfgmrQuOI0BkpAJH8jJhhkD+9T0pmV6qBM3/vq9yT4mg6hifk
	TjxxN2RHG0Vi/BgmVl64+TVulQLpnQaiHQc9x3iWou5ynpzEiePqNrqJHQpEXAfLw4LdI/Zd8pf
	ABrsEOaREmfxSIIh16kOpOR5TWHc/1McUvFTBa3nWAOlNEdViROyrEOXzORBllh5s6/F6aIqDXv
	Wkx0OjWbbbh3qObDfWl0EY7jNDhpF59O/5dmpqipY5r3fAR6VqCtOHnycmsRdQhKBOk0XK7bZ/f
	I5b6HdpM29rrH8B07qxtypqZ4xOa36iuyxRIMuU/O4mmF9bqeBc3sAZIeRB/x0p4/oQHqVQ/KeF
	E+7HB1MIbCUBAYZ/P+dtmBv6r/aR7VB07VZVuZdmUA5drsHknt9
X-Received: by 2002:a17:90b:2dc4:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-38fbc4067bcmr12402842a91.6.1785828830448;
        Tue, 04 Aug 2026 00:33:50 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fede7ad70sm864284a91.15.2026.08.04.00.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 00:33:49 -0700 (PDT)
Message-ID: <6acfb226-e63a-4c41-b67e-8d8e6bf93b2d@gmail.com>
Date: Tue, 4 Aug 2026 15:33:46 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Allow
 additional GPIO chip selects
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
 <20260803074913.1656675-1-cwweng.linux@gmail.com>
 <20260803074913.1656675-2-cwweng.linux@gmail.com>
 <20260804-smilodon-of-imminent-recreation-aa579b@quoll>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20260804-smilodon-of-imminent-recreation-aa579b@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Krzysztof Kozlowski 於 2026/8/4 下午 03:05 寫道:
> On Mon, Aug 03, 2026 at 03:49:12PM +0800, Chi-Wen Weng wrote:
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> The MA35D1 QSPI controller provides two native chip selects, but the
>> generic SPI controller binding defines num-cs as the total number of
>> native and GPIO-based chip selects.
>>
>> Remove the maximum value of two from num-cs so that board device trees
>> can describe additional GPIO chip selects while retaining two as the
>> default chip-select count.
>>
>> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
>> ---
>>   Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>> index 377ccf4fb224..f837367e6d5f 100644
>> --- a/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
>> @@ -30,7 +30,6 @@ properties:
>>   
>>     num-cs:
>>       minimum: 1
>> -    maximum: 2
>>       default: 2
> Isn't num-cs the number of native chip selects?
>
> Best regards,
> Krzysztof

Hi Krzysztof,

Yes, you are right.

I interpreted num-cs as the final number of native and GPIO chip
selects based on the generic binding description. However, the native
chip-select count should remain two here, and the SPI core will expand
num_chipselect automatically when the cs-gpios array contains additional
entries.

Therefore, the maximum value of two should remain in the MA35D1 binding.
I will drop this binding change.

Thanks for the clarification.

Best regards,
Chi-Wen

