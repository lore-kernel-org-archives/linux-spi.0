Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B43382F7;
	Mon, 20 Jul 2026 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542204; cv=none; b=hGHLWeJoNrnaDYLvD8DQ2DI9e0TaoBcKP7GyVmh2H3A3mOA6RfkuX57RJByzteJFUWolJPqzTfSput6xb6vlU54A8ZswgEhPUFZMszaSz9f/S/Wzt9xdBS0o/omfCkhA1xBrHr+R8prWReIyNs6yPy77j+l4nv0b/8b73F9LaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542204; c=relaxed/simple;
	bh=npr+WWNqUbcXJsxEZNgU8d7LOtvuNB4zxb8dbQ8E7ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5MKvrGs6WItlPy3dK6Wc+Hf9fxT1ENZ/bMlWl6zFgp0z5gAiwXcu1xZrNqdJBSH9/IHfNmpMV69V0/LanD+ZheBXHGL5yiGUmT05oeFXoxmg1wMjCObbU79uteBjgOFk4N8fhhGD9MWfqiGlmPZqnn3fnYh3KcKly9nuJn0pww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ectNk1uQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ectNk1uQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427B31F000E9;
	Mon, 20 Jul 2026 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542193;
	bh=7BUiU9YWdBA1/LmQhXS9ABRZ/4Tk1lj9wsXsLoSsUCU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ectNk1uQeNmQMIkdekUYiBkEC2RxqyWRxxwbPQuOMQWUiaKdnoRu5wlOY5EZ7sJaJ
	 tLR7r6Iftomc/55gXT2xuVlovQ0Aj7vwuGWtQ/qOqh5jiJAbxcTcTQ05DTJnG6kevK
	 l+fjssXYCfDEAjFqstKpMQ4xswGjX2fYR6YDk0COkL/EQlwiDhUV+R4SBjCdiajZ4D
	 GVavYMfNZno823ZhG5VKSamx7USc+14cB8OB48OLRaovLOoDKMzG1Ok1Xars2Ul8Pm
	 Qibl5md2nfZk5c53VJr1RvmxsGyyditztVTttkMplrJa5miUt+Wf9rhqV4k99Ix4Pg
	 nOLjTh1j79Fsg==
Message-ID: <1a681388-5ffe-4df9-83bf-a7622ee489bf@kernel.org>
Date: Mon, 20 Jul 2026 12:09:42 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/17] spi: dt-bindings: add
 spi-max-post-config-frequency-hz property
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, pratyush@kernel.org, mwalle@kernel.org,
 takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com,
 a-dutta@ti.com, Conor Dooley <conor.dooley@microchip.com>
References: <20260717185116.2065505-1-s-k6@ti.com>
 <20260717185116.2065505-2-s-k6@ti.com>
 <20260719-camouflaged-unyielding-sawfish-b6fd09@quoll>
 <3d470ec8-870a-4e14-90e8-6c7444950192@ti.com>
 <fba1531e-e416-4817-848e-94e9b3f3b501@kernel.org>
 <d6b3c768-bff2-40b1-b767-f17219281fb7@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <d6b3c768-bff2-40b1-b767-f17219281fb7@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2026 10:48, Santhosh Kumar K wrote:
> 
> 
> On 20/07/26 13:10, Krzysztof Kozlowski wrote:
>> On 20/07/2026 09:38, Santhosh Kumar K wrote:
>>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>>> index 880a9f624566..12211f8c9f7d 100644
>>>>> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
>>>>> @@ -45,6 +45,11 @@ properties:
>>>>>        description:
>>>>>          Maximum SPI clocking speed of the device in Hz.
>>>>>    
>>>>> +  spi-max-post-config-frequency-hz:
>>>>> +    description:
>>>>> +      Maximum SPI clock frequency in Hz achievable after controller-side
>>>>> +      configuration.
>>>>
>>>> How did you implement my feedback?
>>>
>>> Three points from your feedback:
>>>
>>> 1. -hz suffix: added
>>>
>>> 2. Array property: I still lean towards keeping this as a scalar for
>>> now, as we don't have a concrete use case for multiple values today, and
>>> supporting two frequencies should be sufficient for the foreseeable
>>> future. I had responded to this in the v4 discussion as well, you may
>>> have missed that response.
>>>
>>> 3. maxItems: Since the property remains a scalar, I have not added maxItems.
>>
>> So how did you make this property scalar?
> 
> The -hz suffix constraints the property to a uint32 scalar through the
> DT schema framework's property-units.yaml.

Hm, where? I completely missed that, can you point me to the specific
line? I see clearly that it is not a scalar.


> 
> Adding an explicit $ref or maxItems for a unit-suffixed property is
> rejected by dtbs_check with:
>   - "Standard unit suffix properties don't need a type $ref"

This I did not propose - the type is fixed.

>   - "Scalar properties should not have array keywords"

Cannot reproduce it.

Best regards,
Krzysztof
