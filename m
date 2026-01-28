Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718730F53B
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617945; cv=none; b=NxoqVjjGVscwdtephKfxgRCk3pKhki1H9kf6LLrGgkXffft4BnXAacSkPZZ3gqJSzcuKNeOgupeVPx2/mAFAFznhzKUIVan7uQsM4vw42qIxY6CXbIRPquiyX+fMlUO619CgVd37ISkQ949eAsSRHo3L3zDGWsWXtPWggaSEJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617945; c=relaxed/simple;
	bh=2KVyNWIkQkrJdqOphMJW7+jbP6BykNPtdq1SsqqypFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGVJMmf53PutwOJ6R08PCfaGuZLim6pi7l1bY4IMHvsa2GW47JIElUi2wfkLEzM71k6juoJqyaUA2arqNwSErxOdtYJ76HFu3s1O/PswuwG0WqZ0s3CfdRkAxBBYGsFV5pEFzDOvRXbLuycZR5aKVeOY5rWhzmujgH5qWeEopjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KE04ZKZD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PJmikrEV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KE04ZKZD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJmikrEV"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SFNYg2811618
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 16:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTot7wm8bc+eEGywtGKUdiOEeratq7Vt53Auj5Idu/M=; b=KE04ZKZD87/3s+sp
	CFJGOZmev+/yZjW+OoM66B8XoltEuIn0k9XJU57RQlo9XqW9dazjEZLxncMlHNSn
	oXOa1wm7nuULjY8aTLuPJ4J2OEPsCSYvCMc6JfL0/BxXo0TdM1A2+bypuk0zVnvK
	ttzl++jLL2jF8sAXM5Zt4HOKNtEPtWu1mfcEVOiVRc4KlGK0BLAvJZwjHA1ggU5G
	xX1nQnvBlAWsOb1OZ7lov7z5NPqOeMpaPagagh5wFbBmBuAaupWXah1/W7VpJo0/
	7YjtS8daarDQrnWGZl/pIG2X7pCbs01FtS5SeLfxLyvRho0T1Sndk6rEJ33zaH9P
	CpJ8Tg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by6qbkedp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 16:32:23 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81d9b88caf2so5603434b3a.1
        for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769617942; x=1770222742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTot7wm8bc+eEGywtGKUdiOEeratq7Vt53Auj5Idu/M=;
        b=PJmikrEVcYZdBt3HQ/jfK0r/Awa19C3tQ8MpMz6WEPj1yB80sxpDcYR4jbQkkREG2x
         TzJ9mV/m7celSul1SQldHD7b9GnLfkNyNadizP713iIcVX4ciy9GQV8gkeiLtU28qV3H
         8WneEaNDmg2l4k0eevZmzbmrkeBxVjcMVjyuaAqw2zEm5L7kATNQSe4KpttwBSAKoBgI
         kHXYgZ1Pbpi1CyhSttdek9HIpx30Fr8jYqo9mqjXKvfKYgz0RnqO4SMWT7BGnkrRwGwV
         jbunFyjbn41EI3eKWmvSOU9nHihN6dsw67Ll4+5jyIea95+MGKwbl+SXhNzUp6Q6xxCU
         nZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769617942; x=1770222742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTot7wm8bc+eEGywtGKUdiOEeratq7Vt53Auj5Idu/M=;
        b=Zm4XEh4tAyONqadimKOvGJfOMO6YcVemD1kjp22VT+VrpTNOWoLXkj4dY98zNbhnkR
         BWRoaSvRXgAiXjzQY2kcHxS6Z7nVkAK0TGULUwHJEjM6eJX6EHxzNBKOILBiWjgt9p4f
         fE4oU8eQkYSHrAr/IqSeSnEefliXB2ZiI4H6ahRur5ahLaggttazqPcX0SsKl8D2gzvY
         EMZJNne4IigWavD75A1fNpqF8NlrpByRKGknd51g5L6ff9qHGr9ROjJexErlxnrA+feN
         TGFHEnMXmViy7MrF9wSq521TOHIKwGQMpdyK2cH6POWafg9tczS63w6kKi1NiIULdRp8
         7jrg==
X-Forwarded-Encrypted: i=1; AJvYcCW292orCj8FzJE1qK57g/u+uQHKP1hnegv00vTPEfV0msMbwioy6z1Wm7OQs7cxciO/joqjX9cz1fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMJXirHbzZ6lLwWNfQEJLXfyITDuuHN+Xw3+bkcN4b1vh1AS7
	EPDPX+9XlQ1Il9r/ZS0rjtriu4HR8aaFyxC7QRII8FXjIogDcHm6JLkvUcbFRfFnfwYFbNdzLyB
	EQ0tva+3WT35RgdpnjveYAfxDZWGWCsly6wIXDDN+cMHhe1no0HBbH9Y6K/yOWk4=
X-Gm-Gg: AZuq6aKQ1MALQKXRtJ1aQNjCuX4Ulv+KKuEXwgP0W/9FDbwJOCpOvSsoS1re04cuFQ1
	o3sO3Q4guAQNichvt/yXvt8pJRJzbow+K3suD0Bj2ivA93L8PZ8lVxnOR4GYiCbiyRuHhZ5+GKG
	LvG+y9iVgU0h9CKZ6cej9Pqow9PxCqlQ8R7vYe6CPX4vGkxaWfhvwAsEzUFsFr//i7vjmfhN5Qi
	e9gRq66fJN1k99DUFpuEPCJFqNiGDbO50OzAb/6lJAqdDpElLu76Lpd9EdOYkztFY739iZ9cVpY
	GFguztfVUKUAMDe3maoaSCxr2QHo5MuO2O2hK3roILXYvt9tsHNoaxXnyzC4/b8S4qct2YyHcNB
	nPwWSx4tH1hu7O3/jmBR0m3QXPcxj5/jQAC7HOwFJ7g==
X-Received: by 2002:a05:6a21:2e02:b0:38e:9e4c:ed5c with SMTP id adf61e73a8af0-38ec64052c4mr5152083637.52.1769617941556;
        Wed, 28 Jan 2026 08:32:21 -0800 (PST)
X-Received: by 2002:a05:6a21:2e02:b0:38e:9e4c:ed5c with SMTP id adf61e73a8af0-38ec64052c4mr5152041637.52.1769617940901;
        Wed, 28 Jan 2026 08:32:20 -0800 (PST)
Received: from [192.168.1.2] ([49.204.110.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a33607esm2647671a12.23.2026.01.28.08.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:32:20 -0800 (PST)
Message-ID: <bece7d32-5f62-4ed8-8dd1-0de9102648cb@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 22:02:14 +0530
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <847290c3-d5aa-45cf-a75b-ff119b608433@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z_f0v-reGftrgGDV-5hyGrADEEfWlDVF
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=697a3a17 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=hmzEZbfuJy6/QR5cQt8XuQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dd4507Samm2KvyETbE8A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: z_f0v-reGftrgGDV-5hyGrADEEfWlDVF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEzNiBTYWx0ZWRfXxTkox7PRMsXj
 FJV7BR0R+/as4E6+/U9bQu4ZNfaWKjCkC4r/RJtM97aJQq3aCCipL4eRcY1aOGQcEBjIvecvVvy
 /kU+oWyTTasz7uGtdMwH6v6rc9M/2ja16iKmnqSsztVeUVlfEHvJ76GWsf+wkwVt2FOUus2pQBs
 22BuO3ZrqR4h2EWPOjLe/JW90dm0fVNT3XpZHhF3vL8Hcy201iegL6qOeMRN223RkmxqHUn/otc
 w2s3BVpeP8mQQbCG3/lgqf4wGbOd1q+ajKvAfHCuPrItqnl2TlYs4lG6MiwoM/AzDyoZNoEqdUJ
 xpJ+S9RjPJA/3xT0wqmdfizdrQ7/z5jWHGNjmtmsaS8WHpRpu92hwr9+MyjqEu9VfGncKwedK8q
 GsGrb6yZstBPzGhyIaenZEe/k3vQY6oVpZncqcLE8+kIao7d+XUy1NXAw1VcZXE9FFbVF6SCLDU
 FHQ4q2wYAUKoXU2x7Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280136

Hi Konrad

On 1/27/2026 6:45 PM, Konrad Dybcio wrote:
> On 1/22/26 4:10 PM, Praveen Talari wrote:
>> The current implementation always allocates a host controller and sets the
>> target flag later when the "spi-slave" device tree property is present.
>> This approach is suboptimal as it doesn't utilize the dedicated allocation
>> functions designed for target mode.
>>
>> Use devm_spi_alloc_target() when "spi-slave" device tree property is
>> present, otherwise use devm_spi_alloc_host(). This replaces the previous
>> approach of always allocating a host controller and setting target flag
>> later.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/spi/spi-geni-qcom.c | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index 0e5fd9df1a8f..f5d05025b196 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -1017,6 +1017,14 @@ static int spi_geni_probe(struct platform_device *pdev)
>>   	struct clk *clk;
>>   	struct device *dev = &pdev->dev;
>>   
>> +	if (device_property_read_bool(dev, "spi-slave"))
>> +		spi = devm_spi_alloc_target(dev, sizeof(*mas));
>> +	else
>> +		spi = devm_spi_alloc_host(dev, sizeof(*mas));
>> +
>> +	if (!spi)
>> +		return -ENOMEM;
>> +
>>   	irq = platform_get_irq(pdev, 0);
>>   	if (irq < 0)
>>   		return irq;
>> @@ -1033,10 +1041,6 @@ static int spi_geni_probe(struct platform_device *pdev)
>>   	if (IS_ERR(clk))
>>   		return PTR_ERR(clk);
>>   
>> -	spi = devm_spi_alloc_host(dev, sizeof(*mas));
>> -	if (!spi)
>> -		return -ENOMEM;
> 
> Is there a reason you're moving this code to the top of the function?

When CONFIG_SPI_SLAVE is disabled, the call returns NULL; therefore, I 
placed this check at the start of the probe() function.

ref:
static inline struct spi_controller *devm_spi_alloc_target(struct device 
*dev, unsigned int size)
{
	if (!IS_ENABLED(CONFIG_SPI_SLAVE))
		return NULL;

	return __devm_spi_alloc_controller(dev, size, true);
}

Thanks,
Praveen
> 
> the "main" change looks ok
> 
> Konrad

