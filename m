Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66633384238;
	Tue, 21 Apr 2026 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765949; cv=none; b=idNBhRzuqt5X6PzXDq0FXGVuyPIZCfAEHNjcDRwyDix3X6aTJJBNWVzESsmLOpc4udvWueReDPP8nv4mHJwrQaSdotbapcfA8o9QMJ+sWwr1iXUpCNQOVHr71rPIhWym4lhFwV8CIo7HtwiRKXaKazhAeUh++hy58hIqFwjuxnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765949; c=relaxed/simple;
	bh=+cfPG4Mw62gTIoG3jwVbg119dKxTwWwwWXPMp7K0Spg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9Res4EiGklPSJ/SHGKHMqze9OCSeCeQka9JbmQ0Twdi5Kiel8dKP7e8qFRW9WuMuboMH9OWh7dPAgJThHkjpacXS9Qc2IlUE/PXuBNfMhQr2iOnSriwttOTpENw4oLeV+0IFsvaPYO11BZwccGChlwqj7aZG58kzlKkZv1OSaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loyd4NgB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loyd4NgB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17B7C2BCB0;
	Tue, 21 Apr 2026 10:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776765949;
	bh=+cfPG4Mw62gTIoG3jwVbg119dKxTwWwwWXPMp7K0Spg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=loyd4NgBIvL5LpxBfsRYWIvtrBK/R9mCbiYhNrkdrZPI/KFIWmLrKxc9WAMMto6Qh
	 1rufGjMBvbBswFVQO7kSap7GzAXYhm+y72Vlo8e3FtzZOJMWX6F9u3uBbLgaLWZEN1
	 QBw0BEVM4PgqLLYyxjiCcL6+Qr0teePSKJiVDTXgwWXtFCYkL9+QLO1u26VjvkHbNc
	 CJaMaXkT/T3v0obgmY3m3mlEzoiQWsgvUS8yMu1xYAU8BuSzP3KbFtxlwKOvR+mzhw
	 7XhiGJ5jP285/qflOB1WPJCP7PsTKd9llua50dLfQOjWkOzpWsO2J/HNgR9cKMqzoC
	 TrYfak+FMysEw==
Message-ID: <9c9795b0-a8ba-453d-9a92-f07b3ca59070@kernel.org>
Date: Tue, 21 Apr 2026 12:05:45 +0200
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
 <eb1ae818-eb9c-4225-9969-ebbb05304697@kernel.org>
 <20260421095928.GB23508@francesco-nb>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260421095928.GB23508@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/04/2026 11:59, Francesco Dolcini wrote:
> 
>> Toradex LAVA hat is way too generic. No, single compatible string is not
>> sufficient, please read writing bindings.
>>
>> Please define exact model and variants.
>>
>>>
>>> The need is to be able to test SPI with a mainline Linux kernel, so I am
>>> looking for a solution that works in mainline Linux.
>>
>> incomplete devices do not stop you from that.
> 
> Do this sentence means that I can send a DT file for inclusion in the
> Linux kernel using a compatible documented in incomplete-devices?

No. You will be testing a mainline DTS + load non-mainline overlay. So
your requirements of "mainline Linux" are fully solved. Overlay is
loaded by bootloader for example and thus your kernel is fully mainline.


> 
>> But you don't get exceptions because you want to mainline your DTS. Your
>> need detailed hardware description and precise compatible per each exact
>> hat ("exists in multiple variants").
> 
> Let me get into more details here, before sending a new patch version.
> 
> We have various LAVA HAT devices, the difference is that they provide
> different features and a different layout, based on the actual carrier
> board they are mated with.
> 
> We have an "Aquila LAVA HAT", that can be mated with the "Aquila
> Development Board", and a "Verdin LAVA HAT", that can be mated with a
> "Verdin Dahlia Board".

Of course, because each device is specific so even the hat must be
specific, unless you have a standard connector like Arduino or RPi.

> 
> As an example, you can find the Verdin Dahlia DTS here,
> ti/k3-am625-verdin-wifi-dahlia.dts, that can be mated with the "Verdin
> LAVA HAT".
> 
> The SPI device on both "Aquila LAVA HAT" and "Verdin LAVA HAT", is the
> same, no differences. On the Aquila variant we
> have two instances of it, while on the Verdin we have only one instance
> of it.
> 
> So, would we need a compatible like this? 
> 
> compatible = "toradex,aquila-lava-hat-spi", "toradex,lava-hat-spi";
> 
> or
> 
> compatible = "toradex,verdin-lava-hat-spi", "toradex,lava-hat-spi";

Yes, assuming that verdin/aquila hat works for EVERY verdin/aquila
board, regardless what SoM or SoC you have there.

Verdin is a SoM family according to:
https://www.toradex.com/computer-on-modules/verdin-arm-family

and I doubt you can attach hat to a SoM. There is no connector on SoM
for the hat... so probably you have a board, like Dahlia.

Best regards,
Krzysztof
