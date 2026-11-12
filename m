Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491347;
	b=zy4O6n2pLpyMf0bHzPgPG77r6aKcrniAsOeaMLEbQ76xqIMLgm1s5hE23biupY86EmS5
	 vWOgcx4aV36hHGK6qH8DWBNm1jf37pJPC3vQ2rARyf4VTHPMpIYe25cE8xMbftb8Gp01c
	 w8lJAn0kwIIeI6YPBtTJuwhsX5GnyIJ5pKRpZy5SdFKsQElq2lFT96GKQrrWPBGBVPWqW
	 cQbcXAbPQ9iLGzkaWkrI9NAX7pRGohbxY1439RdiMoBdD2yOnmxR2NDeOmnCrmt3CgIOx
	 wyHtLQTy6yaLjaDFcEHNv0A/0WDr2n4NzFr/gC61xXa8S6IHOTuVR6jcj/4145DmUuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491347;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3hXQZENuSxu9iFWGQOgWQMyHyL4PYXASjhi5T5DYXmo=;
	b=J9iO6JSh3BCbj7OQ9KoZDp1xWXa8Uj9rEzNRnwnJQIGbWViJQm1hd1K0gAKrK7pOkko1
	 5rLYlwaulPTgI8zRrZ1mCvzYXmTInhFGiL5njU0xZQB8a8/gzrKbcf9Bj3qqQIy80zMLM
	 IzZUXZ18EFfzutYkvUsn5dTo9P9uOxFIDtzrOXwUtE+YzjStXeIPv9X4LGbVrlBDLM08c
	 HVG24U4zMUnYrQAk3EMpXzn2A3qtrBvV+4fWMoACRG4wpg36Ozth/NLHSYWY03pI6Ovwm
	 F92t1YMAg7q4qjDUok74unTtIXWuuI4/uG2YWM8ovUaciuZpORcS7MoKuoM8MI+vvgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dS9ADkxb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="LB/XrMTV";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C44606A32A
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5C44606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dS9ADkxb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LB/XrMTV
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC9E5YN480536
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3hXQZENuSxu9iFWGQOgWQMyHyL4PYXASjhi5T5DYXmo=; b=dS9ADkxb/Kfrsqbq
	kcV7+R5mEVT1gMPTFpALmOlGY+TRXp0Y6aTe3royqRmSFs++2bvUIRJEfwho88sr
	P78psjoAlCnf2p6/FJwQ5p9/GZFRCAt3tz7rQvtbs1jlXaqd/EdhAKRoUM4Q7W+v
	ITiQ+3WrMPGFofw2UQtRSkWg1swqsBtkcGn2Qb2Yghny+OipKvvsaC7rsXotkAch
	9Joi6OWaY+kA55TfWUGDkExP1TAJm7yi2IfKIP5l4h8qLSnv5ruSl0iQR1RArp8i
	v+c3mUnhAlBzsqYWtuL/Ece7rVZFnJOAg0qh+w1mF8+lHe+5XYVvSfZvA9FWnFOq
	Co/2cQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4rwcc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:49:05 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf7856ffso972977285a.3
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 05:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794491345; x=1795096145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3hXQZENuSxu9iFWGQOgWQMyHyL4PYXASjhi5T5DYXmo=;
        b=LB/XrMTVAom6eiU4jL+d6VIQK88Sd0mAAKGHBIbEb+L8PX0H4E2ahkdB6YuMLmKwlR
         SSRGEjGhC0AzfcWCy2YPKIfJakX15K85/YxKuq0GohCJA4PITS16QYbvGK1341tOApef
         m+GwpU3i1Q7h2HJAmaf7YyWXJ8CoM+BunMyEEYAwrCmrcFxf5OHC3HzJyJj0spL/dWmR
         T9hDrluoh1T9+d45jOH6pZXZ1AkR3/hkS/YFP4P9WF3GdLZ2Igmd0xOoCwONT11BAh+w
         nIEKRv00eRl6EQV2o3JLAusZrt4mjj6qjFnzDuQRdFSaKNSNN16AANDcu0VkaxiUC9yB
         fPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794491345; x=1795096145;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3hXQZENuSxu9iFWGQOgWQMyHyL4PYXASjhi5T5DYXmo=;
        b=SgTdpxw3Uso58KjjOeNwAyHhCALpSE5lunLpDeSaxYKU7yWw9VOX4xVFT6uhqLUTq1
         vplhhSvpyfDyLh5HA226wH/mHn6wU+jcYf7/6DBQs8Rmhh4IuDj19S+BuSs3nCT/o+/A
         YrEVyEGAK1MGurR0ar+V+3vE+taUEcyu93knTaVXsw/BrJy2uNlsuoRLWlFmtzyYBKHb
         hE61OW9X/DIN5/KXEpyfKk1FlJLFRgEAZI1MJS3sxnHBYlTcUzd2+dSyw0P92M5pweow
         Bwtg1uOAWAI1IRlVs9i79vB3hl7ceJbM/kZk4OB23bBWhQIIJSCa46SWibeZnJ2PkqVK
         PFew==
X-Forwarded-Encrypted: i=1; AL+hErHb/fpVRNbZxFzJw9r972UHcp9KS725CPqameeedWd9nYfFdWQMXa6prO2EitghaIEmsp734jSiAA4=@vger.kernel.org
X-Gm-Message-State: APuU4Z94IhUunU0vTzYc4oFqrVAkC7yhdB+mSQXoqZtUPj3d2WyNDnx9
	Xjoy6xE/W07HiQwbbNr5ZGMJO2Othr6Jd++GP7OJqXCTyUP/VGzd20aJaskFGIZqjS5isgnlJCb
	R5znU5JOg3SsDWCyD/bOX2wzkl9y6ndLWeNe6wALb5fHd+SAYwcmr5XaQLPr5ejE=
X-Gm-Gg: AYBFou3jGDzqsU20wlLKmwBVP7JSLK47FghOWcqSfFZDm2Z0/RbvoCBH/qZGtE/d/IH
	Y5bIDBFnrSnQuk6ugZuregi0VW8NPuCo1ePvPWEqXYeQcaBL6UKn5psv9eTS/myrcS03kGfUXqp
	jOmEvd9rnFMImtiPIQzBxp2dtBAJ/NcDJTYqlofcTVkRYnENx5XFs++JPcaVuhPJbwZ9Ai1IJrs
	fZtvB8QzXCvPnKFkV6OmPyU3jEk++1bW0kvx2Mj4J24LX4FMpXeK/CtYjbaaD32hkh6RpQFxDPn
	eMnRiBVADlKLzubcWr13iWWYXA4kSBeNcLnu5HcF+tXBCeeqTo7kqgJ4mLlqJXuzSCNIaQjyEkd
	SGiDIzJcUy23TrfP7b0wxybUhLcwgn7A6oKVAYgIltiZ8sKQNa38uwGRppYZINtzzUkvtHGRWp8
	xMv7Q=
X-Received: by 2002:a05:620a:450c:b0:93e:623d:99ec with SMTP id af79cd13be357-947affe663fmr964783285a.13.1794491344727;
        Thu, 12 Nov 2026 05:49:04 -0800 (PST)
X-Received: by 2002:a05:620a:450c:b0:93e:623d:99ec with SMTP id af79cd13be357-947affe663fmr964779285a.13.1794491344206;
        Thu, 12 Nov 2026 05:49:04 -0800 (PST)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae196cc72fsm10673721fa.13.2026.11.12.05.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:49:03 -0800 (PST)
Message-ID: <b1b753ac-cb74-4b9c-8fd0-31777a020878@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 19:18:53 +0530
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
Subject: Re: [PATCH 4/6] soc: qcom: geni-se: Define the QSPI firmware protocol
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
 <20261106-qspi_upstream_series-v1-4-21f43042dd60@oss.qualcomm.com>
 <20261109-stimulating-oyster-of-respect-620b7b@quoll>
 <61646f06-87f1-48da-9b88-8898bb488af7@oss.qualcomm.com>
 <20261111-prudent-polite-shoebill-add35c@quoll>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <20261111-prudent-polite-shoebill-add35c@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YhBBo62xf4J8nKDPpZsdGsSuP1gVAjtv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX59SSVKFvaaQV
 0JB42R+oPyUzHJxwPm+2fcUbyyOlx5SALy/gCpYLecb07MzRQ2L+STzxY4xwO6RrF7zdWupvUxj
 m4Pq2knozLVfaKuvvJjdGHrIbgLOUao=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX68TjJcXr11P6
 3rrlrGCHfTYyKNlKwcMQJrhYn6V86Aiuno+N8THrXqBU1oqUAQnpGBCxWRLns/TFla7y90Tkuf+
 QZVUkb4OJ/pLGLTjhrG2KEpv4BXf8PJrDdhc4Ws9ErQs5cXMxFc1Js9f8xEqJudkZ6aYJjgzYIf
 ZH4Pwg4/5uCTgPvYN147exsvhWII1oOmqvx9LzFjo/Kpv66hxn/kWbRB4O5iiA0bBRgeAP2nmfb
 nrIJSTisreopl2KCMMuieXCFCYFVwqfnQ/avO9JztoX187x7feB76GWc+1KjXlOx//+0eHo2ahA
 ft1UeP1N3ifQSKeuXpEi4JCM7zIpEdHHxKJfjR/dz1FGaXmzLj1pUqEBU87mBfn4eWxwJv62K4R
 btW+l4BCRE0W98UuwugEZSfVowTSVUR4WqXEoAPm8Zuv8FoIp1i/COFTxRO67InFBg76Q9t96rt
 uTUgQPkbtwkYkxS6RrQ==
X-Proofpoint-ORIG-GUID: YhBBo62xf4J8nKDPpZsdGsSuP1gVAjtv
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af5c3d1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=DN1OgqIxCIglqtzaC5MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054



On 11/11/2026 6:10 PM, Krzysztof Kozlowski wrote:
> On Mon, Nov 09, 2026 at 08:13:33PM +0530, Jyothi Kumar Seerapu wrote:
>>>> -static const char * const protocol_name[] = { "None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE" };
>>>> +static const char * const protocol_name[] = {
>>>> +	"None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE",
>>>> +	[GENI_SE_QSPI] = "QSPI",
>>>
>>> Why are you creating holes in this array?
>>
>> Hi Krzysztof,
>> The array is indexed by the GENI protocol ID. QSPI uses ID 9, while the
>> existing entries cover IDs 0–5, so the designated initializer leaves entries
>> 6–8 empty.
>> The added NULL check rejects these unused entries before accessing the
>> protocol name. Appending "QSPI" directly would incorrectly associate it with
>> ID 6.
> 
> And it should be 6. Just look at uses of this.

Hi Krzysztof,

The QUP Hardware Programming Guide assigns protocol ID 9 to QSPI.
This enum represents the serial engine's protocol IDs,
rather than consecutive indices for the name table.

The SPI/QSPI driver uses this ID to request the appropriate firmware
and validate the protocol read from GENI_FW_REVISION_RO. The firmware
loader also matches this ID against the firmware header's protocol
field. Changing QSPI to 6 would make these checks expect a different
protocol ID.

The name table therefore needs the QSPI entry at index 9. I will
clarify this requirement in the commit description.

Thanks,
JyothiKumar>
> Best regards,
> Krzysztof

