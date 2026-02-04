Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C130FC30
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223122; cv=none; b=C/gdVb1kYS2H7mUmzuYRyR4iGXHUY+7kr5yuj6hcc9ZmQN1w06OZuWGrXuUQpqPTjBOVRVlmekbQz7mTGe1T+fUOixfb6aoAXu0Hx84xqvwlSCUmqWNFaBUubJOXB+1U4dkt5DW/mg2L8r52VC/ZYyNnbYpyJHJ0YqS6ZnRy7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223122; c=relaxed/simple;
	bh=vzkmU/xUbgH8k9umSTYH1lGGxteiG1ygk3kWIhODUKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGuSpKlo0kcJxuGB9cRiY6EXKGNYSMcs9xI3pDB/OdzqIvnDehSg/OAqCN4FY/G6Xqf/GNEp0RffycGP0ZT6hgjqcRjjMKdvxS6l0CvFoHQekw7UazNsPoqlOUjYiSBAP9qE6HqckObrNfwag8CWRxxCzs9qLdP+SNeICoMGuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQK+SFru; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BiVh19d7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQK+SFru";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BiVh19d7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CISme898953
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 16:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jsCZryUoKWz/GFMWTjKZofaphaorw+gC2G7jmNnM19w=; b=DQK+SFruy/Ai18Sc
	koriq1TCz9tBsTm3DTH70Yuhm2nGvJ3g+mM1cQHasFg6+Mgn7WA7d6WbMjc3tYLx
	/PLGYhWCsMuVZU+gTviO95uM9zoqwXaTDdHBG3X6U9C+UANAg3NT/yn17AK6HusP
	v+68Vcd7v9ks9OOVf+bemnHPoIJJluZDsHlIhh0vDb7pPrGLVv2N6oDi6pXey5x4
	JW2Yj5IgamAEJjo8nMJsPOU3GmpMv1jRiq4jPWke7G7lnbdXal7GbPnAGKgAZ17E
	UpK7DfHckY7owZqco2Yh9Ip8ryF0DCqqC1tLoJCIPB1uIPzPA0MVdh7Jjz/hpnJn
	lj+1CA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c445wh4ty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 16:38:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5029a8193c0so97801cf.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 08:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770223120; x=1770827920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsCZryUoKWz/GFMWTjKZofaphaorw+gC2G7jmNnM19w=;
        b=BiVh19d7rLeTa01Qyb6cgNRjGaiMAh+wKj1yM6petq3Juip7P39lgX5hhePwQBIIe5
         0/ubkz8Wu4gyVRhDzS9H1c2C593erdnv1Bn7oXqKYZFTWyk9LaEQcGdRho0ElHe3QpIH
         z8c27IMIXEcdWHg0RzIHjOGN3pzvkvFv2/TRB7OjkNIXkbgKgvYl8RM5PAAPbSmjFoQI
         oocOiAa+xIBCM+d30tkV6yKmuFt3Snvex610jsYbnH0ym0XO30jZcHfCcyhrBjasw34t
         xV/0yHtICdmyaaTLqV0w2GRTDFkkts55++4Lm+cVJpXtDuNmuJ9jlGdQzUqYWUjyPaxm
         Yxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770223120; x=1770827920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsCZryUoKWz/GFMWTjKZofaphaorw+gC2G7jmNnM19w=;
        b=F6jS1d8tEMgXpwKCa99UgLfwtEq+DMhuJzqkxj1ZZC9dhD4lxUcDPlQhNpyeDickrM
         REVh5/MfxFJ437i7Hu24pJ89JQ6B1j/SUWSFF/YOjVfL8BRaIo/iQxj35n2DgJyHevDs
         hYjob1B9PDty5HMZSU8Tax80XXEjcGHUX2OaSfaAPUCfd1UKTWcZrRdN3abt3EvmF2le
         s6QvRKSl+F61epcWkQh2lq5QUFlyNAb7Flb+l7+E82MNFE1QZvd+2sET8sjpAIvt21AU
         v19ibkmU47WXYDf2H+37cXNV4tBeL0jPt/XT5ugEmBe+eCjZUM/04iwwDPNGYQ/tMzeC
         vDXg==
X-Forwarded-Encrypted: i=1; AJvYcCVOPWciAoXhw6hgQakMKLhP6vI3A3oAhQxya+zrkmTEqb6ovkCS21ZZ7JXVHcOj+Ceb4eZOKiHOjC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5IXxtj17ZSn9btWt09iC0I+nAlmLE74122KV8J6I19KB1Yc/
	U5j41tPNJ7RXiZwo6O+RV/q5fylpMP+8SkKzZ/BsB8uZUZHfSi+QeGoq+06Vyg+TeL40jqZdJ+k
	l1ZJ/l3DY48i/8vHj7IIBAwFqTInFMHtO9P9ONkh1207pyy6FzJ6oNJG+c4NYKs4=
X-Gm-Gg: AZuq6aI+OEqmNstM0Vc+VsRzX/rLD6k+W/Uk9pvk6mXZYlT7HioHVbUpLi4KX2s895v
	xY/ylD9cqG9p3k64UNtNo9ECRDEx1yZFQt9hiOuCLJpat5GqrWpJcjomhtCL4HjazK88AOuXdUo
	yVgoQSLzTiRmFbczP/NNFd43pCiXD1RjBwFrCmhbNRT7HcJOMa8y7S5thBB1Z+JDGisWcQi17ZQ
	80RHtod5BeqsCCkaanMJTzM6mLSPYXw2BDHFgBS3AW7Cf1RqbitvBNW0u9SFOIw5pdOIIXmySOV
	xrPROnGwzpHPpxnuTUzAskl2KGeMky53+eQoeML8iCPFzHeVNBAXVzHqrIbZJCjOCAbLDmmEl2Z
	Beuqh7ruq+q+y1FknjFX7WLPz3KnwshmRQohAT4rPvOdm3LKwRwlQnYF34E18iEOQebE=
X-Received: by 2002:a05:620a:468a:b0:8b2:e346:de7b with SMTP id af79cd13be357-8ca3303d992mr262612085a.1.1770223119744;
        Wed, 04 Feb 2026 08:38:39 -0800 (PST)
X-Received: by 2002:a05:620a:468a:b0:8b2:e346:de7b with SMTP id af79cd13be357-8ca3303d992mr262608685a.1.1770223119258;
        Wed, 04 Feb 2026 08:38:39 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fd4a85asm138314366b.31.2026.02.04.08.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:38:38 -0800 (PST)
Message-ID: <8119913b-c7bf-4de3-b731-dec128e65a7d@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 17:38:36 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] spi: geni-qcom: Improve target mode allocation by
 using proper allocation functions
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260204162854.1206323-1-praveen.talari@oss.qualcomm.com>
 <20260204162854.1206323-2-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260204162854.1206323-2-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNiBTYWx0ZWRfX7x7Kb9pfD/d1
 5/nRiHDWnwBUnWweamsZBLPE20R28+pb2QjNMv75i3qUlSzJz0Jf1WCw7vSPrD6YeeHkQ9URaKS
 esxh4I/YC2xf+Ab2d1pM3DKkF0xHZ/BsUcBm4PSLoQkx/gsA/MGH6pvOtc3Otlo/0ATsGkHd00y
 z1pFbHOrPNxlQOk9faVY5/8RNRIFS8oLUv2qOs9u5z6403Gl1jjKyOSYH4GtF6YtE9NJUysf0Op
 yKxiU8jeqcgPmySQCmFhxrZfVLZxyYmKqINej4DlqreCbEWfjF3H9/NT5GQVAV1m1kR4oQMMZuf
 9qi/GafIjK8Z8wCbLmjHxThqXP5phnOm54tB2ad5cYgYso+GssSUjCOSlkOqHdjlSBWjg6IRU6X
 BHCW6bzK7fZmuQS/UrhV/7mrYgJb8i9Y5XItpL29GB7zkHpKZ6YL8c0FWPAFpp+xFy1R4cm4IpE
 2T71OuwKTM7a5JTZuTw==
X-Proofpoint-ORIG-GUID: 50jAoi8vUKXXVU7zgnYEnbQ9H8nuKUws
X-Authority-Analysis: v=2.4 cv=GvhPO01C c=1 sm=1 tr=0 ts=69837610 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zEteQ-CndN1-B6i79MQA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 50jAoi8vUKXXVU7zgnYEnbQ9H8nuKUws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040126

On 2/4/26 5:28 PM, Praveen Talari wrote:
> The current implementation always allocates a host controller and sets the
> target flag later when the "spi-slave" device tree property is present.
> This approach is suboptimal as it doesn't utilize the dedicated allocation
> functions designed for target mode.
> 
> Use devm_spi_alloc_target() when "spi-slave" device tree property is
> present, otherwise use devm_spi_alloc_host(). This replaces the previous
> approach of always allocating a host controller and setting target flag
> later.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
