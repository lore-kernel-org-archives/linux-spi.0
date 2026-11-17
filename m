Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794926351;
	b=xt7B8Ccb3d6KeIgVu4lzeie85rYBS892eWq+a3/Hj0lWr4wm1OlNVeZ5BIBxcBCVO6hr
	 xJsfVoq3b9Lyl94rEC5hTcx6DarP28vSzc+D3VZmPkTq0LgMQB9d3pfJwGDVLjly3NpQZ
	 bFXkgWRSarHZ8yNUhJcHzchU0BfHM6UFWbxngy/6fq2DKHc3UnDDPHaBaa015nqpLw5MB
	 NQLIMuUFdrFMp+2XNz/s+rH2FYOw9N5/GVT0uxc7gIWeU6V1SLmJw5NHaOaTp3eHznDIn
	 8eHBVWsgSihI00IZELmxSrcZfXqy6o2EtruZc4Oghx9kNH7IMItlzgeAA9CsRX4meEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926351;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=J/4vLvyNqeORXrBPoXGUzzn2IETQe9KRQ40Tt84ca5g=;
	b=TMeqIPFSAeYm5hMj34L+C7viHef18IU2ZWJ0a9jBZWMTQkoW7BLK01uQ7rwsLyoUD4QI
	 J82+HAt3LQPVntgPJVE5aqVGglciK7uutCxZBR5FoCuqTsRheJ0Ag8t1praMVUyvvFMUg
	 IMTsxGC+rmNCLaLY13rVOfp5gh1N2PyYkc6m704BHBAbBZVcY9wyKcMrSMndxbzPjQ9Re
	 hZz6zsjjfpTtEsUQ20CDguVzsnhxNXOmG2O3xMjFfV4bDKFXBMrnuB9n7dMQJ32mf7t73
	 e2+gj/955RJGL3OBKjMQAvUSjIXqAzZeYp7noDSV8OZzCxL7PjMdNWrzRSvySLYVfsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RaZdnNrX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2eYdPIa;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFDF606A33D
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 14:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EFDF606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RaZdnNrX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I2eYdPIa
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC1wAV4187988
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 14:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J/4vLvyNqeORXrBPoXGUzzn2IETQe9KRQ40Tt84ca5g=; b=RaZdnNrXIXuujHIL
	b9gDY6DkKpfcXz3+RtJMNcSG2CBbjvyZvwfuE3SPA1MzNtWuWLPkv0xOk3corQGb
	9hnsSeU//oJ8Xfddv4H2/ry7020h+5yagaaVpQpSz7oxja90XPUrw1XDo/8PBigI
	CALjD9jco/hHbq+V9D9XRgpEh5T2P6iWO+x71wV/QuYtotFLUcispWkEaAg0pAqU
	7hmUtvgFJJtB/jnoLUIArmuG01TjjmN1fdT2x3Ak/n/0OvWhffI4K5jOktBNlKu8
	PPDe1XT16GpXB9ydVlfUIORhu1hKDnkSYLosgk+VlfZG4A3AUDfcz0iY11Kt/oO+
	py7HgA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09m0bkuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 14:39:04 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99089f9591aso697445241.0
        for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794926344; x=1795531144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/4vLvyNqeORXrBPoXGUzzn2IETQe9KRQ40Tt84ca5g=;
        b=I2eYdPIawMDuzDv8t8nyVyMKHJBCpnsseE6P92OcAlApTbDGO86XNhM4CJib78ZQ3/
         0zxxPDDwVxubVpkREA2V/q8Ao/QicgYvYiqfNYFJalPfdhNPQHNYw4e/dvX6XiiqSdJv
         I37jEB4waTNWfvOm9n2pWgbVNgd9jsVqap+c59iizmhMpSq/ta5Jtdz4FiNX3a876ODU
         S9FyZHrmLeUZBUDlJCe3JgTXRzQyVwnTx1Ykcjcy2jdE1pwqWuNsIRCYzdgqob2UqKBM
         IEZSuPbXFX4czfGlTagrAvAbQgn/t6nNEQpSGIqTPu89+ZxXXHLfkVCijoDPu97MH3dI
         FINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794926344; x=1795531144;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/4vLvyNqeORXrBPoXGUzzn2IETQe9KRQ40Tt84ca5g=;
        b=DPk4KfFY/72hNy40VLyguima4y/KKLH/UZr8cRqdA8tTknW6vJ8FYQdzdAygyDVJuc
         d4zayNQVS7LR9l4z2W2nve1vLAIlhBxQNSKdumaI7d/5HunDMmJp9E3phuhxo6jcvygU
         qxXsXDaea6090h2+jyoFo0H/xUv/yM014vVT6La/EitEWv7gQjJoLDAWCI763kBTAOn2
         /v5gSHDpNU1wIwNTwSzv/wbS+L0BVZqW5hKBKT0U+bdAC8wvSPgJewiWqBnYb61U0QOP
         oJIq6MkaLZG/BR69xiTiUbve73Z0p5foPUduoy4awteEWDKuV/dvHo53qWo384K9nqcr
         aHAw==
X-Forwarded-Encrypted: i=1; AL+hErGnOpL3m5LJ7YCBHcseDbDG1A8AiGsLl/w4yGyhLFp4CWmWVNl7SjV94NObTAq+OVU/689yPEgjYKU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YrccIUthCmwyiTqro218SfSJrGLNhC98jZDoLKH/82LZ/Y+TG
	1IZM2gI0lMSXVbaw286CzcqzK+xRarr2tnclZRCRnex6Te0C8o+4K7jyQXK71Xyd5uxKGMsU8nc
	LrcMqIVgP8UhcRZ52Ri2M4IlNmYlGn2R1lJOySTp4HniIZEbDmSJFSA3MWNh8GZk=
X-Gm-Gg: AYBFou1IQZpTkeN98gWLju/1/OMp+XaGIPINPm9iA/E8QZ9bxf1/vBkMeFexssXxDlf
	tztcN90M4YDVb2lxjEpwkq+vn+15Jave9KWic45WC17o05JUYRY7s3ZYyOzUV3Gmoe3qJ8TnTL2
	RMSm+bCz7VqvzqXsdTR+b+7xPCAO+VWqVVAgu5K5BOYNWWEgks8SsjvIerMm4AnR9qjQv2AcqbS
	Ogm6fxmNPaPQJeUKXne5h49bOlFeepYbB7DlwcWTzOKYSbV0Vym7gV25beO+AEotdVMq7+nBf4f
	BV8wpmBSYP5nruOWJ4xaWllQG2fxFhBUDiSdabIcc6pAKFmYD4KFFXwNB+Adx6yPCMU2dsMiu+1
	McSog9AGECkKFTDqbeyM5u5bUjD7CqnU/ziS0pvqByq93sauPIse6nSr/aNvj8ESUqAv6IfA3jJ
	e9ll5V
X-Received: by 2002:a05:6102:6050:b0:7d6:48c4:ed56 with SMTP id ada2fe7eead31-7d64d69dbf2mr3523237137.6.1794926343483;
        Tue, 17 Nov 2026 06:39:03 -0800 (PST)
X-Received: by 2002:a05:6102:6050:b0:7d6:48c4:ed56 with SMTP id ada2fe7eead31-7d64d69dbf2mr3523224137.6.1794926342900;
        Tue, 17 Nov 2026 06:39:02 -0800 (PST)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d69e02d340sm2636416137.8.2026.11.17.06.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 06:39:02 -0800 (PST)
Message-ID: <d55bbf0a-3556-420f-852d-7a15ed8d5aac@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 20:08:54 +0530
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
 <0d4fa5af-e406-4761-aa58-534c3c6a043a@oss.qualcomm.com>
 <4c3bf92c-2434-46e8-8a3a-ab34cc50c72d@kernel.org>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <4c3bf92c-2434-46e8-8a3a-ab34cc50c72d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1OCBTYWx0ZWRfXzIIr4O9GGgrd
 PzhPnog5Q5R9zPw+ZPocM8ZrH4SwJZllhLo1OogVoGAOeQbQdbf7cXWnXvT5YlX2/8Cp103yS45
 Fi/v6yafvCsY8Rjs9Owsem6oezaKzIM=
X-Proofpoint-GUID: 8dLyf4N-9qrk3kr6_IHwyORmfEEURlBD
X-Proofpoint-ORIG-GUID: 8dLyf4N-9qrk3kr6_IHwyORmfEEURlBD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1OCBTYWx0ZWRfX4b6uYXZGkj8C
 bTtxFih8UIvadbpRkF9f3+RlRJ3TkyfWsmxY3rvk4xVu/z+Pl8Af5B8KpO9w2Gbos8QZiuSJ57h
 siyr871czBmfnuYefe5jy+ObgNafu+K66dxXOsnf9u5jnNdEHbDMc64jzYQNTzz7qJTVAocuFMs
 Q2hTAM/t7rmjM/Eg/TEANZqCznN0DsuIbJfhjIUMsmkVp2ca9r7J9O5jbpOJ3KxRyzW6WC+BPJT
 U0vVko0Hhk3YlsWSinKFZpvn+H/BXl8ud0ZJhX+0j0DoIJXzxAoHO6Ox3VFbl3dsciyqKUjYWej
 kg6bh2Li2bls+9IUBBZKJiWWPiOekJ1g3LhWeoOte2ADp8uv/CZsYiCcriHo1Lp1vnQ15whpmWo
 4sl9BYI9zqfh69MNQNDrlTRt+VD6Vw==
X-Authority-Analysis: v=2.4 cv=F7rC5ahN c=1 sm=1 tr=0 ts=6afc6708 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=fQRhRBuJyxsiCmdI730A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611170058



On 11/16/2026 6:56 PM, Krzysztof Kozlowski wrote:
> On 16/11/2026 11:36, Jyothi Kumar Seerapu wrote:
>>
>>
>> On 11/12/2026 7:27 PM, Krzysztof Kozlowski wrote:
>>> On 12/11/2026 14:47, Jyothi Kumar Seerapu wrote:
>>>>
>>>>
>>>> On 11/11/2026 6:07 PM, Krzysztof Kozlowski wrote:
>>>>> On Mon, Nov 09, 2026 at 08:03:29PM +0530, Jyothi Kumar Seerapu wrote:
>>>>>>
>>>>>>
>>>>>> On 11/9/2026 7:12 PM, Krzysztof Kozlowski wrote:
>>>>>>> On Fri, Nov 06, 2026 at 08:31:20PM +0530, Jyothi Kumar Seerapu wrote:
>>>>>>>> Add QCOM_GPI_QSPI to identify QSPI (Quad SPI) channels in GPI DMA
>>>>>>>> specifiers. Its value, 9, matches the GENI serial engine firmware
>>>>>>>> protocol ID for QSPI.
>>>>>>>
>>>>>>> What is GENI serial engine firmware? How does the Linux rely on it that
>>>>>>> we add bindings for it?
>>>>>>
>>>>>> Hi Krzysztof,
>>>>>> GENI firmware runs on the serial engine’s programmable sequencers and
>>>>>> implements protocols such as SPI and QSPI. Linux configures the engine and
>>>>>> submits transfers to it.
>>>>>> The existing GPI DMA specifier includes a client protocol ID. Linux programs
>>>>>> this ID into the DMA channel and selects the corresponding descriptor
>>>>>> format. QCOM_GPI_QSPI adds the QSPI protocol encoding 9 to that interface.
>>>>>> I will clarify this in the commit description in V2.
>>>>>
>>>>> Does not really answer. I see no reason why GENI firmware needs ABI for
>>>>> Linux.
>>>>>
>>>> This extends the existing GPI DMA binding, not a GENI firmware ABI.
>>>
>>> OK, so it is not ABI for the firmware. Period. Let's stop discussing this.
>>>
>>>>
>>>> The third argument of the DMA specifier in the dmas property selects
>>>> the peripheral protocol. The GPI driver programs this value into the
>>>
>>> Yes, so the third argument can be value of 6 because it has no meaning
>>> for the firmware.
>>>
>>> Again, follow standard DT bindings ABI rules, you don't get an exception.
>>
>> The existing GPI DMA driver and binding uses its third cell to identify
>> the client protocol. The driver takes that value from DT and programs it
>> directly into the channel's SCRATCH_0 protocol field.
> 
> So register value? Not a binding...
> 
>> Its mandatory to maintain protocol ID-9 for QSPI.
> 
> How can it be mandatory if we did not define in the bindings so far...
> 
Hi Krzysztof,

Existing SPI, UART and I2C use the same number for the DT identifier
and hardware encoding. gpi_of_dma_xlate() stores the third DMA
argument in gchan->protocol, and gpi_alloc_chan() writes it directly
into SCRATCH_0 without translation.

Neither 6 nor 9 has been defined in the upstream binding yet.
Would it be acceptable to follow the existing SPI, UART and I2C
approach and use 9 for both the DT identifier and hardware encoding?
Or should I use 6 for QCOM_GPI_QSPI and explicitly translate it to
hardware protocol ID 9 when programming SCRATCH_0?

Regards,
JyothiKumar

>>
>> Other protocol IDs which are not part of upstream are for AFC (6), SPMI
>> (7), HID_QSPI (8).
> 
> 
> 
> Best regards,
> Krzysztof

