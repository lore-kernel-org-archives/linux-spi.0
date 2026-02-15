Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEB8246335
	for <linux-spi@vger.kernel.org>; Sun, 15 Feb 2026 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771197414; cv=none; b=UetGGUL5EbSZtibSg4sqan5z5LOsV2KEgiIdxKQ94PNsjiyFGqjgm8sWLsD/oaWvaK/wN5hl3k7dxu2p89p34dzpx2jN59L6CdlsPWwCHpeHi0lvqgnwUykinoQ9zarAExt7pjt/acUv5meJMrH5GhJ0n0ls9MgaifK0iY2IKks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771197414; c=relaxed/simple;
	bh=IIxZfD2J0H7/pfKT+MMLWR55fWvYhFDMw9U/IiMvqyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxsZUA+YxS5DtdQ2MKbITdznB1hm0mM76gWK3ATlyG2120m0agvNjvMg2etwnRKD1XayOnblzabFtDIqsuA10zbR4Io1UuL/AT8PB4bIlhWr4s9kBntx/RM3jNZPkMgHDxv+NnbrjPICb/ZcwECrU9d7+Rkn9zda14DYMSeaCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wZYGGvRF; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wZYGGvRF"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-677a11d11e0so615662eaf.2
        for <linux-spi@vger.kernel.org>; Sun, 15 Feb 2026 15:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771197411; x=1771802211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PADUDw8CNAAL1tlEty9cxWnxu4Azyh2rgAcU1OiEhYE=;
        b=wZYGGvRFyPAd0gzMdZoFvK3FmPHZ6xsL3GBYayIQ/CzgaNn7XTwWsk955rbvLm4x6d
         gmAb65+/oDwYXHrsWSloXt/RCiUNg6kN7E9Lnm/XIBLZQs6E+oSRbqPKzql8UKstDJiX
         /HgnXZdkAcQ80hqitHqBAOeBjimLNGpLMeNZae7cb9S7u1ZWkktjAOZQdUEMZBqKu0OI
         fPf2FbG74jZ12oYawtmM4kHRofEWmNvNtBSe0aKgDoFgAUqStLJuSn8dW8YNugsPKsBu
         hvmUdxuYcftf2cNl6BSagJtNQvqGEG7Zy81GNifKVqB3aJzY7HxSoHPyLPUHj3YvXPgt
         VLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771197411; x=1771802211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PADUDw8CNAAL1tlEty9cxWnxu4Azyh2rgAcU1OiEhYE=;
        b=YXKXuFxeD0Lvu9elocl7U6sNJkEn+1jVEcVCTzlaOEBJaqHNPOM4uHjcml04CDx48M
         fg3A3j1TYPLP9A8r6VGGizzjcSY5GIIE2TXAvh3CsnhMemuUk0cL9YFlfOlAfTUPYEFg
         GVn5t6MP5UQBU5WHXNgzeNTOKFTq/fYnmOgeim6Yo2+TU6F0fjzFPbi8hFPXM98rjkSy
         ggzuvkBEh5wHJeXoC0QcxUampdmzXZyXpVuMf10KfWwyBqHqu9XatfJURqexFZjJNc9p
         I/PzKD22jqZyujPm1/IF/CFZNLg49zXqNgqH3itG6s/cyLzhoLoEvLYYfVWtWFbPvO1r
         GOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxSq03/aFBm1KJV9y6/UqqcScoYcnbBzfzlVOCZMW1czbk9f7mIJSb+8cw0J0DVcylQE6c4ySuPfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvP85L+PDMoZFwiiWHT+gDXKEKFWk7k4xvmJ3myNugrIYJj60
	EF9oyeJLw7P++1uKhTJ7vBoFQS6UX0ZR6xdr9CMdkmn85E8AB8z6CtUQf8AyzQHym1Q=
X-Gm-Gg: AZuq6aLf5Uoc3cWedXGlPyoHB6kkeBN1lvrQG4NJH16gAliafh9LWyCyJK754Yetz0Z
	tfEQaIeYnpgYbrakNCghxxiGZowHNveOw52iG5inEGQEHwTRuwY5KdUu8xt8Xu8HlmDBHQqrnbV
	BvuGig+S9Wf5QvPkORwCe3ITdEWbJ4KnSR+lqlxBEsp6ME1ocQCvGdHA+R4IbPWvrJqLDO2iwdE
	yNU32WIbYdGGlOSFhQsiUWwJCCYM4KDbKreHtRwzSrVt5PeRtfGwBe6lCh+JH3AX/aUAu8mU76Q
	RNDT6pOuv7is78wsVTW2OIVykycOV9d8XNnx/6J4y1uixLmyBdAoic75C85jsJuTiuofVcQPkyd
	SpRzeopm7MdG/1C8zM1+1MAEaNqLx9z+/17qIeK1pe+TvU2N21XaaHn4008RIkGTZqnWRTmlAwq
	6v2NegzBxiAKzlLrFlDuo6/7ftwUWF1gqLTePO0N6KdmULL+WxhV18JTET3J8ntYwAnBU68Otv
X-Received: by 2002:a05:6820:8c1:b0:659:9a49:90a6 with SMTP id 006d021491bc7-67767b50eddmr4473140eaf.37.1771197411024;
        Sun, 15 Feb 2026 15:16:51 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:796e:98be:f757:2021? ([2600:8803:e7e4:500:796e:98be:f757:2021])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67817ccdb97sm4392500eaf.2.2026.02.15.15.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Feb 2026 15:16:49 -0800 (PST)
Message-ID: <dce24f01-2a8e-4b36-9685-6ff4293e2d5a@baylibre.com>
Date: Sun, 15 Feb 2026 17:16:47 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
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
 <897bd4d4-bbdf-4cbf-84f6-05c110d75d03@baylibre.com>
 <aZF9zoWHL9iHSK3q@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZF9zoWHL9iHSK3q@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/15/26 2:03 AM, Andy Shevchenko wrote:
> On Sat, Feb 14, 2026 at 12:31:12PM -0600, David Lechner wrote:
>> On 2/14/26 12:11 PM, Andy Shevchenko wrote:
>>> On Sat, Feb 14, 2026 at 04:08:52PM +0000, Jonathan Cameron wrote:
>>>> On Sun, 8 Feb 2026 14:50:23 +0200
>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>>> On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:
> 
> ...
> 
>>>>> I believe there is a better approach, what you need is rather a flag
>>>>> to SPI core to tell that this is the device with shared CS.
>>>>
>>>> Antoniu, this comment from Andy needs addressing before we move
>>>> on. It seems fairly fundamental and I'm not seeing a reply to it on list.
>>>>
>>>> I'm not entirely sure what Andy is suggesting will work but this
>>>> is perhaps a mismatch in really understanding what is going on here.
>>>> Andy, how would a flag work given they seem to be separately addressable
>>>> SPI buses. I think this isn't a shared SPI CS, but rather a device
>>>> with two entirely separate SPI buses. I think the only reason
>>>> we are bothering to implement it as a single device at all is the
>>>> shared backend.
>>>
>>> My understanding that there are two devices that for whatever reason share
>>
>> It is the opposite. It is a _single_ device with _two_ CS lines.
> 
> Don't we have already support for that? This changes the picture even more towards
> NAKing this. See below why.

Yes, spi_new_ancillary_device() was introduced exactly for this sort
of thing, which is why I think it makes sense to use it.

> 
>> adc@0 {
>> 	reg = <0>, <1>;
>> 	...
>> };
>>
>>> the same CS line. Yes, I probably misread the idea behind, but I meant
>>> some flag for SPI device that tells SPI core that the CS it wants is shared
>>> (maybe a high bit in the cs field or so), then CS core won't complain on
>>> validation about using the same cs number which is "already in use".
>>
>> There was one existing user in the kernel of spi_new_ancillary_device()
>> that looked like this, so it seemed the right way to approach it. However,
>> code was added later that caused the primary SPI device to "claim" both
>> CS lines for itself and probably broke the one existing user of
>> spi_new_ancillary_device() (hard to tell without hardware to test).
>>
>> The idea here was to unbreak that so we could use spi_new_ancillary_device()
>> just as in the existing use case.
>>
>> The patch for that could have been a bit more strict to only allow the
>> spi_new_ancillary_device() to take CS 1 and fail otherwise, but users
>> are going to notice if it isn't working right anyway, so I didn't ask
>> for more checking.
> 
>>>> There is an argument that maybe we should be looking at how
>>>> to do data muxing backends to support the more general case of two
>>>> separate chips feeding into a single buffer, but that's a complex
>>>> beast and I'm not sure if it is something we actually need.
>>
>> I think it would actually be quite similar to what is done in this
>> series.
> 
> TBH, the change sounds to me like a hack. It doesn't cover other potential ways
> of the multi-cs devices come into play. Given that SPI core supports multi-cs
> I don't see a good justification for this patch.
> 
> What did I miss?

As far as I can tell, other than the one existing user of
spi_new_ancillary_device(), other SPI multi-CS stuff is only used
by SPI flash memory devices, not general SPI devices. There code
that is being modified here was introduced to support the SPI
flash memory devices, so that use case is already covered by
existing code.

