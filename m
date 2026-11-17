Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927898;
	b=yGVhN4nTa/UslaI43OM+yLfVQzgA9RJv4YjlfobE5h4nxrzrwoPdM0HYFasK1CHxJcL1
	 vVJPqN03hlXnaSlN9QTKIsv/EtNv3vO7DqJS5zwnCGMzdfBV/vVNOEbJLLtqe8QZ5DiQ6
	 FFjYVkMS3Ptj9JYrVx6evndsE+2c9flvX+XRabH/PDhewPLYZ7/l73v4J8nYKFYGlxQY4
	 950jih+0qDePOlWfiZKg9DJe12774rlGDAHniJ82ISj4IeXHDrOO69Su8WATmtSCN7myp
	 ZYZh98xvcsEqXJSzreNM6EU0YC67mupSPOL5kf7XFLizuLFS6pTZ1+U0ewRlf0RVo9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927898;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+2+jKbj3rJsLPI0jE69GCb4eSzlpgrBv0Acxrzb+peA=;
	b=3XpsNe+MoFglkmWEL/iLlXO4XBbTqZknZDkN7SK0qHSrJUZGB1GRwqrpR0sDnzBRioTi
	 jXPfm8O65LaEmw7HVuqXsObq82snFujtJemqz2x1TK6cto7oDda35n+BhEl5nevWHCsUK
	 /d901FjFl5OpWh45SCaRn8O/D0iYfwi8QvAgb4n78NfnlTCFYiio2KztikjtyUGXxdbqN
	 enT3VXi3C48W8ogAWIBvNmY6qUypnBxMApFLkwXgNAG4gTXLeQa9U9YJeu4WrI9R9GAXS
	 FCSMn32yEBFrFvE0R6CJbjViYXYazNjZRDe+P/WpiHZIzslRDlEvmSC2x6OezBSNYfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3xTWLwh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFEB606A335;
	Tue, 17 Nov 2026 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g3xTWLwh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E331F000C4;
	Tue, 17 Nov 2026 15:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927898;
	bh=+2+jKbj3rJsLPI0jE69GCb4eSzlpgrBv0Acxrzb+peA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=g3xTWLwh3JDSj0D5vSMlMdYVzSiFSJ8SJHg+fhfgc9bww32u6X0CkRunockP5G2sC
	 WmFh91pLvrV4rI77/qJReGtOMeuRkpgt6xaBJhsdDm1eC9IVmVhy0suJsj5CPR3ZiL
	 mHp11yfKsIzQqbN3UV7dX1wfNxJg7p5AikRl2f81vF9u+H9SU/g3K7ynCtaDtOs/MM
	 PYxA7Kz+kpHpG5lVBJdzmOHzwsMSeavo04cDwxeioT4EXw4HmKHo1ahGkbZMW2E12S
	 3SWpX4L6ADCOeF00o+uSppnBnI2TpTw4qrJha26EOqrHYKHnOcsYiiHNQ3qmvm2l3C
	 JIiFVCGdLDing==
Message-ID: <276f1579-6a5f-4093-a0f9-53c6808df32e@kernel.org>
Date: Tue, 17 Nov 2026 16:04:51 +0100
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
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <d55bbf0a-3556-420f-852d-7a15ed8d5aac@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/11/2026 15:38, Jyothi Kumar Seerapu wrote:
> 
> 
> On 11/16/2026 6:56 PM, Krzysztof Kozlowski wrote:
>> On 16/11/2026 11:36, Jyothi Kumar Seerapu wrote:
>>>
>>>
>>> On 11/12/2026 7:27 PM, Krzysztof Kozlowski wrote:
>>>> On 12/11/2026 14:47, Jyothi Kumar Seerapu wrote:
>>>>>
>>>>>
>>>>> On 11/11/2026 6:07 PM, Krzysztof Kozlowski wrote:
>>>>>> On Mon, Nov 09, 2026 at 08:03:29PM +0530, Jyothi Kumar Seerapu wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 11/9/2026 7:12 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On Fri, Nov 06, 2026 at 08:31:20PM +0530, Jyothi Kumar Seerapu wrote:
>>>>>>>>> Add QCOM_GPI_QSPI to identify QSPI (Quad SPI) channels in GPI DMA
>>>>>>>>> specifiers. Its value, 9, matches the GENI serial engine firmware
>>>>>>>>> protocol ID for QSPI.
>>>>>>>>
>>>>>>>> What is GENI serial engine firmware? How does the Linux rely on it that
>>>>>>>> we add bindings for it?
>>>>>>>
>>>>>>> Hi Krzysztof,
>>>>>>> GENI firmware runs on the serial engine’s programmable sequencers and
>>>>>>> implements protocols such as SPI and QSPI. Linux configures the engine and
>>>>>>> submits transfers to it.
>>>>>>> The existing GPI DMA specifier includes a client protocol ID. Linux programs
>>>>>>> this ID into the DMA channel and selects the corresponding descriptor
>>>>>>> format. QCOM_GPI_QSPI adds the QSPI protocol encoding 9 to that interface.
>>>>>>> I will clarify this in the commit description in V2.
>>>>>>
>>>>>> Does not really answer. I see no reason why GENI firmware needs ABI for
>>>>>> Linux.
>>>>>>
>>>>> This extends the existing GPI DMA binding, not a GENI firmware ABI.
>>>>
>>>> OK, so it is not ABI for the firmware. Period. Let's stop discussing this.
>>>>
>>>>>
>>>>> The third argument of the DMA specifier in the dmas property selects
>>>>> the peripheral protocol. The GPI driver programs this value into the
>>>>
>>>> Yes, so the third argument can be value of 6 because it has no meaning
>>>> for the firmware.
>>>>
>>>> Again, follow standard DT bindings ABI rules, you don't get an exception.
>>>
>>> The existing GPI DMA driver and binding uses its third cell to identify
>>> the client protocol. The driver takes that value from DT and programs it
>>> directly into the channel's SCRATCH_0 protocol field.
>>
>> So register value? Not a binding...
>>
>>> Its mandatory to maintain protocol ID-9 for QSPI.
>>
>> How can it be mandatory if we did not define in the bindings so far...
>>
> Hi Krzysztof,
> 
> Existing SPI, UART and I2C use the same number for the DT identifier
> and hardware encoding. gpi_of_dma_xlate() stores the third DMA
> argument in gchan->protocol, and gpi_alloc_chan() writes it directly
> into SCRATCH_0 without translation.
> 
> Neither 6 nor 9 has been defined in the upstream binding yet.
> Would it be acceptable to follow the existing SPI, UART and I2C
> approach and use 9 for both the DT identifier and hardware encoding?

Not 9. The next identifier for new constant used in ABI, as expressed
many times on the lists, is the next free number. "Next" means
incremented by 1. That would be probably 6.

> Or should I use 6 for QCOM_GPI_QSPI and explicitly translate it to
> hardware protocol ID 9 when programming SCRATCH_0?

The ABI is between drivers and DTS. Whatever your hardware needs, it
needs to be programmed by the driver.

Best regards,
Krzysztof
