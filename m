Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C032C2DC783;
	Tue, 21 Apr 2026 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761219; cv=none; b=d0sti2ODVksXIGP6jyNBl8mLxMc3aO1erY1ehcG6nCqMbu3NIX0C4H0yRnGZGdY1JxGWk1/qmYmCakDPCREA8RLHTYa2K/uprlDS5zylZ1A3T10Hoqx8cb/6Fj1YHLum9FK79lKWPrZJouNn7u7aMDq5afei+i4WUy/3UFrB9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761219; c=relaxed/simple;
	bh=P2sLB2zT3iVQj9YGkWcLvciVcbDcFv3aDchjxcINyac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9U7G4j+watxxHdBSGyIQ5fEDwb+cR54GigmbBP69PKzDZRHx6D6yIh1xj0KLvNHdlahv5iZlo0KCcOUWIFquU/YC30QRIARY2wIeThlGt/b024ZFx9jVppdFlo1xf8ubyB+u4gaXmZhP9WafctD2vm7mmGiP+kOwiiEUm7F4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDzvRz7A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDzvRz7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B802C2BCB0;
	Tue, 21 Apr 2026 08:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776761219;
	bh=P2sLB2zT3iVQj9YGkWcLvciVcbDcFv3aDchjxcINyac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rDzvRz7AfjXRGiU9f3gXMmOxNa0qk8ii3PC9+yGieLom9iOlOd9RDAWdsnOyibC3y
	 jMAWupELQdDjZNNCfhXkxWMHLTrKEZVyQ90DSEnb8lzYO+hGSkCv2RHXNpVybFUMML
	 qyktilv8tZ8YEV3Q0fMmx2wsgyu5YLfYRf8yGfGiK/F4dzFwRmU+wy8w+KcaezcJr6
	 O8rqRSDom478LZs284MP/td6yXsumoQkuRJKaDjkjO29gB/hpu1HLruXbqQ/ZH/Pdx
	 V//p7mBz5sCHSqQNvPC71GiyYG96zrgfzBvvOMnDxEshjovnvUfZKdMbnaStMfchuB
	 55DQPhfg8etVw==
Message-ID: <eb1ae818-eb9c-4225-9969-ebbb05304697@kernel.org>
Date: Tue, 21 Apr 2026 10:46:55 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: trivial-devices: add
 toradex,lava-hat-spi
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <20260420114537.78160-1-francesco@dolcini.it>
 <20260420114537.78160-2-francesco@dolcini.it>
 <20260420-task-navy-370ea247fe1d@spud>
 <005d96ea-b250-4af8-9c5b-d145bae892e5@kernel.org>
 <20260421083843.GA23508@francesco-nb>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260421083843.GA23508@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/04/2026 10:38, Francesco Dolcini wrote:
> On Mon, Apr 20, 2026 at 06:10:08PM +0200, Krzysztof Kozlowski wrote:
>> On 20/04/2026 18:02, Conor Dooley wrote:
>>> On Mon, Apr 20, 2026 at 01:45:35PM +0200, Francesco Dolcini wrote:
>>>> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>>
>>>> Add a compatible string for the SPI loopback device present on the
>>>> Toradex LAVA HAT test fixture.
>>>>
>>>> The Toradex LAVA HAT is a board used for automated hardware-in-the-loop
>>>> (HIL) testing, it provides several test-related functionalities, and
>>>> exists in multiple variants depending on the board it is mated with. The
>>>> SPI function is implemented with a loopback on the MISO/MOSI signals.
>>>>
>>>> As the device can be fully described using only "compatible" and "reg",
>>>> it is appropriate to list it under trivial-devices.yaml rather than
>>>> introducing a dedicated binding.
>>>>
>>>> The SPI implementation is identical across all Toradex LAVA HAT
>>>> variants, so a single compatible string is sufficient.
>>>>
>>>> Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
>>>> Link: https://lore.kernel.org/all/20260316073547.11437-3-francesco@dolcini.it/
>>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> pw-bot: not-applicable
>>
>>
>> Heh, let's wait. That's a test device, so it won't be ever used in any
>> final product, right? So not in final DTS?
> 
> It will be used in various DT overlay, that I plan to send for
> inclusion in mainline Linux kernel once we have a way forward. So yes,
> there will be DTB files using it.

Then you need to document it properly and post the DTS.

Toradex LAVA hat is way too generic. No, single compatible string is not
sufficient, please read writing bindings.

Please define exact model and variants.

> 
> The need is to be able to test SPI with a mainline Linux kernel, so I am
> looking for a solution that works in mainline Linux.

incomplete devices do not stop you from that.

But you don't get exceptions because you want to mainline your DTS. Your
need detailed hardware description and precise compatible per each exact
hat ("exists in multiple variants").

Best regards,
Krzysztof
