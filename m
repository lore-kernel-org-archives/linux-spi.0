Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC62E8DEA
	for <linux-spi@vger.kernel.org>; Thu,  2 Jul 2026 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995975; cv=none; b=gsajASkMkHl8NMKGOb3KiRH0oiC6OiLvfngYzuR4UQIic69lYr3MFcMkA+Yr8E1Lwr4Nu7Uf40X5QrInAZ4qbgq/ZDxxOrcurVUBAmIw87ZJSmsz6pj81iYUgA/qAhL7OmvsAD8yNUdj4Q30EUKlUvrhcn8gOPvS/iU2tPKcKy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995975; c=relaxed/simple;
	bh=M/1IO1ovD3xv7E7bwlWhzJmzQk00aY6O8z3/PeBE8DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MIVpnWDIee8/3AzLGbrdnrJe1Yz6nNDqP4l4z8oq9ONoLrZFk1eD3M+7a62PhZkG11XNGHUkYBU9lSN/xpjFBebRaOOp50lSxVzLjyWrUb6+kQBn0J0vX35pjxAHppq9LbYJ+bcYLub9eDrSNNvg8CeAX8jQSpHLhdIB48JTeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fza/WWmC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dazX+XzC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fza/WWmC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dazX+XzC"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662BoAed360084
	for <linux-spi@vger.kernel.org>; Thu, 2 Jul 2026 12:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9CnAJp8KHEUhQx8/mU74U/fRMf07e+imvfeLUvkYie4=; b=fza/WWmC380toLK/
	tHkJhoz7hhJw77/0liY0hTcH53/gnckUuFovyfcL7LP+LAhlpcuoLXs8WpKVTqfV
	egxX2ePfToyWWUNRllWUV1B/SaEoF+7Q2iFX3m8HWaxE29Bik2tayo5h/st6S+We
	/gXOgvymgN66zWT+jNpiFdK0MoXWyUb4Gr4OyWkTfzHh7Wj/GXank2w7l+3BgpIE
	pgNeBhzbvG6kcwg7ya7krJjdmfVsQ1iMNuGRaeWCh28H8oJ/PvfEWE5mWOdmbTds
	nL+lnSrAfW5gbmbCWxABxdcDQ6qVbS8Ug44ILepZMAsr7gxviPFlxTNouFn1BTfl
	ti0Hdg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qfc0698-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 02 Jul 2026 12:39:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e69a569ffso33493985a.2
        for <linux-spi@vger.kernel.org>; Thu, 02 Jul 2026 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782995972; x=1783600772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9CnAJp8KHEUhQx8/mU74U/fRMf07e+imvfeLUvkYie4=;
        b=dazX+XzCBzsIq/2oYnz1XEEoCFCqexXbXOR0iEXBaTYMnJCDqNddTk2e7t3Z26zGmh
         lS7KWttUXAlKs/R4RLn1mkTPLn07NZuIqB8cjjs2ImRPdMLbPvvS/0b/dFlHh+aS+76m
         2nE9Q2jsiE3CfQ3rFg20lU9TIfMdV+kLIV3YONYentTFYVH8lhfLooXNbfxsbSQNmkot
         N2f+N4dPl/NUWdVw0OINHHw7zhFuvYZatB6ZuRBgN+Itj9GPgVqzNbFIVyIL8jP0JFCm
         fi8j368A1n8pOeyHBQ4HKmDHUkoLaKwDPT78d+jy3IUdgVyw5WJytkIgFxjmfrFKpLcG
         CVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995972; x=1783600772;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9CnAJp8KHEUhQx8/mU74U/fRMf07e+imvfeLUvkYie4=;
        b=iF8MgaCTEJLNW/rmGLLQba0gVpwRZ/RxaqANZjHMwW7NArCo6e/4DALxyGwTsZT8Eb
         DlOSUCGTR8gChfJbWQmInOV/uMmXhvCtE+GF+s8N6DAap6AKMQWs7nUDGhysDaP61/1f
         w/XPtQGlWtAgfK2Tz8VuVJwnZmVWS/7MmvyIz0uLYQXU40eDOEZGAAH0Wpm9ZUkRV5Fu
         JaWifEwZAl9i0nlmuUfP7F/3chLFBVZ2pE5if5VtpRKbRxFk7pb++UbV8UbBVAALH2hq
         q0oJZtjD9Dq1ABEVm/KE0z8iOC+mP7x3P5Zk004WTuG8nEAKC/tHXDM6QxiSPDJ6AmWD
         eRpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+4zkFN9XkKvPD7kW3d/iFIkYMT+NqPXJWBmo1jLDVoIVt6mO0LEt+3O2QevIFY85BLm3QPy9R21ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtr9z35ZYA5rIdrYnSeJXfdFiJHanRlR+y3XC2c+w/EbwOGwsh
	oLWek/lxPy0mfWzhZzU2EDoaI3+Z5GWgAEodoRj6WPFVQirzr398VoQg9K6tNEUu4trVntYlHFr
	PCdwzW7TOe0wHTdBWspiOYvMQasIz3DNa8qne/yG9ziJhrO+RpshkM6SFMT/CA7I=
X-Gm-Gg: AfdE7ckAyIu+uabOihBkIoeG+y1Ow7pj4508dOoCu5RPT0c+QaZp+SesKomCwEuprEo
	9gkdPb9kiqMPBmGOgLLTkLXjm2ScN+cf9OTf2Hl7GFs1H5D1qrv3LTkHLVV4zAR42/j8GuupKp9
	5b/HwPWcK/PfAy6Ncww2a23KIPCzGqC9F9rCjz2PPDIFfZ4x9cJnrhFhZgoeubZc4XpU2Bv09ds
	+wc38hTfYxiovfaG6wZZnuqS29WXpanGTl2wT4wcoCw4gLLAs4HnPJebiDq8FqOPDZ8hgsofMeE
	k/Il1eoSP2xXqXjS9Cud45rle4eLsTqsHDWB/3m5RlHnS4FjHdJZjdPz/XIYy4gPD23n7yy8BBe
	khN4TIRQgfBVcr3pBStAySj4QEY7TbIsCCnI=
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr44656471cf.9.1782995972040;
        Thu, 02 Jul 2026 05:39:32 -0700 (PDT)
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr44655921cf.9.1782995970668;
        Thu, 02 Jul 2026 05:39:30 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad0fff43sm935595a12.17.2026.07.02.05.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 05:39:29 -0700 (PDT)
Message-ID: <c3922558-dead-48b9-a49c-7d0d6a2dde7c@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:39:26 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Pengyu Luo <mitltlatltl@gmail.com>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com>
 <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
 <c29776b4-04b8-4c59-8f1e-d766bf982a2f@oss.qualcomm.com>
 <CAH2e8h75xeRVvo+jOjRuFaBko5NNCnBX0dawFFsWBaiTwNd4Xw@mail.gmail.com>
 <99eaf1d1-fbf9-4336-a13c-ae8ab789cc99@oss.qualcomm.com>
 <CAH2e8h6aWW_=pD6JAuFB-VqEZDj9x8gZVh9TdvTCRQakKzm3pA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAH2e8h6aWW_=pD6JAuFB-VqEZDj9x8gZVh9TdvTCRQakKzm3pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: CEzG6zImWNIgmcj82GOCX3NwxAeUJi-Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfX9RLcVJ7rByvY
 yWYMegSpGulysU0lSFEEdJXAQlbeOBhB7Dc7p8wR9/alQ+LLK95dj6MCBTR9a7ulZDpBL3l+bbv
 7ACmQEVqbnQyqUXUCgpPOPJNlaRl+NBp/scHykArnWaauvwXCDX8Scuw7tg88agtmRPXXJra1Kb
 U3n/TyTdk8sltJBCUiiQ4+la/x6d5CATeBD5xBBmt7N1KYQ1ascoyOiqTZCM4VwjagGH/EwvEYe
 xR1gEZZNqmOkDffc6J0NdBYaao8gZL9ozGoZdy2mrBJ1UAyLJZp3u5QW2OMej6+uXV0buvyeN4N
 jKTomh5UdFSWc4TXfb0sHv/HOtGHDFZ6PgXVigmRiLfy9QqZSVwSJT7YtzW+yr3lI38y8XmJXn/
 sS0volhZL9EvGa2KlaYRf7dZUh+3nEopm5rmmwle9G4+Kz3314+oiuZQXqdwo1LHJ5uZgMR4bPl
 xPRVtIAH2v9Tnlnc51g==
X-Authority-Analysis: v=2.4 cv=dvXrzVg4 c=1 sm=1 tr=0 ts=6a465c05 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6QUDDQO5MDr9iEhkdtUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: CEzG6zImWNIgmcj82GOCX3NwxAeUJi-Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMyBTYWx0ZWRfXycEbsQajLa28
 +pb+/5kpLzH/36b/RwuDi3WvvtSjh9TaGE1p4EtFqMoqweFnYARl2CTNzUqLY47lgMGibJ/YYBE
 LZFMefkPQNuOW8Mee7Q2M6pI3xgxMFE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020133

On 6/30/26 12:06 PM, Pengyu Luo wrote:
> On Tue, Jun 30, 2026 at 5:52 PM Mukesh Savaliya
> <mukesh.savaliya@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 6/29/2026 1:33 PM, Pengyu Luo wrote:
>>> On Mon, Jun 29, 2026 at 1:36 PM Mukesh Savaliya
>>> <mukesh.savaliya@oss.qualcomm.com> wrote:
>>>>
>>>> Hi Pengyu,
>>>>
>>>> On 6/15/2026 2:48 AM, Dmitry Baryshkov wrote:
>>>>> On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
>>>>>> Some devices (such as gaokun3) do not disable FIFO mode, causing the
>>>>>> driver to fallback to FIFO mode by default. However, these platforms
>>>>>> also support GSI mode, which is highly preferred for certain
>>>>>> peripherals like SPI touchscreens to improve performance.
>>>>>>
>>>>>> Introduce the "qcom,force-gsi-mode" device property to hint and force
>>>>>> the controller into GSI mode during initialization.
>>>> Why to force ? You can directly configure in GSI mode. Note there are
>>>> some configuration done prior to Linux bootup too.
>>>
>>> Sorry, I don't get it. how? I know there may be a qupfw, but it is
>>> impossible for a normal user like me to generate one with GSI
>>> preferred.
>>>
>> If firmware doesn't program in GSI, you can't have this working in GSI
>> mode, its going to fail (and work with fallback). if it's programmed in
>> GSI, anyway this will run in GSI mode. So why to add extra things
>> without any usage ?
>>
> 
> What I can confirm is that fifo is not disabled on my device, and gsi
> is definitely enabled (under windows, check the register
> SE_GENI_DMA_MODE_EN), forcing the device to enable GSI mode on linux
> works well.

What's the value of se->base + SE_DMA_IF_EN (+0x2004) on this SE?

Konrad
