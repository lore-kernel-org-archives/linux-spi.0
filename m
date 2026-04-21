Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8ED3AD52D
	for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2026 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776764791; cv=none; b=X1TGatnEFJ4QMyAkqf2vzlqotBtkMfEp/cYfeNfgicx9kYiUonclLJOm/LJdWP5ofb1FbDh49+w72uOHloz6BPU888a1/XgN6fLvAcHt8cbrRu0dwjm/6XXOn86eQOWE6CLVzm+nig10UJmXrORmTnsp1vGnRTaFBtPYhRLywoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776764791; c=relaxed/simple;
	bh=mvEHAZ37oCPDXOuYiqAbdqn9ee2W2yf0pq21pqqdlpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSZ1xe9ubqfCwL1/02dsjqAI3lIDScjDJn7Ad4A8dZovFGbmOYQ4c+AlxQo+t+T/ZGLe6Eh8MuTEDVhQGw3mbv9I7w0F9wspMpKaEeDXA9ACTQ6aJyURBSJWUcf05eIGSvpD1eSYs2cI3bgxLVH1ueSaU2DZ/njFC69KSx1RbhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eSdawfXp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LgBwCxS2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eSdawfXp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LgBwCxS2"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L9RSrA046227
	for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2026 09:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+Nx4YovSNFz1U/AoUNwYoROlzNlXRuYyoJDe9nhlv6E=; b=eSdawfXp+6a81AiJ
	mOkVjFEs8pddnjmHP07YDh1lqqftB202ilCRxoG2ncVSkQQWwkhdebzTO/BufInI
	lFk0CEEf1WJ72o8XxMHc+lUflDaSycTQmTB+jq5ifUqv0X5v98Z/4Moo/Nkd0Vm5
	bNqoIrYFray9dy96Pqg4k9jioDKcFadqAvNqvOYG2SggJSLlFe88DdCbgV7rmUQa
	e9we9B3amW4qZqhVQmRsjbG+L6UincjPX9mMPBj91X1w8b36CWU52GpRJcvY53th
	UVVRS4nNGb7e9jGovCrpRdwwnhNbBcV/EgLZo4M3RkwWcjv2jXPIF0JITfR+ritr
	KVqUxQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dp0y1sd7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2026 09:46:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eab57f0e8bso33462385a.0
        for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2026 02:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776764788; x=1777369588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Nx4YovSNFz1U/AoUNwYoROlzNlXRuYyoJDe9nhlv6E=;
        b=LgBwCxS2tv/PPgm8Ui0zLMrvgZ8HV/rNodkKZCQy2BxPzOAGCi88kfgSlUxn4G/gpT
         RGuge4WAkBfl7XjwK2hP4WAA9xk94uosnAHoWlAnOZ+Qh56iSosfgph0HVppaLYOKsdE
         bx/SlrIviAHRCZJlyDpBWWhXpx4rCeEIcxfV6fQVmmZFl9Xn4SQ3++eajvhdFPJOP9eT
         6osgGZWKStNxm0niyL+YWUDKaTKHCK+dPZQXbt9KHaC5mqVHaZ0O6zz2BhXfhBdJHfhH
         J9s12UblSySm5wxFzgqpFuyDnaeAdx9jLizn83w98hf79NCOMnPHERthI/nom1ciFdVD
         53kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776764788; x=1777369588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Nx4YovSNFz1U/AoUNwYoROlzNlXRuYyoJDe9nhlv6E=;
        b=qlL5ZcTtuHULB9MO2bJDNzUxJxVkXvqqiQQds9Fa1IdU9kDh+aKXU5MlKeKLb4i9/P
         XbgwEcAmzWViesY1y4vo30F1RjOq9txWYq3EZWfa9AfmZDfMceo3wha41u7VvKFLxwrI
         mYKJO1dixn19E/bcHc8wspss0/PrzZfFkcQ3g8LnR0QPl3C3nPmByiHMsH+Ce+aKJtak
         Yeow99sEs6BoEo0C2RxQzNCrq+B2R4Rt5zygnH1RDhecCXkg7Ej2Pu5H17Pvjsz6uuqh
         t+Y55LYYXJS03Q2wrgjg4/wtxW7xaorXZFoaK03b7naFG+B/fTbU7KvVGd9dexMfvShW
         1b/A==
X-Forwarded-Encrypted: i=1; AFNElJ+bm8rAnmgUAohvRqFeuA74u5us9mnhDrq34aGQZRI6a9o+CNT7FXgM2dQ5gwTe07iiRr6gI9UPzwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABDf8BVYndM0Xyqnl1gD1uvQ2GjChzFy0nUMBwEi8OA50pq/e
	f4LorINHqE9xsxcfslAF8EM0vh/9CkLY6e8IvsFaBZqcCMJeg0+R21t9s/ZA7WurGanpJ8lMHvO
	VGzqR2Uz+nKX2JpQKiB5pcoXx2n48UGi6iR6vABK2o3xgrO/8kdt/EDTUHD1zAfk=
X-Gm-Gg: AeBDietFo5ux0GXZqqQTSXj4u/m+8gaa+AY7E9+J5d9XIQMPa2TEX223o8P6bKAihx5
	Fht4S2D0FC9TnvdwqHtRYJC/QRAlRRXh5bKCkNKS9cjSSVjXDkA/OHDT46E3fI0Jr+1ewGQCkta
	Isf1t8eBs2/PE1p8KN6C9DgYcUaQTaSX3E7VdGV8Kp8DV57IreEs4VBnxuGxGHwAZRFmHpNl/OS
	FkHGO+lLMVBYJtRAjiG75zTKSqqyEmd901zg0FtYUlCuSUVPCyg6Fzm100VmHq8/KwwRnfod5xq
	iPvC1cSJ7/PKysOnqukR4eRGqiYQICglfZqYBD9wq9mmSlK1CMve5MusC6e/roRxcJwbWa7hVop
	oK0mpiM9VHOYE0mPWTLEeMCR396MIelOrbasyiHBKtJ66FhK2Uj/ZCTS10zZb20Pk6oxbV4qdhR
	YNo8uU1MNVEpbkDQ==
X-Received: by 2002:a05:620a:458e:b0:8ee:f43a:bb63 with SMTP id af79cd13be357-8eef44a05b2mr36850185a.0.1776764788446;
        Tue, 21 Apr 2026 02:46:28 -0700 (PDT)
X-Received: by 2002:a05:620a:458e:b0:8ee:f43a:bb63 with SMTP id af79cd13be357-8eef44a05b2mr36847685a.0.1776764787906;
        Tue, 21 Apr 2026 02:46:27 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c480e18esm2575163a12.10.2026.04.21.02.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 02:46:26 -0700 (PDT)
Message-ID: <20cd0d36-eaa4-4ab1-9fa6-37d43887c7b8@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 11:46:23 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] spi: qcom-qspi: Add interconnect support for
 memory path
To: Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
 <20260420-spi-nor-v3-3-7de325a29010@oss.qualcomm.com>
 <e7873eb0-bfcc-4ad2-8016-17b0db80feea@sirena.org.uk>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e7873eb0-bfcc-4ad2-8016-17b0db80feea@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=69e74775 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Ktr-gnuM6ESvd8fC0OUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA5NSBTYWx0ZWRfX9MyWzi8rmctv
 XctLHynVuXHaarYuWswoU2WUoIeaR5iv6yP9z109jad2gwnOGNDhf6CFyDjF6gCB+VAAKVVwTIW
 CnhyPtk0sexpqPllLpj3pf6Qp97mUd16Y812A2n7J9BcqqB2h54NwoISTlkrQuM5fuvOxitwTkv
 41LYHoHuz9OXjk/2YgqdbNW71ZbZOhK7yLjb6tTcBdUkpMBBOPkwkdyATpP/yrj5PnbTH+aKfvE
 buNWYTlchu6xiRgZ+aC6Uc9h+aSVEFo6EVHesobGB3QkReTYQ66oAD3ge+ENZqQNFqrsjOhFQJn
 0MpktYQ0gdoXQnNn27Peh99Fkis50MNsxKHJ41iVVEYkrEeBVUB5KOlT53i5pMiS4bCV5f0+3mw
 yY6LLxveuw2x3KzwqNxlUS0JnYsRPqW+Dp/VR0OSlTqjy7xQxFVgRqj4u0PnMmpMRIjmBN0tano
 8B7t/6yNVvKF7W/MPoQ==
X-Proofpoint-ORIG-GUID: F17mNwWAVaByUmcQGMgRge4uNG8ULNje
X-Proofpoint-GUID: F17mNwWAVaByUmcQGMgRge4uNG8ULNje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210095

On 4/20/26 6:44 PM, Mark Brown wrote:
> On Mon, Apr 20, 2026 at 11:42:50AM +0530, Viken Dadhaniya wrote:
>> The QSPI controller has two interconnect paths:
>> 1. qspi-config: CPU to QSPI controller for register access
>> 2. qspi-memory: QSPI controller to memory for DMA operations
> 
>> @@ -729,6 +737,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>>  		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
>>  				     "Failed to get cpu path\n");
>>  
>> +	ctrl->icc_path_mem = devm_of_icc_get(dev, "qspi-memory");
>> +	if (IS_ERR(ctrl->icc_path_mem))
>> +		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_mem),
>> +				     "Failed to get memory path\n");
>> +
> 
> Does this handle missing qspi-memory properly?  It's not conditional on
> the compatible so it'll run even for existing devices.

Ohhh right, I glossed over this.. looks like we need to ignore -ENODATA

Konrad
