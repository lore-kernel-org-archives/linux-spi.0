Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C08325491;
	Wed, 20 May 2026 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279386; cv=none; b=lQE/kY/IAB92bxPSgGidSpa1muWBrBLQUuLj5qX+MazPCy1rKpRzCCVQWYyBNH66tP1095PTyqzHlrieupaVWAoJYYMagqa2VRGT8RHUvwkrbAosMdvKqN+mThVxLR7Ar0PT5FLF5/zxQxBzuFRAm/R5pEEFyRpog3JIXDvVKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279386; c=relaxed/simple;
	bh=hzZNz6ctMumsjHO1/78mJTATMv6hQ4TV3TrboNOqPcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZhc2vYbJadD9R+AQeCPWxTuak79G+1QYtdHZWZT8HuI7ejNHjrfTBtpJA8SwJfUWpEFlevffnRfXI7UX7leeK/Fi/f4iGI9fftHvlAhfB/lFwluDt0YxUAvbaCVuVwXPIl2lTx1vEgOvZleForEsncBxmRcLbQMnYSuQqwtvGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbUHxJyU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbUHxJyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F691F000E9;
	Wed, 20 May 2026 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779279384;
	bh=JqTuzJtsBRIiyPsxwIfKOG4nQP71IFs5r3aLsh9ISxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VbUHxJyUsFhVwT85FqHb8mMzZuIuEhYNw7QUr23Zk8Qf0tES2o82nI1mob4uHK0bu
	 3WhYFxkVz3LZ68RuUB46NP9gUuiJ5okzpBXe8St6IDoDE9p7OKmnNOOppQP0N0vn9T
	 Fj7KYxmNwtql4aWPQdR+7hGZPVlvhmoW1BLz0KB4LdJPGSGy//3vBdGZBuncYH1PJo
	 jnyWzTH8iPj+uOkW/8NAFVxQtQ/fQqRwhE3trhh8gni8Mbx7hdaMLGvToeHQSfDh8U
	 cv7Co3NgzU1dz7iXcgtFW6vrs1nkSUxWBr55KuJ8S0LShne+jBPT1ZX2oOnDFZXUTy
	 4Zsw06IFIvABA==
Message-ID: <14719378-7bf5-4688-81e9-bccedf618d18@kernel.org>
Date: Wed, 20 May 2026 14:16:21 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: dt-bindings: cdns,xspi: add sdma-io-width
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260511031732.3199-1-jszhang@kernel.org>
 <20260511031732.3199-2-jszhang@kernel.org>
 <20260515-expert-devious-cricket-faff56@quoll> <agz0kDsQBaeQPPQ4@xhacker>
 <21d30826-bfe6-44cd-8c89-c1986f539e48@kernel.org> <ag2fjCX0DuSVxubv@xhacker>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <ag2fjCX0DuSVxubv@xhacker>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/2026 13:48, Jisheng Zhang wrote:
> On Wed, May 20, 2026 at 09:09:55AM +0200, Krzysztof Kozlowski wrote:
>> On 20/05/2026 01:38, Jisheng Zhang wrote:
>>> On Fri, May 15, 2026 at 10:00:50AM +0200, Krzysztof Kozlowski wrote:
>>>> On Mon, May 11, 2026 at 11:17:31AM +0800, Jisheng Zhang wrote:
>>>>> The cdns xspi controller SDMA data port may support wider I/O width.
>>>>> Wider I/O width can benefit performance. A simple test with QSPI nor
>>>>> flash on one arm64 platform:
>>>>>
>>>>> 1 byte io width (default):
>>>>>  # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
>>>>>  1000+0 records in
>>>>>  1000+0 records out
>>>>>  8192000 bytes (7.8MB) copied, 1.368735 seconds, 5.7MB/s
>>>>>
>>>>> 4 bytes io width:
>>>>>  # dd if=/dev/mtdblock0 of=/dev/null bs=8192 count=1000
>>>>>  1000+0 records in
>>>>>  1000+0 records out
>>>>>  8192000 bytes (7.8MB) copied, 1.088787 seconds, 7.2MB/s
>>>>>
>>>>> Improved by 26.3%!
>>>>>
>>>>> Add dt binding for sdma-io-width.
>>>>>
>>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/spi/cdns,xspi.yaml | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
>>>>> index 38a5795589de..1fd4b6dfd417 100644
>>>>> --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
>>>>> @@ -40,6 +40,12 @@ properties:
>>>>>    interrupts:
>>>>>      maxItems: 1
>>>>>  
>>>>> +  sdma-io-width:
>>>>> +    description: Slave DMA data port I/O width (in bytes)
>>>>
>>>> Waht is SDMA? What is Slave DMA? The same?
>>>>
>>>> Why this cannot be deduced from the compatible? DMA is fixed per
>>>> platform and SDMA do not sound like SPI device (so slave in older
>>>> terminology) property.
>>>
>>> in cdns xspi, sdma == slave dma. It can be read by any master, such
>>> as DMA engine or CPU. Its purpose and usage is similar as the data
>>> reg in other spi controllers, e.g the DW_SPI_DR in dw spi. 
>>
>> You did not really answer the questions.
>>
> 
> If you mean "Why this cannot be deduced from the compatible?", I think
> the slave dma port is part of the cdns xspi, so its io width belongs
> to xSPI device property.
> From another side, we have seen such property in other drivers such as
> the reg-io-width for the dw spi DW_SPI_DR port io width.

So you mean it depends on SPI device? Then why spi-peripheral-props is
not applicable here?

If this is not bus width, but DMA-something, is not really then SPI
device dependent, but rather DMA controller limitation, so either
deducible from compatible or something else is missing here.

Argument that some drivers do that is obviously wrong, so I am jumping
there.

Best regards,
Krzysztof
