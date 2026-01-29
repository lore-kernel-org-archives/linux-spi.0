Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377DA7E105
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701520; cv=none; b=OTwMhmNStTpdSRNwpvEC6aPnNisy9rlKMk0GfcqIpzb5rqpYgB7Shw/s2nbyGCjhE400qjdjy5Ldg9x7H1qiMxOK/D+gnHWfuATZ6MR2YzP2csmw2H+rj+wMRz5Lf7z8T3W+gNtNJNwWPVZX28eO1LZj2bLzV+/OiN2ljb5qK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701520; c=relaxed/simple;
	bh=0ygmEQM+uXYQUqBj7JsWwXJ7b7Kzre4X9O7SloOWm4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtt2K/4uL0NaiJcwwgPJveT/HMNNqDBkbe3PoFctRVcEWPELKVcFHYQfX+5bm9ShkLnnTKxMpQRFoUFIy7bhsEBuJ8TQ3i7mgmkwOoGj9sCzl1f+rRG4KOE5JQNKQ/4B3j3xrGulmzI4nntYjt+WVkKT43AF28JMoe9oTcbJwk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PibzQ4CJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a9SbKDPp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PibzQ4CJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a9SbKDPp"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TAKVbV3673990
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 15:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kvLiGYJjsQay7+umkOjbbZzrGr1HQQCSJ8GYCT4p4Yo=; b=PibzQ4CJCCEXO47n
	Mj3vgIX15EAe4ca2hCochgvknJja6DjMgTL9+UDwDXLOTFMNAA5BuoiimOHj1WCt
	niTHuISWVvDcfiB96eUnEpxBN6pDjRNecefdZhoMW43tXHlv78MKyi9hMedvQHfd
	285QCGgdIYFQ3RikjhibkKn4ao7y33sIn8vifddsm0lIquBX5v4LaUXW6NfOeVMt
	TdBcxtrHTUT+RwOsSEsmkn2nwusZXONHu6TVctffeZ30ecKA3stXVfwBSycvc97P
	Lt6MjUrT6s4dJmHYVXqbkEIpGM4JccQtwYcn154cg99DS/1jM3/RJyZ8vUhrqlGB
	n35HQA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c05q7h0fm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 15:45:18 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c337cde7e40so688791a12.1
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769701518; x=1770306318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvLiGYJjsQay7+umkOjbbZzrGr1HQQCSJ8GYCT4p4Yo=;
        b=a9SbKDPpyd0g3AZ7AJo/IbBUVxK3FXkGeLCCYHbS9sWsy3ZNaxiZaDc/wIcb/XxORP
         amhf8x8inOceLoDdt0PgqtadZINABkimk+bLzyNZCBUBcMpQImkgzLIbkRjqilSMXyJL
         NZBkSd8SICdt1NzWYlJZiHics8sCndBozUnxr1uvjl1QC7Vo1TSwvj6c3oYaskCubPl+
         0PqCFh/bq73dAHwvbS81rrBcpVfSCFLUH3t9aqlu338ISWflJlOIj6EAejFngvangFnY
         dqDdL4yAU+fZs432tU7sCXd8auFevxUSkCujUcr3TJEJ23WSIeF69QMdIAx5zkjIo2ds
         SJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769701518; x=1770306318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvLiGYJjsQay7+umkOjbbZzrGr1HQQCSJ8GYCT4p4Yo=;
        b=KvLqc9iemo+ARuHYaufBj6CBc6sgCKlUT0cMMjMSX0cTjymz/QOGnkoaDOViaSjMsQ
         hI98TPVdQ8CNbE5WVACkj9wtWRfoSgFYoLee/AKnLod9L5eO8URSH6rj8QxT5HtMSCVt
         wSIZnn0wX3KWM3OPuKbuOEPm/WoXvRfSDx7pO7h6Cvocb9yS+9fdlbxTp4s8X0KuorBq
         J1OkTXyH6TeIxbQSux/TwBHoYMLLGqEDI17/m+6LQv53y6VQITjD6ebghgwCBiSzNzJJ
         nEPFztbS1aQB1AaBJxOXpxOpgIfAPB4vNmmJtVApxBOSW/WQUjaOvl22ENc872NAWWNX
         8/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbMkYLjliH0sYKTg50NUWX00eI2gQCThN3mysLR5if9kZvZcVG0pClNo9kUzMYtzD0NRGp3yol/As=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwrbdcJ/Tk4cjarqm1DskT5TtxCscyfG7LTGhmP6dHpm3kt7sq
	rOmonNZ5vb6hCyZXWLhD6//KAyl8b6MdhEdE9lUbYxClQU235oahp3Snai5cEtUe9AvNCJnBBeB
	kVA7ajbTQg6HMphLQGI4JnZY1g8Yr87F+BbRHZUP6TSdkG4/Mao08gJd0rLir8oE=
X-Gm-Gg: AZuq6aJjieW5+WBK/E/Jgub3n/wkLS114HA9GsJBNfTlEiVQnkhYDh21jx8ujmMdIOd
	o7BbRjVGd5C51Io3NU4K1j2Ccvc5N6na/D5wEtmYWNZiwU3rnIeZovQZz8AaW1IZkbQNM0rYdRf
	reCKXUdhQ4fUl70T6tG2+Ua1jnEbBtaLa8LZ1odetXeEnCavjCBJcpiI7G0ZeWBXjzFIwxM7NGk
	PyWntHBNgHbKCRqjdbLkodCSallKGGhVorzgv3sUSPo9/BCF1fM9Kkg7gUuv3HGAYHv8J1R+wJ/
	gjVzz/DrGicxR8PGnipjMhrSCHGXcx4xHfCao5Odotm86u9dSGbDba81WB28HKxA0ThzqJBMvkg
	l79frgh+XKRCwwPJBmpE9ehzliORvfwhcILXVvzAUAw==
X-Received: by 2002:a05:6a20:9151:b0:34f:241f:aa1e with SMTP id adf61e73a8af0-38ec62e4127mr8136279637.31.1769701517407;
        Thu, 29 Jan 2026 07:45:17 -0800 (PST)
X-Received: by 2002:a05:6a20:9151:b0:34f:241f:aa1e with SMTP id adf61e73a8af0-38ec62e4127mr8136248637.31.1769701516673;
        Thu, 29 Jan 2026 07:45:16 -0800 (PST)
Received: from [192.168.1.2] ([49.204.110.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642add55adsm5038069a12.32.2026.01.29.07.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 07:45:16 -0800 (PST)
Message-ID: <57cb30cf-2da6-4df9-954d-953955969b02@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 21:15:08 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] spi: geni-qcom: Improve target mode allocation by
 using proper allocation functions
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
 <20260122151008.2149252-2-praveen.talari@oss.qualcomm.com>
 <847290c3-d5aa-45cf-a75b-ff119b608433@oss.qualcomm.com>
 <bece7d32-5f62-4ed8-8dd1-0de9102648cb@oss.qualcomm.com>
 <d9fc3b0c-7fe7-4845-b55d-ce6d0053f48d@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <d9fc3b0c-7fe7-4845-b55d-ce6d0053f48d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JEkC8zD0TDEWoylVJU_gT37hMY04ooSV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwOSBTYWx0ZWRfX7rVokmCwosaQ
 WSP0A8dmS0uR5dgHreJitW0UnXOQbPcRXs2516Xx/Vr9HLHQ1lGSJ4UmHyxC2BROXqm2r/Qn1sJ
 pg3CJNSmg5sJqu88MM9g7lHPBWbPy/ANUfrkbxHyfC1C79wQkCA7fWdYrZmhKNJpExDLRJRZ+Sw
 Rhlqm5nUU3BcvUW5h/aqAZqoi0M4szX2glfls1FwnCPIw745/ATBzd/i2efIM7zET/iQIQrrWy1
 RZwpYdeHVy2MskKcVq2aetgXtjK9MPWEEa6kuNEygnVo0LgMstDQz/JnR5b9HeT3nExwYQGIdhd
 fM9f0o5t64sfOs1Oo/V1znNfKJDXeesT0dMOAgP202Vr2PbZ6HApKwCl7Gy4rOHTC3uc4Nwzhx/
 oDLY+tjwAkrMDl2w4S5S77F9TsgXOaWnsZaLGUnbCXHKfAPT/ORSzZXz/hrpiGIDG9orwENmkN+
 saT/x9ovTWYaAq5wpeQ==
X-Authority-Analysis: v=2.4 cv=donWylg4 c=1 sm=1 tr=0 ts=697b808e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=hmzEZbfuJy6/QR5cQt8XuQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Wb7jJ4ESybac-VDgsCgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: JEkC8zD0TDEWoylVJU_gT37hMY04ooSV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290109

Hi Konrad,

On 1/29/2026 5:12 PM, Konrad Dybcio wrote:
> On 1/28/26 5:32 PM, Praveen Talari wrote:
>> Hi Konrad
>>
>> On 1/27/2026 6:45 PM, Konrad Dybcio wrote:
>>> On 1/22/26 4:10 PM, Praveen Talari wrote:
>>>> The current implementation always allocates a host controller and sets the
>>>> target flag later when the "spi-slave" device tree property is present.
>>>> This approach is suboptimal as it doesn't utilize the dedicated allocation
>>>> functions designed for target mode.
>>>>
>>>> Use devm_spi_alloc_target() when "spi-slave" device tree property is
>>>> present, otherwise use devm_spi_alloc_host(). This replaces the previous
>>>> approach of always allocating a host controller and setting target flag
>>>> later.
>>>>
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>> ---
>>>>    drivers/spi/spi-geni-qcom.c | 15 ++++++++-------
>>>>    1 file changed, 8 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>>> index 0e5fd9df1a8f..f5d05025b196 100644
>>>> --- a/drivers/spi/spi-geni-qcom.c
>>>> +++ b/drivers/spi/spi-geni-qcom.c
>>>> @@ -1017,6 +1017,14 @@ static int spi_geni_probe(struct platform_device *pdev)
>>>>        struct clk *clk;
>>>>        struct device *dev = &pdev->dev;
>>>>    +    if (device_property_read_bool(dev, "spi-slave"))
>>>> +        spi = devm_spi_alloc_target(dev, sizeof(*mas));
>>>> +    else
>>>> +        spi = devm_spi_alloc_host(dev, sizeof(*mas));
>>>> +
>>>> +    if (!spi)
>>>> +        return -ENOMEM;
>>>> +
>>>>        irq = platform_get_irq(pdev, 0);
>>>>        if (irq < 0)
>>>>            return irq;
>>>> @@ -1033,10 +1041,6 @@ static int spi_geni_probe(struct platform_device *pdev)
>>>>        if (IS_ERR(clk))
>>>>            return PTR_ERR(clk);
>>>>    -    spi = devm_spi_alloc_host(dev, sizeof(*mas));
>>>> -    if (!spi)
>>>> -        return -ENOMEM;
>>>
>>> Is there a reason you're moving this code to the top of the function?
>>
>> When CONFIG_SPI_SLAVE is disabled, the call returns NULL; therefore, I placed this check at the start of the probe() function.
>>
>> ref:
>> static inline struct spi_controller *devm_spi_alloc_target(struct device *dev, unsigned int size)
>> {
>>      if (!IS_ENABLED(CONFIG_SPI_SLAVE))
>>          return NULL;
>>
>>      return __devm_spi_alloc_controller(dev, size, true);
>> }
> 
> That doesn't really matter since spi is not accessed beforehand
> and it'd return a NULL if it failed to allocate either way
I agree. I had also reviewed other SPI drivers as a reference for this 
implementation.

Do you want me to keep the change where earlier the host allocation was 
present, or is the current modification acceptable?

Please help on this.

Thanks,
Praveen
> 
> I'm not sure this is a concern nowadays with fw_devlink and
> friends, but today the allocation happens after we get a clock
> reference, which could throw an eprobe_defer, which I think would
> cause the memory to be de-allocated again, wasting cycles
> 
> Konrad

