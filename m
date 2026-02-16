Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11D2E5B32
	for <linux-spi@vger.kernel.org>; Mon, 16 Feb 2026 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267999; cv=none; b=BWohKevfWksNe9UDvW1K6G2bBOkbZH0AgSwvWSr3weASTx1ZcRycprELWe0ANdxlAzEt8RqmdsTkwJTVqhXs9nRmiXHMx6wW1NTGAyYrYaC9Xe6jqs67sZntX1PthLDH6FsgPlz4MhIFo4NCJwa6gAMUyLQxy9xSxziz3FJ+u5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267999; c=relaxed/simple;
	bh=xXwfcFKB8CzFUyxLd95qfxY8XKTEIeiJ1uum/PvThEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFDlsotg8nxZRLtRSlylRZEvU1KPpYgMTdjUHIf3qgjb82Byjm1+tAZzEZ0gkm5+EfCRqpCiw9JMySmRCuKTYab9KorGM8vTWOh79KZOXfLpDk5q8KYLNEaYMlMdzu3lmnJj8FkxjO/bPs0z9L3UjJcJ5L+t5kksMLaZaXxNUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bRSc3VxH; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bRSc3VxH"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4bc9e48bbso1397625a34.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Feb 2026 10:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771267997; x=1771872797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flLYJCvb8ulr0CmalyULUpn6SChFpx51neWX5LGkNPY=;
        b=bRSc3VxHt0WF12/DEF3zwHyzGmTISKknY5bwhR2F9D97Bdp53vF1vcduFjk5LqFT/E
         fdQmHEI9Pq32WfbbbZk09Y63e+A1ltEhz6YvKsxPjkbcoBqYCQwsmxFaYCcwS+OzdFPv
         FHELNVpWatZ9K/B2DggG602s0QBk7hwYl5NXIQwI9tvz+n3txrQOPDJsXF/+Q8Ke+DOF
         vdhL9yd3y9pqOrk2DkIiygkufvPWH1ZJpeKUTVuh748l4JBpl1E/U2t2HF6niG9viB3P
         n+Zk74aL9/UJHk1lAoSFUKV0UezlZPUeKnUPa4OlY0X4x6fLsaNYOwp9JnSpNaz176o6
         xMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267997; x=1771872797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flLYJCvb8ulr0CmalyULUpn6SChFpx51neWX5LGkNPY=;
        b=Wnkp+wBqVOshpjZozFRJdy79vDjHH0sE9R6dGAv1ml0HOvVrK3/EMcPP6qmEb1A7Qe
         rpEKsWyrK4+d5y3T7ISpdAhcPuv2i25H/NgdEc5Mt9aE0JRUIdztaUv74KG/Cv2ve2mO
         8NLgmvPVDk/ndbzUa2kjzzTL0JXMeyfd4vX+2vJ/jgAhGQqgxQmEKafzaILYIRNP5C4K
         cijpeayK/k4Q2zwoInLPNqiWC4lZmCBqZYdp4028L/H1LbBpVwnqm++Bw/Ny4VC19qfC
         Rn4Rg9jUFmUC9FaB7QTqY5yMiYRqYzHbkj9zBt1i8tOK/dyMMpN9NAqs/iWtq96pYe4p
         QsjA==
X-Forwarded-Encrypted: i=1; AJvYcCW+uvbsr40RY5KopkPm+xAFd237lIO+7BBV7ZiOzlzb8BpryFAy4/PNZSmXk4itos8KrXU+upB6qDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEe0y2nyrit6OD0ZfwTAt9+GW0oLQHLqZ/t7OyrHMmnTT/6URZ
	qepyaHDQbM3D56QWyneRa3ATgg9Jvokt9ALCGAX6g0+H7VNkPcJ2+oEx17DmaOtoMWk=
X-Gm-Gg: AZuq6aIv4AwCK45l4kFNTRGfe6xjwfl0oVtgdrfs79ARfFFGIPGc08M+ZiGBOBizViq
	vy7IafuNY4d+fo9y4WW3KWq/LlhJXWEe6J3WVPjj0DAA/iWAlrEybjTmWiecLo07e4XqW8w4Tdc
	6t3R08zMZhjd4udMkc+VsLn7kNTchwBS1pHfa1Hz0MQFBbI7FkLgIw89SqGR5HidgCHplSyxOxB
	0czZcRM8vYNieDGsVD/0ryVbt3nqJp2WZSv7IlREloR7DSuJtFodv/JPa6sCvr2nagMTTFo/LxD
	EOcAZPeQqbzeoKXJbySnGMXkrnt2BROeRhjXj+vNK/pbwlhPlHKn2rfk0+kTtdUELmAxAKPmfAC
	C9ZYRaQ3REIBhodlL9KIPlciL3le+vEnKQBIkl++ZIFGK7ScoXDeAXdUnTXYPTDkYh2GAWB4OSZ
	Nbd6/t90YBeHxgpPMQoe1r6zD7KLsj4aUeLCZt4ED2HfjQCndkEZZhkF9Jw55ujjPGHVWnKA1IM
	6ehgXM15aI=
X-Received: by 2002:a05:6830:43a3:b0:7cf:cf19:cc62 with SMTP id 46e09a7af769-7d4d0c7f3edmr6175611a34.38.1771267991908;
        Mon, 16 Feb 2026 10:53:11 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:2d75:8cf2:6289:6a96? ([2600:8803:e7e4:500:2d75:8cf2:6289:6a96])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4c7288d34sm8058133a34.18.2026.02.16.10.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 10:53:11 -0800 (PST)
Message-ID: <2f9fc7fa-dd55-44f2-9b78-c9902b8b1bbf@baylibre.com>
Date: Mon, 16 Feb 2026 12:53:10 -0600
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
 <dce24f01-2a8e-4b36-9685-6ff4293e2d5a@baylibre.com>
 <aZLDyWICGB_j0Z1Y@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aZLDyWICGB_j0Z1Y@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/26 1:14 AM, Andy Shevchenko wrote:
> On Sun, Feb 15, 2026 at 05:16:47PM -0600, David Lechner wrote:
>> On 2/15/26 2:03 AM, Andy Shevchenko wrote:
>>> On Sat, Feb 14, 2026 at 12:31:12PM -0600, David Lechner wrote:
>>>> On 2/14/26 12:11 PM, Andy Shevchenko wrote:
>>>>> On Sat, Feb 14, 2026 at 04:08:52PM +0000, Jonathan Cameron wrote:
>>>>>> On Sun, 8 Feb 2026 14:50:23 +0200
>>>>>> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>>>>>>> On Fri, Feb 06, 2026 at 06:07:12PM +0200, Antoniu Miclaus wrote:
> 
> ...
> 
>>>>>>> I believe there is a better approach, what you need is rather a flag
>>>>>>> to SPI core to tell that this is the device with shared CS.
>>>>>>
>>>>>> Antoniu, this comment from Andy needs addressing before we move
>>>>>> on. It seems fairly fundamental and I'm not seeing a reply to it on list.
>>>>>>
>>>>>> I'm not entirely sure what Andy is suggesting will work but this
>>>>>> is perhaps a mismatch in really understanding what is going on here.
>>>>>> Andy, how would a flag work given they seem to be separately addressable
>>>>>> SPI buses. I think this isn't a shared SPI CS, but rather a device
>>>>>> with two entirely separate SPI buses. I think the only reason
>>>>>> we are bothering to implement it as a single device at all is the
>>>>>> shared backend.
>>>>>
>>>>> My understanding that there are two devices that for whatever reason share
>>>>
>>>> It is the opposite. It is a _single_ device with _two_ CS lines.
>>>
>>> Don't we have already support for that? This changes the picture even more towards
>>> NAKing this. See below why.
>>
>> Yes, spi_new_ancillary_device() was introduced exactly for this sort
>> of thing, which is why I think it makes sense to use it.
>>
>>>> adc@0 {
>>>> 	reg = <0>, <1>;
>>>> 	...
>>>> };
>>>>
>>>>> the same CS line. Yes, I probably misread the idea behind, but I meant
>>>>> some flag for SPI device that tells SPI core that the CS it wants is shared
>>>>> (maybe a high bit in the cs field or so), then CS core won't complain on
>>>>> validation about using the same cs number which is "already in use".
>>>>
>>>> There was one existing user in the kernel of spi_new_ancillary_device()
>>>> that looked like this, so it seemed the right way to approach it. However,
>>>> code was added later that caused the primary SPI device to "claim" both
>>>> CS lines for itself and probably broke the one existing user of
>>>> spi_new_ancillary_device() (hard to tell without hardware to test).
>>>>
>>>> The idea here was to unbreak that so we could use spi_new_ancillary_device()
>>>> just as in the existing use case.
>>>>
>>>> The patch for that could have been a bit more strict to only allow the
>>>> spi_new_ancillary_device() to take CS 1 and fail otherwise, but users
>>>> are going to notice if it isn't working right anyway, so I didn't ask
>>>> for more checking.
>>>
>>>>>> There is an argument that maybe we should be looking at how
>>>>>> to do data muxing backends to support the more general case of two
>>>>>> separate chips feeding into a single buffer, but that's a complex
>>>>>> beast and I'm not sure if it is something we actually need.
>>>>
>>>> I think it would actually be quite similar to what is done in this
>>>> series.
>>>
>>> TBH, the change sounds to me like a hack. It doesn't cover other potential ways
>>> of the multi-cs devices come into play. Given that SPI core supports multi-cs
>>> I don't see a good justification for this patch.
>>>
>>> What did I miss?
>>
>> As far as I can tell, other than the one existing user of
>> spi_new_ancillary_device(), other SPI multi-CS stuff is only used
>> by SPI flash memory devices, not general SPI devices. There code
>> that is being modified here was introduced to support the SPI
>> flash memory devices, so that use case is already covered by
>> existing code.
> 
> Right. And obvious question why can't we apply the same approach
> to any SPI device? Like extending existing code to cover generic
> cases.
> 

spi_new_ancillary_device() was already accepted in the kernel as the
solution for this sort of use case, so isn't it already the generic
approach?

I can see that it could possibly be nice if the SPI core saw that
there was more than one CS and called spi_new_ancillary_device()
automatically and somehow passed that along with the main SPI device
to the driver probe function. But since this is only the second user
of spi_new_ancillary_device(), I don't think we have enough data
points to be able to say if this is really what all peripheral drivers
would want.

