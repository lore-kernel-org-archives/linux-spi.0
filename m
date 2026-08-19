Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C148AE38
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157766; cv=none; b=FWGaYA/3eNYvAhjpSAulJdfoDT++GaA2kbM3zJsRplLgVmV1jKFMkBXN879YZyp0+AvLQC1F5QaKlUaszif403ARNAyqLNXnBBBniaCooP/VJzfwZwn/oHeaE8YEYmoUp8unUyzBiz2AV5z0JJ0bsRly1TvUUOCJvCmAKlxlxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157766; c=relaxed/simple;
	bh=dnnJsqU4mxv4k6GlZLXQBcd/tcabPrF8oyB8KzBmS/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3/BUEHL1aP4TfXygqhzLOkzJo4NeYlsRIrV2jeh759NZ4gvRTWpUwUQvOrL2hTEEGCH71oiBIKL3J35zpwMV7qDQ9IT39gxN/JdfErgEWOTFqD5t/7kDBZUAJo6G6m2Nq/wcL6lgz5/wQkO1HoBjbKInbqnHRoj7okl1ngciEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AuzZPY9+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V7GJlQfq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AuzZPY9+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V7GJlQfq"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEbQaP067627
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 16:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qRihAgXtPmtMUikBEdmJ4hML3Ufb8kUSAwFw3nA/UW4=; b=AuzZPY9+vKgh7Tdn
	vYf+rDryj3mhfQwdxiDxsygpfGYWymmAP02vTjmSl+uBQ92np7H8OOrs4hXg8hT9
	p8JQoP1nNvOwl1xvsEBGvz4ZTxcr1mbNhDetYjOuItIZ2syVc5KVP+f20dmshNKE
	anAfp1G2Zxo5g0Scvw1YI1LI6AC51irdDCMt6d+VcNZOZqzpK/yuAJPBb5+0ppni
	U+m+DBTMu+3rv4UAZhdK2Tnfwe/otXMtgKkPVjFxcVKq1EyYqMuiXflBRlPOz27I
	K+vMkpbDog4XfhxSWCh5FYQmtSw9v92xegr5OfZbIxxaJeD/qmwyD5P4A9ycmwTK
	C6ZtBA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e5d0rn8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 16:42:44 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84870e7f498so1135893b3a.3
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787157763; x=1787762563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRihAgXtPmtMUikBEdmJ4hML3Ufb8kUSAwFw3nA/UW4=;
        b=V7GJlQfqBniUVLyRmuHYFQDNiNHB0ScTGUKSb+AjUwfSrNuOY+1YOs3fFTNQx45ou8
         FaLLcUzjvuKvtYNZOWZlwwBXp56SDfrM7zzzF3bQj2l+O4MdWQX8hiS8PPakHlzm6C+L
         RDKYzcdUzEZz1tbJ2gI8P8S0u6KykWUc8YImoRcN1AaLVKdv52Oz6JQHmYPo2dupEXvu
         iM5zUEWXrDLqBaYX50Sfa7/cPchQJcEkEiaYwheAhqNP0C51f5opPuc/JsSWsaIFY4ep
         tVeq8IatXVmlmq3ej5XJxVP6B4K5DTd2gW6ACLtWEwsmSijT52iDH0aqp1uHVdudrIJL
         Zxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787157763; x=1787762563;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRihAgXtPmtMUikBEdmJ4hML3Ufb8kUSAwFw3nA/UW4=;
        b=FJK7ILuHoMa3b0m1jjJ9/9HRzCklnixsvSdWyXcrPnJJjyYl2ULFE3IH/vBfySzilE
         r8Ohl8WhieE61RqMfW/VshI4ycvqZSu3mPFeFmWA9uQnWosSpGEYVWLQ59/4K46p/7TT
         /L3RVKTNFO3uXyAKqd6mz8gVuhiJ8TPwwaaXG+dq3lQZfSJd/P5HsSW628/HnJercHcM
         PBpfVaU16pcFQ2HYqmSd+DFwuzv7eSKtmLE5YfSA3afkimndzRkygNvklt6IKMO0SqSw
         Q/uB/q/EweVKUnOUu8C9XyvwXIMDYzKN/+40gpZ7XzVGuFkGunIECNoB1EivgBhJt+4P
         v6OQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUGgiGZbGKacGgm3XneBAliUJeIZixHc/rWcqE1eLsRQRDg61Pymk6uX4MGkTjlA0dtGQwNvVlhgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUYC4dZnfkE4yC9airdmjeUhwwtmLWQk8HRvzp8EUyBBKxBFVa
	cN/ZLCO9a41NBkGviTK+4byOJOzDf8v7Kq1Ehm/H7YhCaglDlYLqmr/x4mo6xjIeJA3sZBIe9Dm
	EmMY8uNbs3mWUGRB49ykCYY5PDVmWO30RCzksGIOwOkp3anv+n/eNOCXvLQ6I620=
X-Gm-Gg: AR+sD10xUj7UDHK9cBiB4OdViaXaJjCGy/KD3obuCGaNyKkirfye6SLcgL+95EWl8OK
	RDfnzNOOpzWaGRqGtwgYyIMKkYump5+k/m6PjNnG9Inrap/Ep0Tgs7ngWvxea1BsnLLkyIq5SUE
	G3ThJ91fb8DoiElY6UzRNi4rgSW041lM3XyYD+cCGhdcR7twpM3Vfavl9lKpa6OuIfYL6nN599M
	VEaF4RhyUKrpqUAwIxXduBYKF8wCA3nLcnKVRC5aTM9H91PD0Hi3Yl3BejMB/6TWJ1EI3JC7aRe
	OeNe909McXLB6VuzrhJYfKELeQYSjql/SIfwtXUy6WzQMUEqaSWc67/tg98zX8IyMN97dEJgTvL
	MucCqVk/CptxVwSDPKkVLBMc5JgYUR3v4
X-Received: by 2002:a05:6a00:2e9c:b0:846:bc81:3e29 with SMTP id d2e1a72fcca58-851d381a661mr9382990b3a.2.1787157763455;
        Wed, 19 Aug 2026 09:42:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e9c:b0:846:bc81:3e29 with SMTP id d2e1a72fcca58-851d381a661mr9382902b3a.2.1787157762897;
        Wed, 19 Aug 2026 09:42:42 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.111.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d33b635bsm881060b3a.26.2026.08.19.09.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 09:42:42 -0700 (PDT)
Message-ID: <15e37bb5-db13-4c09-b5c5-a9e92030eb60@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 22:12:36 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com,
        Krzysztof Kozlowski
 <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-0-e1c9e0dabbda@oss.qualcomm.com>
 <20260818-use_gpio_to_notify_master_of_spi_target_activity-v3-2-e1c9e0dabbda@oss.qualcomm.com>
 <09f10e30-f613-4a22-941c-1db63b190186@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <09f10e30-f613-4a22-941c-1db63b190186@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzMCBTYWx0ZWRfXxXCQkul+mSPm
 YIS6tu3ILQi2FHh+e/IvbGGULHLuiETaAacQ0e+uK/0AWWp069mfepa3Kn1Dqmjp8lSuFYi8FA4
 Le3NlxKylMAZLldaTj6dOVNW/PZ8xbA1/NO3/y9pOwUUQEVEPa2++BOZjnplCdMcJp2aFZDA6my
 3wrAI6iQ+k/HfCgWEid1haYa9vfxGFbDcj8UX9IUWwmGCOH0wPo/nemAW+RQCcPjN2/jGpyp0NX
 CeX1UZXJ+fiqI+snIFvw7a8+63avOQI6K1nDK3QEOpd6MfNJmqkuXwJgRL8A8Q7eVBzu7YNISPt
 NL/rKtlPF9idGh0r8ROo/Zq3w1iqiZ1aL8vDZIOC2tinl0DXQCEr1GOY5ZcrDW+xC0TeoQi5JZ9
 A959h5cqewaz1choGDMOfi7INvk6JjaxxIqdcpEs17gO4rsx+EPO5ktTwjQCNKikjjwZAmfFps+
 BC11ZV22F1JYxQ5cEZA==
X-Authority-Analysis: v=2.4 cv=cuOrVV4i c=1 sm=1 tr=0 ts=6a85dd04 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=HCveIaAj3rmBjkKtjFsTTQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=C9Icw_Sg0KBB5CD6VC8A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: bmeKjFIX1mt58118wvU4sbxgrmImVRxS
X-Proofpoint-GUID: bmeKjFIX1mt58118wvU4sbxgrmImVRxS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzMCBTYWx0ZWRfXzsOqNYKWKj1R
 RWszEGCmg9sWIHgZTvzeRBiJEpqn5rtx3aFuDmXvPFgNiJcHvmjrW2IyHD2aOaqA8aLBQEK2hTN
 UH6draCMg/iAXoAwbvlM1gtNyYwZZ3Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190130

Hi konrad

On 19-08-2026 19:30, Konrad Dybcio wrote:
> On 8/18/26 3:38 PM, Praveen Talari wrote:
>> When operating in SPI target mode, the GENI controller relies on an
>> external GPIO to notify the SPI master about the target's active state.
>>
>> Add support for an optional ready GPIO that is asserted when a target
>> transfer begins and deasserted when the transfer completes, is aborted,
>> or hits a timeout. This allows the target to explicitly signal its
>> availability to the master and ensures the GPIO is released in all error
>> and completion paths, preventing the master from observing a stale or
>> incorrect target-ready indication.
> [...]
>
>> +	if (spi->target && mas->target_gpio)
>> +		gpiod_set_value(mas->target_gpio, 0);
> FWIW it seems like the gpiod APIs can eat nullptrs
Oh, let me review and update.
>
> [...]
>
>> @@ -1131,8 +1144,16 @@ static int spi_geni_probe(struct platform_device *pdev)
>>   	init_completion(&mas->rx_reset_done);
>>   	spin_lock_init(&mas->lock);
>>   
>> -	if (spi->target)
>> +	if (spi->target) {
>>   		spi->target_abort = spi_geni_target_abort;
>> +		mas->target_gpio = devm_gpiod_get_index_optional(dev, "ready", 0,
>> +								 GPIOD_OUT_LOW);
> Is there a reason for the get_index_ variant specifically?
There is no specific reason. i just had choosen with index.
>
> i.e. why not just devm_gpiod_get_optional()?

Yes, we can use it.


Thanks,

Praveen Talari

>
> Konrad
