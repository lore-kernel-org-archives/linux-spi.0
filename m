Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825412;
	b=RJCm+yX+Jrjay+LhhtiNPltBMxGgZfgj3vJSiuPiBON0sRu9d9hpv7SjLHrNy4eQzHaR
	 I50txSZrBE4EaSu3uQXv6N1oexpWyEjYWko4b3rdWhv/BRneTEWVQTO25vrfVEyOKyo2i
	 iIIViHJzexTTfuq3eJ4ziZNRwTEJRKxpQWkdtDybuI2vhoV6hN3T+A9zo7dUaJEtu4J6U
	 wNHIX9fgtgjr37n1Hw5f4p8ZAFIGTQgfcoG+nCM9YPG2kNkCLItaaEo6m4AfUgX3kiQdy
	 I5/5QSMPgqc6cwYMfwc8MaJLuYWpI7wEHmRtUmOWpAYVM55z7UFwN8vG7AZHedsgAYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825412;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MftvhOyh0JpsGoC/uKwPwUiWJJ5nnSYLJzRW3U35/uE=;
	b=aBYmAXzjqyIXlOaX+rsmGHXzLdqY2ZetbfHnmnuYGhVyMmVlGOQgoUcElbLHK9wlMYgD
	 5XQwYLo3bx2D17hItw49DpDZO7J8LmRWiuVJBKAd/LgcyTH16htQdxHLcwD/GSpVdrtDU
	 JI3hJz0Cq1VRlB2QwqyRjLb1oGGwZNcohrVf7Sych3d9HoXWraZ8b890aw3OoxL3pQfe4
	 9/BeIp86Utpd+yZrB8srU4AvDxcQUoMcgrYs/9qqqOFGGm7kfILi1nJM7QQH3PoPiBNaD
	 TBbxzg+OkAvVw/BaB74rp1xDoq50NuItfqci7x5d0FLMCA4c0mab1WXqdl9HxODtXQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P0Ii6B8d;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kv5UWK5g;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A03606A887
	for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2026 10:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23A03606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P0Ii6B8d;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kv5UWK5g
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AG7f0EF1633061
	for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2026 10:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MftvhOyh0JpsGoC/uKwPwUiWJJ5nnSYLJzRW3U35/uE=; b=P0Ii6B8dvzW1BWVr
	vF7QyOXiccvKYXQvu4cSlMXbJZhzPqaZml7m4cbtpoemL6floNqwNdb1T778fh/W
	1YnBzfTkItJlO5kCDcGjZ6QgRr5tzXKY0yJls/4rMcVpT2qT6kqfh6GcodW8o+np
	hFLu8yHjNwHCCtWoIe98zmlK29UsOryjtshI8VVlfPJFjXmvcRpM+RAnnVGlue94
	4eabt2dbek/AmU7omBipCsHYlQaTfT3PO94hkxHjopSb92UhxqeJKTeiaqVK/F6Q
	FjH9m9ecQjWqqNOCHE/98xi3eKdLxjd4v8veY0B+v97+KkFzjTYD1eKEqsAmpqFi
	scT6Rg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmanygc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2026 10:36:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ed283cb5b9so22194705ad.1
        for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2026 02:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794825410; x=1795430210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MftvhOyh0JpsGoC/uKwPwUiWJJ5nnSYLJzRW3U35/uE=;
        b=kv5UWK5gXjfQeCZc1SoNrluIDPIs55Brc41K8tbEc3bsS74sc+VCuwC/6WrNv8w5MG
         F8pYRg2fKvo4gRcuTVZ8IKhLk7Uu+HARaITLV03Rdqiuj80016wl63DjeH/odlnL5oqs
         2SIk26JgufwxG1noiVsQPEcliDQOvz8Du5FIkTaku3XKE/ATRbc51RSj4YtRf3ga+8Vp
         JqXvdpcEb/Fz666tCfAkEwOrc3mGbMprRzimElqnURElThv1qKUkcK2kEmAoKrIIGNhq
         nkQnw1ecZ8IFRJzkqSYMvZlkbpWsAVNtLR+yZTKGaD9O4UreavCY7zBDxIfgCN4RIQtu
         Vl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825410; x=1795430210;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MftvhOyh0JpsGoC/uKwPwUiWJJ5nnSYLJzRW3U35/uE=;
        b=LHKP5sOKtkwlJOtru67oVYM84aGTDkOGN7PgY3/xUTwAmkyLCxjbKaE27rg6MkFU3/
         cSWIsxdXy9XeC4gCDZzEFJUJ3PzuUijQSWsKfWyQZGuW2TmdlUex7kXy5s4MAfGwyKGX
         6zqpZh8WIw7AkJcEo8T49ayj54aooFtkkNoRXtD0fqFDB0WCGICZnAsLuRqlK0X9s9m0
         Uni5+1ZLziZYZHeWXH9D6D1yMtG1jG5Pqjyqxt8mskt91JoF7r3GW2Oiwxc35GtnlTEt
         BqNYKQZA810EC5LC2oATr4zaOQm2aEBeM2kdconFsFP0Ckjk/1r6kfBmv9gKpfRgwNKk
         qH3g==
X-Forwarded-Encrypted: i=1; AL+hErGui6PVvKF+9gvJpejxKxEirFD2WzCtZsda5Of5qTpVVOLflM32gny/GlN8AwFcyS9hfvEBmvqIXPY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+31ek/19HckPStO6/9f9QJvPjyUEdIxzHv49PEYc90s3/hh2k5
	JNcFc1mBaZeWsWu6h+i5QaP9K+x8aPatZguq4PKG9vess3r/X2boC3pD0tPjHHaLl5lfMRCwj7Q
	LpbVlF/TVVAhe9JTHdzpnSqHIhSf1qJjZYVRyt2qbgYbUpoV59PrQ49jy9BJcgDs=
X-Gm-Gg: AZFdTZcdA14MFmTdj2uYzsSAo+YAyGWyaLYcPT7AQK2dAZhvq52XZKfNxWb7XzcLpI/
	JwxF9XXDZkfzWg9yT5b5ImjgaqKdNfoJ0c8dQYL9tWrvujU+VXbWrzBzLIOI7k7lQr4tHDFnb//
	rCLNaMAgrErqtzabiXvUphIGlaKo7Eac99AsBYXpKIqijE0lYgvNg3ycclOWgeYDhV2NschTYah
	P9JJopoTBcrqlY39ap86+i+4O26ZUvCdlR6chaxsTudPxg1JaR2L36LwAbame8PMp2HGo1jx6zg
	KcsMVoU8BZJOSi/M2xxcf+nvNdrGjyg0MjhDfg60SsHmhgi42H6WG4g6qyha5/XaQsc/5OKyXWO
	MFob8DWllfNq1xM5+0J2jdMm4fHYSVIKCr5VSBT0Q/ix92fYi856w60xGTbNS8G/Px3YYnXMaq6
	INXNA=
X-Received: by 2002:a17:90b:4ec5:b0:3b1:6689:a016 with SMTP id 98e67ed59e1d1-3b1b0b8f9cfmr5958549a91.16.1794825409916;
        Mon, 16 Nov 2026 02:36:49 -0800 (PST)
X-Received: by 2002:a17:90b:4ec5:b0:3b1:6689:a016 with SMTP id 98e67ed59e1d1-3b1b0b8f9cfmr5958521a91.16.1794825409384;
        Mon, 16 Nov 2026 02:36:49 -0800 (PST)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f4adcdesm36374645ad.10.2026.11.16.02.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 02:36:48 -0800 (PST)
Message-ID: <0d4fa5af-e406-4761-aa58-534c3c6a043a@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 16:06:42 +0530
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: dma: qcom-gpi: Add QSPI protocol
 identifier
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-2-21f43042dd60@oss.qualcomm.com>
 <20261109-wandering-miraculous-mamba-0cf21a@quoll>
 <2fc8f7ea-651e-466e-9346-c47e0a38c5bb@oss.qualcomm.com>
 <20261111-daring-salamander-from-tartarus-4c72bd@quoll>
 <c9427a03-8b45-4e35-a29d-7ebe30f07ed7@oss.qualcomm.com>
 <5b6e4031-4c52-4b67-82c2-0033d13b15d6@kernel.org>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <5b6e4031-4c52-4b67-82c2-0033d13b15d6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: V7r46Ob7yGfOCkjgy6pC4Ik4fTFEYknY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0MiBTYWx0ZWRfXwVJOPPLnPXzu
 HVlPEeDkw2+sJgy/iNVW1nrx84vDGei3RVNyuTnXUq/hSzUiWjRIK6y6nE9s4glG2Ylo0ohBRnL
 QQs4efcw+Zg/9EFVK8u9bXFnXFnqzDAZ6lNU+pm/ERk1W16u9ZsLhUGzSdwDmRrak9+O+ORgmUv
 b01ZaB1yFmZgAgT3yTx24xzSXptvD7TOg8UPTSDY3M4kQP/KTde982wX2OYNDRJ/O3/Q3AVC//K
 opPWw3X9eT9RSOfDFdMzqANDeuKOCFw0AWHb8bpWbr5iVncu9fxoRNBqHB5bzou1B0IXfMX+BcE
 x4exr8BHw99PrjfP8Siruz5CSG1Ln16yXQZMncrvXJj17dwFoFNnyj6uyrcm+3Fdf5mHh4LNsml
 K6YuNHAapAiwvCfK2xTJ7IN7IPXtjQd/xbYbk3NPYUdzPRPuKX+Wf0Jlp7K0dOn6OuZ3JwI0fDQ
 LgslnnEOxCy1/Pob8Zw==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6afadcc2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=y5txsNG1kXPmV2KDPIwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: V7r46Ob7yGfOCkjgy6pC4Ik4fTFEYknY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0MiBTYWx0ZWRfX39rAk1dAdLDN
 ywpcbnZ11+SN+vO0cTdznvVR5dMy0XlKaSOo4aUQw2QK0dd0lOBJTlJIvwUFOTI5EY71DoKbpdI
 s4zyx+A4Ny6VY5c1WP7gS3AdNxK8ncw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160042



On 11/12/2026 7:27 PM, Krzysztof Kozlowski wrote:
> On 12/11/2026 14:47, Jyothi Kumar Seerapu wrote:
>>
>>
>> On 11/11/2026 6:07 PM, Krzysztof Kozlowski wrote:
>>> On Mon, Nov 09, 2026 at 08:03:29PM +0530, Jyothi Kumar Seerapu wrote:
>>>>
>>>>
>>>> On 11/9/2026 7:12 PM, Krzysztof Kozlowski wrote:
>>>>> On Fri, Nov 06, 2026 at 08:31:20PM +0530, Jyothi Kumar Seerapu wrote:
>>>>>> Add QCOM_GPI_QSPI to identify QSPI (Quad SPI) channels in GPI DMA
>>>>>> specifiers. Its value, 9, matches the GENI serial engine firmware
>>>>>> protocol ID for QSPI.
>>>>>
>>>>> What is GENI serial engine firmware? How does the Linux rely on it that
>>>>> we add bindings for it?
>>>>
>>>> Hi Krzysztof,
>>>> GENI firmware runs on the serial engine’s programmable sequencers and
>>>> implements protocols such as SPI and QSPI. Linux configures the engine and
>>>> submits transfers to it.
>>>> The existing GPI DMA specifier includes a client protocol ID. Linux programs
>>>> this ID into the DMA channel and selects the corresponding descriptor
>>>> format. QCOM_GPI_QSPI adds the QSPI protocol encoding 9 to that interface.
>>>> I will clarify this in the commit description in V2.
>>>
>>> Does not really answer. I see no reason why GENI firmware needs ABI for
>>> Linux.
>>>
>> This extends the existing GPI DMA binding, not a GENI firmware ABI.
> 
> OK, so it is not ABI for the firmware. Period. Let's stop discussing this.
> 
>>
>> The third argument of the DMA specifier in the dmas property selects
>> the peripheral protocol. The GPI driver programs this value into the
> 
> Yes, so the third argument can be value of 6 because it has no meaning
> for the firmware.
> 
> Again, follow standard DT bindings ABI rules, you don't get an exception.

The existing GPI DMA driver and binding uses its third cell to identify 
the client protocol. The driver takes that value from DT and programs it 
directly into the channel's SCRATCH_0 protocol field.
Its mandatory to maintain protocol ID-9 for QSPI.

Other protocol IDs which are not part of upstream are for AFC (6), SPMI 
(7), HID_QSPI (8).

> 
> Best regards,
> Krzysztof

