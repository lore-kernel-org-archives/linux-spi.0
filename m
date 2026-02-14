Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561203090CA
	for <linux-spi@vger.kernel.org>; Sat, 14 Feb 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093878; cv=none; b=TVe1JBNXsV2KcR5Z2dCSJyOMm36XkXlfP/9ScHHZR3xLWoInHg2HXa3DBkdVEe4MQs5m/16BYpy+7xYfagYtI78C9QzbOdbIF3YB9YnMSIh4qYUM3Egi+gJGwzmk84RWr4HEAapD+8KLTLakz/UQp5n3gCFuXMSg2NYo1aMtGyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093878; c=relaxed/simple;
	bh=b07R7RxPek/KmyHQeUj6U27N2AGDo7QHGz1eUka/nFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mM0uvzG1KidxKzRH9iiZBX2BM26IXaRrkD9m/99XN77Tvqt/VHcm1RUbgBhQJ+QRufvDspiv/lz19I8wuRtTRKMid5XmWuaqNAe/E7IJfd1lvHDim1eTgy3mVSJDFpke/iVrMiq0M6pwf2yupgy+TmgO4CdkJYADj9952ZKYq9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oOoGkRD0; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oOoGkRD0"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-463ba60966aso106644b6e.1
        for <linux-spi@vger.kernel.org>; Sat, 14 Feb 2026 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771093875; x=1771698675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HD58WPQsaM06hdtRHJvptMU2qx/tHwI9jI/rWWMZj0Q=;
        b=oOoGkRD0wH32Pxb5whVmDFgikh4ZsFC+SSR7NYsOg4X/sstBiytVLmc26VZZMHUmQg
         HbmlMWPmHOugZJ3cnLHuCQdv7PfPKpsUSwFgQjg9H7FbFGlcBakK9K5yGBQo14P8u8fj
         VyjaPNkbE1Opc+tezMtt4SoLHPOOE5HFAnzZ2I+vauaOdLLNHY4463Ls/hj7l7d6kkxJ
         Ki9/Fli42cBpPx7IeJeyeTuGgfiD8h/avMP4mtnPunwIbeVxo2cLlKGocjLyEwsT45oC
         Xvi9DYbxrvJZJpVtO9GkOLHvZ5lzzimiXbWcFbEQh7guJc6Q1ZFOkab7PkuFCyVRgKe1
         1pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771093875; x=1771698675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HD58WPQsaM06hdtRHJvptMU2qx/tHwI9jI/rWWMZj0Q=;
        b=iZfg+nA3ifErKQo4Leto2dNAa88efhLKwoYn8E56BSsOtu+ChgWQsWcH/gli/jqoRl
         BdIocA5vUogmf8Gvrqn8fSzobHFrJke1TLgPW6i2fXQXbRMZzA50IqDUN8U82eY+lDF7
         J1BzZoGjirX5Q3U85XLrDK0sawFvu1ORKpbUR1w7Tt+i6YXF/XtSbMzseCtlNSU0iH3W
         Oa6Uq/JNe01btJzr+YBrnxpqfz1hxs2KwxLDW2bn6QKZLLUVSo/GhQZHB6ndB5ZXXLwH
         M9b8l7J2hAncrjdZgpXaTGAVf60pGSuPB6IgcBLvRbUO5gfW+NJfwsqRF2+B6Kal6Yrz
         Pebw==
X-Forwarded-Encrypted: i=1; AJvYcCUx4y5F4A3eDtZsjXyPzmdyiVzkKDT2mdyvntmwPtLDk/OrsUakMbY1eQ4VLJNP0W/EgojmIUpOS+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnwZpo+psKUgUVyjqgEVlUFo7IHeg902y84c9wZuTFvc1aAvZ
	vpuyevCIjt90f5bl6x1FJf1qa0ZJ0yF2w3pOgbzGXffiMsJd3xNliN17fs4DWbBHzWM=
X-Gm-Gg: AZuq6aK6FKdbsmHxo6C49lt7eRXtCSk8qDMkWHJMUrJb+IGgKuP7S//O59yBxYoAEuq
	68MtJPcJl1T3oDmVb2JUsbOG3wqFzON6kMFEirsdfHSd1nYbvgCb79UXEornQvhuovWdEuFbHSc
	T7nH48RF/v6oEb16MBAnsKMjgUDk/J4Okvt/eyvv17RqyBfKNg6k+CW2cpVt3EOCgGG/o9lRtne
	rXrP4bAdw8GzyusvpH/8CDN981r2OfkFfhStQ0IkIM3l9CFAMkSv+llqqz49mXelnBDX03u4HFI
	sQSO+G+qrekPa1t80NcjlTCMdC1IpTucVqH4OTKlsbead8fYQXiXPZzl9Tt2czvcRPCkBwK2J3f
	kZMtWyPhnU7PaUrbwQq8JFTbZ0Cl94E0t9mKHAffhpRuLYzgk5DNB8wsiwgAzgitSM49fSpGGZZ
	NypihGCwWwuxZ959ajkMaZMy7BjbfExtxr3MGDzxf9lIcozqCa6Zky0L3+8jrBrik/bnBteg==
X-Received: by 2002:a05:6808:1491:b0:45c:7306:505e with SMTP id 5614622812f47-463b40e3869mr1817198b6e.63.1771093875267;
        Sat, 14 Feb 2026 10:31:15 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:109:393c:254e:962e? ([2600:8803:e7e4:500:109:393c:254e:962e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee46a6fsm9779558fac.3.2026.02.14.10.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 10:31:14 -0800 (PST)
Message-ID: <897bd4d4-bbdf-4cbf-84f6-05c110d75d03@baylibre.com>
Date: Sat, 14 Feb 2026 12:31:12 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <aYiGj_TYelvJdVaR@smile.fi.intel.com> <20260214160852.6862b58d@jic23-huawei>
 <aZC6wIWDdS8J_1eJ@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZC6wIWDdS8J_1eJ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/26 12:11 PM, Andy Shevchenko wrote:
> On Sat, Feb 14, 2026 at 04:08:52PM +0000, Jonathan Cameron wrote:
>> On Sun, 8 Feb 2026 14:50:23 +0200
>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>> On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:
> 
> ...
> 
>>> I believe there is a better approach, what you need is rather a flag
>>> to SPI core to tell that this is the device with shared CS.
>>
>> Antoniu, this comment from Andy needs addressing before we move
>> on. It seems fairly fundamental and I'm not seeing a reply to it on list.
>>
>> I'm not entirely sure what Andy is suggesting will work but this
>> is perhaps a mismatch in really understanding what is going on here.
>> Andy, how would a flag work given they seem to be separately addressable
>> SPI buses. I think this isn't a shared SPI CS, but rather a device
>> with two entirely separate SPI buses. I think the only reason
>> we are bothering to implement it as a single device at all is the
>> shared backend.
> 
> My understanding that there are two devices that for whatever reason share

It is the opposite. It is a _single_ device with _two_ CS lines.

adc@0 {
	reg = <0>, <1>;
	...
};

> the same CS line. Yes, I probably misread the idea behind, but I meant
> some flag for SPI device that tells SPI core that the CS it wants is shared
> (maybe a high bit in the cs field or so), then CS core won't complain on
> validation about using the same cs number which is "already in use".

There was one existing user in the kernel of spi_new_ancillary_device()
that looked like this, so it seemed the right way to approach it. However,
code was added later that caused the primary SPI device to "claim" both
CS lines for itself and probably broke the one existing user of
spi_new_ancillary_device() (hard to tell without hardware to test).

The idea here was to unbreak that so we could use spi_new_ancillary_device()
just as in the existing use case.

The patch for that could have been a bit more strict to only allow the
spi_new_ancillary_device() to take CS 1 and fail otherwise, but users
are going to notice if it isn't working right anyway, so I didn't ask
for more checking.

> 
>> There is an argument that maybe we should be looking at how
>> to do data muxing backends to support the more general case of two
>> separate chips feeding into a single buffer, but that's a complex
>> beast and I'm not sure if it is something we actually need.

I think it would actually be quite similar to what is done in this
series.

> 
> Yeah, if possible I prefer to look at the (ASCII art) schematics
> on how the HW looks like (connections with busses and CS lines).
> 

