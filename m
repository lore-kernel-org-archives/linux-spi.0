Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794935100;
	b=iByOMAb0pbiammVufesLXDQeiMO7tLsG52Pnq+hIWzfRGHLbBkgoiXErj8ZG09E/es8G
	 B4hTsbgrQO1wc15UDNHfeYdO9KbrJgkOFOlBPo5BCput0XhIVSnuW2t2AEzYz8juGe2sp
	 vHjn/vW0wXnKxCOMQBx5fCk4Gos7xef1Y/I/octJKw1pw2G042cX8MzAc8KuHpb0qHWhC
	 mcDjuZUvASjkkz786V8MunrWyZWBjZmOUyVd9RRd9X3aJ5txZRYspJck9xFPxMK01F+cr
	 Pggv/ayyK5tqf5sAX41MApfEZgQxwGMFv2p22lI6ImMbybuyBXpYnWSWRz6FraUVnsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935100;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Yw5ELRHrebd6o1qt73LR6t8y7TmlfyCU3l58M6QwR7w=;
	b=JmUC9SzIAtwutYyn2TljgeFRUBuu7mqg/biB9W0FmVEjrfv6SU6Ur6vg5b/qPIbsAgrr
	 xDbD0omjXqy0RGjvuNdZT1k6RegNBPrmScNz3b7iPjpU9ZeoZP1VlJduG/6mhen7BnpCw
	 e5sIwlbsOT2T9QyMr7LN+bDYhGR6u7OtxFvi4kSCUtnJhpYI960XwKxSpldgkYHb/+UTN
	 6vShMGy2B1Jb4C2+EJf6zwdel0/p25CjnpKkd1swCaHnMmzDMMw2EeWOGhLYCj5k43uo6
	 KXRwVbOsPjTCvA/rGQ0XCdCnHiLDKZuJ1e3ZrH3oibyc0ewnkTBqdevuMcB9F9QOyzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nyuVXcGA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YaDkS1PN;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FAC606A331
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 17:05:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FAC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nyuVXcGA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YaDkS1PN
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHGU5LH1139778
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 17:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yw5ELRHrebd6o1qt73LR6t8y7TmlfyCU3l58M6QwR7w=; b=nyuVXcGAiDP4aVXO
	z1RgkoxOVW7+/sVv5pcO9u1QXiaM0TfbPBGuOpoBiYf/HVdKfdb26XyWX3wIsoIl
	jlKFzPn1P21p3H3Ste7ejwZg8h6TKBK7LfcvV+NJLv30w8x+cMMYSkjTahDXbz6x
	gU7epuiMJ68FJnLn2hbbxugCiULB4JFuwMn1CJhG/eExTI+pzcZthmS9yPuQ3/zQ
	I1Lh8605U5WXZ4Sge+fSxACNh4MJ+owCNwhegcJfgMUVo/l0FIhaMSsde2OFz/lm
	xN9I/Ja54llIy2W2q6HzDeD49C6h++iFl9iRp/0VyBLDBMJC9RRdoaC18ojsO7F/
	0WFJjw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0hkd2kws-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 17:04:59 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso132437eec.0
        for <linux-spi@vger.kernel.org>; Tue, 17 Nov 2026 09:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794935098; x=1795539898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yw5ELRHrebd6o1qt73LR6t8y7TmlfyCU3l58M6QwR7w=;
        b=YaDkS1PNAfOO9tQ0ds7P9BjTcceoqIrc5Zx3VZo8zfzpR7yHO1X2NuDae18MNq+aO7
         MdByodqPsMvGISbmn3qNjJIpJI/BBSw/PtvaBSQ64TLSVH72JmOcgAW7U9NpnRvXlcza
         pbR5HDs+20lc/ypMsML1NHjM+fJgxIkJd0BPHwNE/OzajCzLilg8dRoJ17Vw3McJnutr
         HeCZjEH8a3ZKKzAJjcAmLU++oIeMKEP1DCidTElKcdr/8s88T66n8vBDrNJXoxale878
         sztx7IpNKc1QM7QyT2bpKvtCmsfp1lylEoDspZNw/a/2upB86DjHo5kfsDUJyzGfS+Qs
         t7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794935098; x=1795539898;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yw5ELRHrebd6o1qt73LR6t8y7TmlfyCU3l58M6QwR7w=;
        b=TKp8OzYMq71cR0FaQtspB74yXFOJxWXjZMcqiXGTL8hIih4am903FPrbqqhrvvkP2K
         fWMxu11GBS4SJwQRYHdlVfxwjZWk788AteI2t3B2cms93QFO4rLzAxWhgrtem3tg+N9I
         5wuZiOn7FSZtQlLmOsjvrQmzcMGBQ0acdjNXhuBbKmURGzBhYsqxymLXE1OMSY9ZhU04
         pHCNAeZEqoBRQnYPxvZMwS/alu60eKeOv6Wxr54XLoprS6bgRPkrE5HpGan0wQf1YqPk
         dHsyzJTxJF0wMX6eX+DgBf4ww54WMXjuvjGE7dLRzny08leU2bFH1xwWrG6GmwQ5+Upt
         vmXw==
X-Forwarded-Encrypted: i=1; AL+hErFbCalnbz3uKCDEEZnLjhRit6qXdHTPC9xBnLQBE5CBbGpyJYKrLzl22aZgNnsRnbmye/tZKPfzZvU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8nK7ijCG3s0wmi8RbNCUybE8PQeqj/FI+6pW4UZJVkPVF8XEQu
	8/YdLoN8R9CXjypKu5UiSqu1QeFfdnps3UWrg6b3cEqeZCWT97OAnDnOad0UN/v7nOQ5an1Z9eH
	aaQ9emrMC0jTktuW9ke5G6ERXykO9cdlsLUaGLULnkOyTGf71Fffg7rAnxd6Xn4M=
X-Gm-Gg: AZFdTZcKprouWVb8zelqXxuTEjPyPK1m9C8rIu0ci/kscXK0KYlYr1n5e7zOdqY41lx
	Z7u8MoO/XADcRHsp5YgPK0HO8pUz5QxX/gQbq+H2fYoFSSlfGj3t7yb6EFoXAJdb/k1QMK66dI8
	GR+Cgurnun5N006CjQ0fiDaPZlzvAO/4ZFpqbGLogpYd8tmY85E/ruuJzQ+pWO2uob1JDB05w5z
	44qkgvyT1eEDchQ4A4grzYZz2cpggGrnDerTRgq9o/EqdfeI4B8sq6Cg74VhG9qYE2yNlqNsvl0
	vYGPZPJGfx3uXzhfJdb0DXqJdBwften4L6Oj5YKA8KSwWDc3KoYw9kFm/k8H+115DPJ1MXd/Fou
	HFU5aRFum/n/lGdzxGIlfTujEHxCrbYbgSw5VZIkFDeaSVHmK0cyJq3b16OR0sFaG430gMEENA/
	rvtZ+pjuw5DShRXx3m
X-Received: by 2002:a05:693c:6011:b0:366:9f06:3c4c with SMTP id 5a478bee46e88-3828190b173mr37196eec.32.1794935098065;
        Tue, 17 Nov 2026 09:04:58 -0800 (PST)
X-Received: by 2002:a05:693c:6011:b0:366:9f06:3c4c with SMTP id 5a478bee46e88-3828190b173mr37163eec.32.1794935097390;
        Tue, 17 Nov 2026 09:04:57 -0800 (PST)
Received: from [192.168.1.66] ([103.172.4.28])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm68957328eec.8.2026.11.17.09.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 09:04:56 -0800 (PST)
Message-ID: <427ecaf2-9a09-4829-a598-11298e507614@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 22:34:50 +0530
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
 <d55bbf0a-3556-420f-852d-7a15ed8d5aac@oss.qualcomm.com>
 <276f1579-6a5f-4093-a0f9-53c6808df32e@kernel.org>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <276f1579-6a5f-4093-a0f9-53c6808df32e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eqFKXYpX c=1 sm=1 tr=0 ts=6afc893b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=kYVgg70FI5gtGbgwxQSixA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=9IG9TpRuJpbhppyfOHcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2NyBTYWx0ZWRfX+ZbnZxPqlIwj
 72QQh43IiZz8un5c43x1SB6P2RxgQlLYPn8rf8TwM++MNf2eBCDUJB92AI7sM0M+TLk4O72O24Y
 wD9tmbStugSWXQQ6ac0b4OlZuC2PzV8=
X-Proofpoint-GUID: 13WHiMcJAwwjN4DpLmyLFOLUfIZ_qXya
X-Proofpoint-ORIG-GUID: 13WHiMcJAwwjN4DpLmyLFOLUfIZ_qXya
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2NyBTYWx0ZWRfX4RWvZdB75ncn
 WsYO41ammRXttpCAW0DynDs+aRINhW2dqrtr1uuABf35Hi3N+H61U1Yi8I+bf/1OFD65p0hJ0EQ
 zCaChIFypgqhEpf8bjTJMvhwSq8877fxjYxKnwPMjN8a4k/2j0GMDOPbxKO1XcTeV9XXXkL7fu2
 GzMXO8c4yBdo1cuAWQo1cvy2UdUe5JBUW0jpUNz1/I+oOxjSQ8YZLi5DQTcw/RY7T3b4lGntPLZ
 vKxJ6BvDuyx9t7UdQj9mNbKPhzTG9WxkkWj3ZFfcV/1t94/IDgho2PEpRW5fpfhrtynh8tReTyI
 mWW+G2HP/GInWo/Nnyh042FTRxIJpv4nhwjQhxZH+0Q7q1rrzfyrCbaGQJpjpbHQK+1QzSZRZ7X
 bwvQXaVOYqjhpkR137WWNo/dCLI+1Xc8ioUQmUO3hUEpBu6z1E/HtYgRqLSY7bz6eLugNe0bWAq
 a8qbcIcSCH1DUYQoNdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170067



On 11/17/2026 8:34 PM, Krzysztof Kozlowski wrote:
> On 17/11/2026 15:38, Jyothi Kumar Seerapu wrote:
>>
>>
>> On 11/16/2026 6:56 PM, Krzysztof Kozlowski wrote:
>>> On 16/11/2026 11:36, Jyothi Kumar Seerapu wrote:
>>>>
>>>>
>>>> On 11/12/2026 7:27 PM, Krzysztof Kozlowski wrote:
>>>>> On 12/11/2026 14:47, Jyothi Kumar Seerapu wrote:
>>>>>>
>>>>>>
>>>>>> On 11/11/2026 6:07 PM, Krzysztof Kozlowski wrote:
>>>>>>> On Mon, Nov 09, 2026 at 08:03:29PM +0530, Jyothi Kumar Seerapu wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 11/9/2026 7:12 PM, Krzysztof Kozlowski wrote:
>>>>>>>>> On Fri, Nov 06, 2026 at 08:31:20PM +0530, Jyothi Kumar Seerapu wrote:
>>>>>>>>>> Add QCOM_GPI_QSPI to identify QSPI (Quad SPI) channels in GPI DMA
>>>>>>>>>> specifiers. Its value, 9, matches the GENI serial engine firmware
>>>>>>>>>> protocol ID for QSPI.
>>>>>>>>>
>>>>>>>>> What is GENI serial engine firmware? How does the Linux rely on it that
>>>>>>>>> we add bindings for it?
>>>>>>>>
>>>>>>>> Hi Krzysztof,
>>>>>>>> GENI firmware runs on the serial engine’s programmable sequencers and
>>>>>>>> implements protocols such as SPI and QSPI. Linux configures the engine and
>>>>>>>> submits transfers to it.
>>>>>>>> The existing GPI DMA specifier includes a client protocol ID. Linux programs
>>>>>>>> this ID into the DMA channel and selects the corresponding descriptor
>>>>>>>> format. QCOM_GPI_QSPI adds the QSPI protocol encoding 9 to that interface.
>>>>>>>> I will clarify this in the commit description in V2.
>>>>>>>
>>>>>>> Does not really answer. I see no reason why GENI firmware needs ABI for
>>>>>>> Linux.
>>>>>>>
>>>>>> This extends the existing GPI DMA binding, not a GENI firmware ABI.
>>>>>
>>>>> OK, so it is not ABI for the firmware. Period. Let's stop discussing this.
>>>>>
>>>>>>
>>>>>> The third argument of the DMA specifier in the dmas property selects
>>>>>> the peripheral protocol. The GPI driver programs this value into the
>>>>>
>>>>> Yes, so the third argument can be value of 6 because it has no meaning
>>>>> for the firmware.
>>>>>
>>>>> Again, follow standard DT bindings ABI rules, you don't get an exception.
>>>>
>>>> The existing GPI DMA driver and binding uses its third cell to identify
>>>> the client protocol. The driver takes that value from DT and programs it
>>>> directly into the channel's SCRATCH_0 protocol field.
>>>
>>> So register value? Not a binding...
>>>
>>>> Its mandatory to maintain protocol ID-9 for QSPI.
>>>
>>> How can it be mandatory if we did not define in the bindings so far...
>>>
>> Hi Krzysztof,
>>
>> Existing SPI, UART and I2C use the same number for the DT identifier
>> and hardware encoding. gpi_of_dma_xlate() stores the third DMA
>> argument in gchan->protocol, and gpi_alloc_chan() writes it directly
>> into SCRATCH_0 without translation.
>>
>> Neither 6 nor 9 has been defined in the upstream binding yet.
>> Would it be acceptable to follow the existing SPI, UART and I2C
>> approach and use 9 for both the DT identifier and hardware encoding?
> 
> Not 9. The next identifier for new constant used in ABI, as expressed
> many times on the lists, is the next free number. "Next" means
> incremented by 1. That would be probably 6.
> 
>> Or should I use 6 for QCOM_GPI_QSPI and explicitly translate it to
>> hardware protocol ID 9 when programming SCRATCH_0?
> 
> The ABI is between drivers and DTS. Whatever your hardware needs, it
> needs to be programmed by the driver.
> 
Sure, i will update the changes in V2 patch.
> Best regards,
> Krzysztof

