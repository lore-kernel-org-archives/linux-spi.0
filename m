Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC6331234
	for <linux-spi@vger.kernel.org>; Fri, 30 Jan 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769772172; cv=none; b=XQ3OwTQ29GxjaBWa/N6LANyOrZ8ap5pzMj7cPKV6Tb7WvPFU8EjJrI/jZc0VbA99OxEl5dcBFelmaiuLUqXXauiMLq4/dcPLalsYARjKOjK3t3CBXOJ10vWGX0DPAx1K8xQd4nMeNlYGGUutOaGfluycI3tPduq+sb3tXZO4RXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769772172; c=relaxed/simple;
	bh=dVjadyquaKeik+5XqUpXlDz1A5y0JMoA9NMOSF7QWGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nm8hk3G6Yzgu9s8ZhExUDLuVN657MzfwrSszx8Ka0ImF/SL/G0XO16UwWR2b5I5ztBcxxc5Xs1eijvDJ8MKBD/xMNf1iG1HJKArXEs5riSEeXRqeZZPCV4H3KWvJ4k190IlfF5zTv3GJnByRZqfj4a0MVoiseRxZA/+n9tAPpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aG74lj8t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=idWDXjZv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aG74lj8t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="idWDXjZv"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60U52eTR555437
	for <linux-spi@vger.kernel.org>; Fri, 30 Jan 2026 11:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q2Pmi2PxduAkYx18ZQxB/YX4MWuCY7zbCFQhTQcTLeI=; b=aG74lj8tZWyRJQ6r
	NXobRax75yiwrtGA64xgv01k7CoP9CKBIG7x1wOWGC+Mea73DMGqDE7c/HgrX7A3
	fjsrAW0SenF/F/DbXVvls5xZMvg3DR3wQ/xRwC4+Cs4qwo6UvolYw1Oiu6Ze3F6z
	XFbK60uSskLJNq1q3qHBBna7A7Dao+y/dQiEuRzi/nQo37lEfSRq5F5QerFechqy
	Kaa3w8UvBMNCnbKGu0QURP7SJUC+bUgDFouPfzyt5mrobmTGEEGECyJKqy7LvcqC
	tiM9CJYobk2Ryni80qIJcyFtx1Bhxh8JQXxi35AF82d9r3HFg8UsC7JzrTsiK5vN
	OUKEgg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p59h3hg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 30 Jan 2026 11:22:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-502a477885dso1151091cf.1
        for <linux-spi@vger.kernel.org>; Fri, 30 Jan 2026 03:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769772168; x=1770376968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2Pmi2PxduAkYx18ZQxB/YX4MWuCY7zbCFQhTQcTLeI=;
        b=idWDXjZvE6KkJtYNytgCWEgVkDquZV9BwksT/muPjijcDtM1eAArh7UGNl8gtQHeuU
         mEAa1r/LvrYeLVOIE49FsBhMIXiaIUrtkpJglsribsZ+sPs5R900yBHq+sh9jOF344EN
         X6q+WJwAAr05t2dnHYm6PZOHzRpcXiEL3PZWkyKedoNec7QjRkNGxbpAnzfAoEIQQGkO
         sVtRVk08QWiA5SVMpyZgi1kHBX+6sqOfwl6ZNtt7MtjYcwbpIRYyqrUaWBnZEyPXwPiD
         eMQOkTfOSeQhC+i0TuLkbaqOcYZB3s2XggPuAUrvbFobL0OoZIS1I5dEVPF1wDDUOVLI
         FuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769772168; x=1770376968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2Pmi2PxduAkYx18ZQxB/YX4MWuCY7zbCFQhTQcTLeI=;
        b=vBR4FYr02M6ooTkZf6oI8NWsm+bE0BWssNgbfJrDXTMll0XQPEal50P2p0azRSHwBO
         vx4Ejc4i+s3dDXk+dU+48fl6CMFFyWFN7Od6ORIn7BgpMsKA4JR6QEBfeIvejbF1qVKB
         Onfk/NKNgNwk+OZdkSfmjfNLhUx3upihFjU2gVG7WyAra1umcJgYWSirH9kxEsy+l5aq
         ej0TO5z2KwIw6jj0pVidRyWDpyHRgILcInxyXMaP+BhnVGhhlk79Q7FolOHmtlb8MCCP
         Uli6w6Cpu/RgOBYaCo2yeVHtuJJE26hV01ZsSf9BtMrEHLIotlabzgj+yZxVH55odlQV
         tMrg==
X-Forwarded-Encrypted: i=1; AJvYcCWqT8A3cYrVghxqc4+gz2a4h2Wi8BL/VNcAUHlVk78XnZKxztt0Ckpb3puQpZEUNycBqxXdkaHGIDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhkFwVDpVUpHpLZjT0fdUUpIdYocy0olWMaKhLwHlMDaKzMpSc
	bqdmsTuvxvN4DE3Iih5RPxpz33tmhuXr+OHgoJTRWqzPeRiSv7X+WBQsCnbK0RUwoSyb56qnnej
	UcCipxZ3yBQ4xjOKSs7x/bVI3XlXx+0iQa8UmDYvH1Exj4+6VOWABGG1TOfjZ9zM=
X-Gm-Gg: AZuq6aJ/N1RxKMFOHP6POImLuS86wPRNjhSZtnLgoAhMWOzhC+sQ5BtRgKFRMwCsX50
	tw3N68Ooa0rsZmakRZj9E32+1hMcKEBpboEcWfNL0diHqxAN1GCq2BH6K63V+nDzDyFCT6SdnYG
	2Yn0wnYRuYqWfdHPDJofnhrvvzNPczUIFLsRGIN+C1lstEgZ94/yIaFL3wllEh0hg1auCtfLeBJ
	zOFKOOfBa5dYEJktjESh41CmA7r+JhgMwTTl8BGPyzGQvk9ZtaGzT1YFDtSetfi7fTOWTbeuON7
	PGRg8XTTRdGVoSx5v27iXnzzbb1FnX5hnZ2wD/8FOz/sKLAlNtGzF00v+f4uchclyysllHUAA2Z
	1e9Qxf0DikItf2GsJinnXeAR0r6TnnQusQaj3RxOXHcKi0vsZaTfXUI5jmcYvQgekBAQ=
X-Received: by 2002:ae9:e710:0:b0:8c9:eb7f:b6d with SMTP id af79cd13be357-8c9eb7f16d1mr199456185a.4.1769772167755;
        Fri, 30 Jan 2026 03:22:47 -0800 (PST)
X-Received: by 2002:ae9:e710:0:b0:8c9:eb7f:b6d with SMTP id af79cd13be357-8c9eb7f16d1mr199454985a.4.1769772167343;
        Fri, 30 Jan 2026 03:22:47 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8de46abf6fsm226693366b.52.2026.01.30.03.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 03:22:46 -0800 (PST)
Message-ID: <32eb6d3c-835f-44cd-9852-96ddc8661113@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 12:22:43 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] spi: geni-qcom: Improve target mode allocation by
 using proper allocation functions
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
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
 <57cb30cf-2da6-4df9-954d-953955969b02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <57cb30cf-2da6-4df9-954d-953955969b02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _S1VSXQhytTXnzp6w8WZaVQN2p3-G0mm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA5MiBTYWx0ZWRfX0ObsWPkDZRgW
 LweWvUICA45H9fcY3VR+HdbspHjQnolUEkmP3dpGVD2AvHomExUsu5GbL+hUwjS6ld3MME3oFNW
 Km5a+SzlPttUv1kzw6UwK3Cwwq/1noINCbzjZfVULh9KkpkYVtzBu+lVUqWDVKLz2xo6MjHt4YM
 6p4Vo1VTZAGpgcc4k0Itze2gVTDqB/j7aIA2WblCxGjKhvy5atigP3NbyzRIBbnxagcTPaxnFrl
 BTBb3cq2NVRGB9+nThBERwD+kwVtMpx0PAeJgBNu/R0y5BHgIh+gWUH0Q73YLqbOeTiL8kgOmCr
 at9yM2KwCrtzdaGwoeW+Tms5PE+Z3ZJN6YIl7gfHcz7Z0SZGriVEReRRiGF5ZT40s9wd+n4u6hd
 RkMTiMBus1bi68RN9dxNZHLsbuV8xR7D120tyRIPz1I3AQ4kv9rTB+VwreuFt+5Iyuhkusxhe01
 y/UZJBf2XGVtyZtfJng==
X-Proofpoint-GUID: _S1VSXQhytTXnzp6w8WZaVQN2p3-G0mm
X-Authority-Analysis: v=2.4 cv=Re+dyltv c=1 sm=1 tr=0 ts=697c9488 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=DI4xcUXyGD7WBy4uMMEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300092

On 1/29/26 4:45 PM, Praveen Talari wrote:
> Hi Konrad,
> 
> On 1/29/2026 5:12 PM, Konrad Dybcio wrote:
>> On 1/28/26 5:32 PM, Praveen Talari wrote:
>>> Hi Konrad
>>>
>>> On 1/27/2026 6:45 PM, Konrad Dybcio wrote:
>>>> On 1/22/26 4:10 PM, Praveen Talari wrote:
>>>>> The current implementation always allocates a host controller and sets the
>>>>> target flag later when the "spi-slave" device tree property is present.
>>>>> This approach is suboptimal as it doesn't utilize the dedicated allocation
>>>>> functions designed for target mode.
>>>>>
>>>>> Use devm_spi_alloc_target() when "spi-slave" device tree property is
>>>>> present, otherwise use devm_spi_alloc_host(). This replaces the previous
>>>>> approach of always allocating a host controller and setting target flag
>>>>> later.
>>>>>
>>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>>> ---
>>>>>    drivers/spi/spi-geni-qcom.c | 15 ++++++++-------
>>>>>    1 file changed, 8 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>>>> index 0e5fd9df1a8f..f5d05025b196 100644
>>>>> --- a/drivers/spi/spi-geni-qcom.c
>>>>> +++ b/drivers/spi/spi-geni-qcom.c
>>>>> @@ -1017,6 +1017,14 @@ static int spi_geni_probe(struct platform_device *pdev)
>>>>>        struct clk *clk;
>>>>>        struct device *dev = &pdev->dev;
>>>>>    +    if (device_property_read_bool(dev, "spi-slave"))
>>>>> +        spi = devm_spi_alloc_target(dev, sizeof(*mas));
>>>>> +    else
>>>>> +        spi = devm_spi_alloc_host(dev, sizeof(*mas));
>>>>> +
>>>>> +    if (!spi)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>>        irq = platform_get_irq(pdev, 0);
>>>>>        if (irq < 0)
>>>>>            return irq;
>>>>> @@ -1033,10 +1041,6 @@ static int spi_geni_probe(struct platform_device *pdev)
>>>>>        if (IS_ERR(clk))
>>>>>            return PTR_ERR(clk);
>>>>>    -    spi = devm_spi_alloc_host(dev, sizeof(*mas));
>>>>> -    if (!spi)
>>>>> -        return -ENOMEM;
>>>>
>>>> Is there a reason you're moving this code to the top of the function?
>>>
>>> When CONFIG_SPI_SLAVE is disabled, the call returns NULL; therefore, I placed this check at the start of the probe() function.
>>>
>>> ref:
>>> static inline struct spi_controller *devm_spi_alloc_target(struct device *dev, unsigned int size)
>>> {
>>>      if (!IS_ENABLED(CONFIG_SPI_SLAVE))
>>>          return NULL;
>>>
>>>      return __devm_spi_alloc_controller(dev, size, true);
>>> }
>>
>> That doesn't really matter since spi is not accessed beforehand
>> and it'd return a NULL if it failed to allocate either way
> I agree. I had also reviewed other SPI drivers as a reference for this implementation.
> 
> Do you want me to keep the change where earlier the host allocation was present, or is the current modification acceptable?

Please move it back

Konrad

