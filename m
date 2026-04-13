Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179CC303CAB;
	Mon, 13 Apr 2026 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092755; cv=none; b=n//g0W/zhHZUTBZx/pFucUhvoA8/fiGCGEhoVmoTJn53HLueL+zwqCZt1B+iWvFK6xwriu0tgkomsO+OHqRmpf1NzPbsktPzNz3VGBwKnyJ5HQ/uURRJMOw/QZD8nSqHdhRdUIIlA901nqJQ1sSULL7qOc94Yp5IlQBdfCHKFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092755; c=relaxed/simple;
	bh=Iu8U2UKqNM3IkKuWyjXe/EMJbbHXer9r5OHhYIDndqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0QvJ4Y54/yqv37kw2sraOj5JB4JbV3tv/3Nbewufe4HZdyoEXaCyIQPGaeoB88+gpqal80dZYI86gzePHxhrBZzt/iZeI1Dd5rvhjD1qrw+HFxjoEIv4p/opbKE3vmbOf+oDF+IPM5LoTHf/LAPpmjYZ+7M1aVgUZU/RoyO7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVgRikja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVgRikja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4D6C2BCB0;
	Mon, 13 Apr 2026 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092754;
	bh=Iu8U2UKqNM3IkKuWyjXe/EMJbbHXer9r5OHhYIDndqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tVgRikjae0C071EgJUFCE9RQSB1F3Hc/8RPCFBt4If6ZQn3kPrzGSBA5LuC/6JTUj
	 yAcWO79tFg390aaUfj8hv2LZAttf/U8OOeXBs9LqajenJPcm6eLqEFXxWWaUqUYc3V
	 OZNxVbWESWYwRx54WYXWsB1MxB+NObt/h1u5yEZogFpIQo354ka84jaZtrNC2xQjIh
	 j1grB/2R+/hs+/ERT6X5uP+Bjm32MaN32MTgnepJjpvWz/SCB2/FfQcim99Zq6tU13
	 3VU95pgYpn7iK9U9i2d5b6lH8yxND/3SkQ+CsLMR+ltczRHiZ4F9ecPPNuCZlLRFQN
	 ItoUGs2cg8yXA==
Message-ID: <6dea7a2f-5730-4fa4-a093-53f663c6a8eb@kernel.org>
Date: Mon, 13 Apr 2026 17:05:50 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] platform/x86: serial-multi-instantiate: Fix SPI
 chip select on platforms with incomplete ACPI cs-gpios
To: Richard Fitzgerald <rf@opensource.cirrus.com>, Khalil
 <khalilst@gmail.com>, broonie@kernel.org, ilpo.jarvinen@linux.intel.com,
 Andy Shevchenko <andy@kernel.org>
Cc: linux-spi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, Khalil <khalil@rentman.nl>
References: <20260413100530.580649-1-khalil@rentman.nl>
 <20260413100530.580649-3-khalil@rentman.nl>
 <6af0a67a-c028-45c5-b514-52570ecfcc68@kernel.org>
 <a451416b-80a6-439f-8340-e53e4b30d87a@opensource.cirrus.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <a451416b-80a6-439f-8340-e53e4b30d87a@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 13-Apr-26 2:51 PM, Richard Fitzgerald wrote:
> On 13/04/2026 12:43 pm, Hans de Goede wrote:
>> Hi,
>>
>> On 13-Apr-26 12:05 PM, Khalil wrote:
>>> Some HP laptops with Intel Lunar Lake and dual Cirrus Logic CS35L56
>>> amplifiers over SPI have an incomplete cs-gpios property in the SPI
>>> controller's _DSD - it only declares the first chip select. The
>>> remaining chip select GPIOs are defined as GpioIo resources in the
>>> peripheral's ACPI node but are not referenced by the controller.
>>>
>>> This causes the SPI framework to reject devices whose chip select
>>> exceeds num_chipselect with -EINVAL, preventing the second amplifier
>>> from probing.
>>>
>>> Fix this on known affected platforms by:
>>>
> 
> <SNIP>
> 
>>> +
>>> +/*
>>> + * ACPI GPIO mapping for the chip select GpioIo resource.
>>> + * Maps "cs-gpios" to the GpioIo resource at index 0 of the ACPI _CRS.
>>> + */
>>> +static const struct acpi_gpio_params smi_cs_gpio_params = { 0, 0, false };
>>> +
>>> +static const struct acpi_gpio_mapping smi_cs_gpio_mapping[] = {
>>> +    { "cs-gpios", &smi_cs_gpio_params, 1 },
>>> +    { }
>>>   };
>>
>> I'm confused here you say that the chip-select for the second amplifier
>> is missing, but I would expect that to be the GpioIo resource at index 1
>> not 0?
>>
>> I would expect the GpioIo resource at index 0 to be for the first
>> amplifier which does have a GPIO already in the _DSD cs-gpios property ?
>>
>> Since this is a multi-serial device ACPI node, there is only one
>> set of resources for both amplifiers (with their also being 2 SPI
>> resources in the _CRS list).
>>
>> So I would expect there to also be multiple GPIO entries in the
>> _CRS list, with the order of the chip-selects GPIOs resources matching
>> the order of the SPI resources.
> 
> You can't assume that. There is no ACPI reason why the GpioIo should be
> in order of chip selects. In fact, some manufacturers scramble them
> (e.g. CS2, CS1, CS3). You have to remember that the ACPI is written so
> that it works with Windows (which is the reason we need this serial
> multi-instantiate driver.) so it may contain Windowsisms.

Right, in that case maybe we do need the DMI quirk and the DMI quirk
needs to point to a specific struct acpi_gpio_mapping for that model
laptop ?

Either there is some logic and the code can be generic, or there
is no logic and then we need to not pretend that the code is generic.

And in my mind the current code at least pretends to be somewhat
generic.

Thinking more about this, I do not think that the current patch does
what it is supposed to do at all.

According to the commit msg there is 1 GPIO listed in the _DSD
props and the ACPI lookup added is using the same "cs-gpios" conid
as the _DSD dependent code in drivers/spi/spi.c and it is getting
the gpio with:

smi->cs_gpio = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);

which is equivalent to:

smi->cs_gpio = devm_gpiod_get_index(dev, "cs", 0, GPIOD_OUT_HIGH);

which is the same lookup as the already succeeded lookup of CS0
in drivers/spi/spi.c .

for CS1 the lookup should be:

smi->cs_gpio = devm_gpiod_get_index(dev, "cs", 1, GPIOD_OUT_HIGH);

and the struct acpi_gpio_mapping should point to an array of
acpi_gpio_params[[] with 2 entries, with the first entry
duplicating the GPIO from the _DSD info and the second entry
pointing to the actual CS1 chip-select.


Andy, you know the ACPI gpio-lookup code better then me, can
you confirm that since the con_id between _DSD props and
the added acpi_gpio_mapping is the same that calling:

smi->cs_gpio = devm_gpiod_get(dev, "cs", GPIOD_OUT_HIGH);

aka:

smi->cs_gpio = devm_gpiod_get_index(dev, "cs", 0, GPIOD_OUT_HIGH);

will just return the GPIO from the _DSD again ?

Regards,

Hans

