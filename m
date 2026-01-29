Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008B8387358
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769686952; cv=none; b=sJEyaRuZHcIkOVXW5cVS+PhIxubb97bYSXsiBt+vO/M416a4QVX6GdGsS/VwmlMfp1cUeebfLEQPGlIcGUqO/azQ7We+ux8uCAgtV53o+1VELfFuUjLZ9SIhczMjY+orFyxGdxpEV5uq/EWMid4g9js31klZr+mHceDNEn1yazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769686952; c=relaxed/simple;
	bh=HMqTk7Tws8eXheDRY8AgZidLkId47RYldm3Bykauok4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYJclln+cpTGZdp3Knb04KnPb0pQGhiNI7XVzuGXYvnUYQxgNg57s+O9uTpkWKtWZSefVBVQfqt39CVHvvfNyfeu0FqlnTfn0ZT/ENpry4QUg5JI1do9HmbKOFp7zHWSUoOZroykknk9KY2yEeX6Di08phJHn+xA1vl/eBLRF/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d1pWEYYg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iNEQ06uE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d1pWEYYg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iNEQ06uE"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TAR9QH2505699
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GeSXX6wKleWl5Z7X6sxwKQnp6NH3hoPLooOb4T1lgR0=; b=d1pWEYYgCn8oTbhQ
	E4ozxwgmCvpemSFT9m3IxF106HvMXweUNYE9YaB5qKVhoTbY4aEpWzuQbGn8s0CI
	k7tYra5AXijldS6xF1R94rgW5hGr3WTD/Am0WcJ92vozrlgHMMrgd/5/RmmzXI07
	P19VY7rPK1dPOAaEM+j8L07s5uReVgygwFTjAFcRLC0HjFyjhcfyMYG6FqML2ucx
	ZIjDJoMcxd6pp3k9ojtu/zaROnKJ1aqg7Wp42HpBy4wDUWpSczKeqSlw5xwUBc0Q
	PFAzjwPa6SDGniGWcfevxarAWkFOtRbGHrHZBc6kzx3SUEJsT/l3312j8n7h8+gz
	mBVZnA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c05tbr6t6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 11:42:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2fdf3a190so14662485a.0
        for <linux-spi@vger.kernel.org>; Thu, 29 Jan 2026 03:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769686949; x=1770291749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeSXX6wKleWl5Z7X6sxwKQnp6NH3hoPLooOb4T1lgR0=;
        b=iNEQ06uEfOEx3Tk4KQE9pdIuHICPkxGexxC277bKd6KiAKLbrX7N1Q1/aRZQv/eK8H
         jfAzUPLCadgaoNiebW1kCTll1EuGj3SJ1aS5Vl7j7HqPQ5v+eDfVfuKHsSQtRsx3Wz+F
         Ayloy2hhsBFy3wypl6a9ZP9TI0b/VLWH6wXl2qGa9r0cexsdXp8LeOuEveMg5jWMeHzU
         1lM1pwnLNJGFSF0kSLuHHSta+otar8hU53FqAH1hee3ZyWCyj3QTe66B/zmHQ3sqif4j
         6oAoKEGyH2tNIlXHSobfopL6Zu7CcCE+mDNHa33Zj8sxTe2zqA55PhXRxyrGWVEHiEaD
         AN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769686949; x=1770291749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeSXX6wKleWl5Z7X6sxwKQnp6NH3hoPLooOb4T1lgR0=;
        b=lVQP/ThvZrjKNOkRdxpq1m1UbCYfnL2W9+tiZQ2nEXt20Aciv+GqAoq999mzedacYq
         sTcP9VD06/YECgxfnE8B0MDZKKdLe2J5MYpcWD36t5k4G418QT7xgmOuO98Mx4gX4N6e
         EFk495iCeds+oVTheSw+Du+8WgSvhdCzTA8Tf7hrbEaMS0u+m5BkSFU/5Oj+XH2FQu0W
         jB4ooHB9Jk8/yvsE0YwmMQy3JEdmrBr4HNMRw2DiDr7UB96ipeW/ZejsPgCOpb1Fb+LD
         Nv/8W66q1roUW7jauwT3V2Jacrs6NfeJdKxoIhrligWKUdW6U59UkgpghdjdRd2oojNb
         OuUg==
X-Forwarded-Encrypted: i=1; AJvYcCX6oZqVRiHrp7khvKeDz87p3nnnYlXBy6r3tKnUbt4FPYRYCaPphZlPtcMoYcQhhFAPYTYrfhF1xyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywid1b2hqc1eLLw9vOV9KmUUzay/yPkEn53w8FRqkEHl9pVqGmp
	qeYVFDljKDPxHttAIHMVRdx8/fo+QskdGRbw22O+0M98Lh6ILy6BgLC6RODLVf+eJy8lxsnTeGc
	K7tedgk+jPFB5EUxPkg3++zDmoxUEdmUk9/AUfKeN6PnYkiWjjSf4q53RjXQbTmQ=
X-Gm-Gg: AZuq6aKdgWLBlqeVJTmCmd8K47aXkati06byCjykdh56AFSdPQoCaNRUJ4Zy/iREn5u
	NHdvNs/023qdIPOVTrWCwxeSFAObB6XeTTyKmTJmK63EyjrgF73jhj9uQRUe1xIt3T3H07eX/Eq
	/vpvMJYOsQPMLNyvOemNU+lm2NSGv4YrwnCFvTWYtXfvcTML+KhGdQXfj6CM2UIpyIQ55WEYn8u
	80wuGPE3HVCzuIqHtnA6FYly/HBk9MlKo1pi5nFFm2qn4RkZDdtTsHXEkYIv5K0p50aPVYucBEm
	FxP+ulALJsxzG6/Cx00SGh6hMxSskg4p4d/vTsYvmgcZk3nwouchFDxi7jjE//XPvq1yK+OyIT5
	KlCL28aBIZgbafI0zA/67qQHJXS0V53rKDngYnoq6cfjzWGxjer9Na3Bms/ZEq2jwmE4=
X-Received: by 2002:a05:620a:31a5:b0:8c5:3892:a554 with SMTP id af79cd13be357-8c71ad00279mr318781785a.3.1769686949269;
        Thu, 29 Jan 2026 03:42:29 -0800 (PST)
X-Received: by 2002:a05:620a:31a5:b0:8c5:3892:a554 with SMTP id af79cd13be357-8c71ad00279mr318780585a.3.1769686948838;
        Thu, 29 Jan 2026 03:42:28 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8de8c93c11sm59859666b.28.2026.01.29.03.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 03:42:28 -0800 (PST)
Message-ID: <d9fc3b0c-7fe7-4845-b55d-ce6d0053f48d@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 12:42:25 +0100
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <bece7d32-5f62-4ed8-8dd1-0de9102648cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Jl7fjxZPWkfhLsjyl20p0b6Iavt-ZNL5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA3OCBTYWx0ZWRfX+Azkxfxo00qC
 0XVOYzPJg5V03FSWfbg7Ue2K3LkFZ113Nwh3BIYV6d6IPi0zz4Iqa3ZIEWDBJL9SzVSPa/SfYjs
 /FhBoJlstmQndyCDXpHFeZzaxT1qQuIgxnuCvfZiVRB3E5KXklfcM1Se1J6ENGAponHMqFCRhQu
 fMH4wyo8T6wkDwaR4FLMbQMqFLl6UbHmCifwMy0NnIpvec8dBS1cfnEmmbAUf3dtYAPiuLHOPEG
 uu3q6aKMgGUdn2DwrzfcJbC59jSAJFrhCLh8aJNnUJwCFETi47kYp6S0Qi048sv6O3Uq06DdxTX
 bGJWMg6W98jvi2Uw5ecQ1snj9TMxnnL6eTA1VM5rRh5es59tJnTEMOaVhNb97EUPvAJB+itJKJd
 PCyTLCede3/lPQCA73MSrIs1GPRR43sSdAgJdwKozKRatKB2riz51kVrHocvIcYalpZpYfBYO8D
 AG5NFZOiInBME3ZsY4Q==
X-Proofpoint-ORIG-GUID: Jl7fjxZPWkfhLsjyl20p0b6Iavt-ZNL5
X-Authority-Analysis: v=2.4 cv=betmkePB c=1 sm=1 tr=0 ts=697b47a5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=BLqC3yjj2PmRytsJ8UcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290078

On 1/28/26 5:32 PM, Praveen Talari wrote:
> Hi Konrad
> 
> On 1/27/2026 6:45 PM, Konrad Dybcio wrote:
>> On 1/22/26 4:10 PM, Praveen Talari wrote:
>>> The current implementation always allocates a host controller and sets the
>>> target flag later when the "spi-slave" device tree property is present.
>>> This approach is suboptimal as it doesn't utilize the dedicated allocation
>>> functions designed for target mode.
>>>
>>> Use devm_spi_alloc_target() when "spi-slave" device tree property is
>>> present, otherwise use devm_spi_alloc_host(). This replaces the previous
>>> approach of always allocating a host controller and setting target flag
>>> later.
>>>
>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>> ---
>>>   drivers/spi/spi-geni-qcom.c | 15 ++++++++-------
>>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>> index 0e5fd9df1a8f..f5d05025b196 100644
>>> --- a/drivers/spi/spi-geni-qcom.c
>>> +++ b/drivers/spi/spi-geni-qcom.c
>>> @@ -1017,6 +1017,14 @@ static int spi_geni_probe(struct platform_device *pdev)
>>>       struct clk *clk;
>>>       struct device *dev = &pdev->dev;
>>>   +    if (device_property_read_bool(dev, "spi-slave"))
>>> +        spi = devm_spi_alloc_target(dev, sizeof(*mas));
>>> +    else
>>> +        spi = devm_spi_alloc_host(dev, sizeof(*mas));
>>> +
>>> +    if (!spi)
>>> +        return -ENOMEM;
>>> +
>>>       irq = platform_get_irq(pdev, 0);
>>>       if (irq < 0)
>>>           return irq;
>>> @@ -1033,10 +1041,6 @@ static int spi_geni_probe(struct platform_device *pdev)
>>>       if (IS_ERR(clk))
>>>           return PTR_ERR(clk);
>>>   -    spi = devm_spi_alloc_host(dev, sizeof(*mas));
>>> -    if (!spi)
>>> -        return -ENOMEM;
>>
>> Is there a reason you're moving this code to the top of the function?
> 
> When CONFIG_SPI_SLAVE is disabled, the call returns NULL; therefore, I placed this check at the start of the probe() function.
> 
> ref:
> static inline struct spi_controller *devm_spi_alloc_target(struct device *dev, unsigned int size)
> {
>     if (!IS_ENABLED(CONFIG_SPI_SLAVE))
>         return NULL;
> 
>     return __devm_spi_alloc_controller(dev, size, true);
> }

That doesn't really matter since spi is not accessed beforehand
and it'd return a NULL if it failed to allocate either way

I'm not sure this is a concern nowadays with fw_devlink and
friends, but today the allocation happens after we get a clock
reference, which could throw an eprobe_defer, which I think would
cause the memory to be de-allocated again, wasting cycles

Konrad
