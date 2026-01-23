Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DAE2110E
	for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198452; cv=none; b=qs+RFCEROH40JdpGdnRPpzh9hPhlz+uekPvI8VmSpLBEHbql4HsMlS2YYwgI0KDNq0q79D0g6ixbnOL+48RRTt9NiIg+s8hXt6WsDOFPF72QKCXpiyGG/pQcY95vM8Q3m5r5S+OSJcWehCKDWNEvNIjmCo2Jhg1LMxKZBhD1br0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198452; c=relaxed/simple;
	bh=jaSV0XV90NJZ5DW0iVOUm7jPWN0ayo+Rhu16Xwg752M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kbl8SVZ8e4/gTvuLmiDuMxcfMZHvbtihh7c5B9MpZKDmyIwIuZLnTA3+6ZxngTiUJwmPfbExyIucP2mI23+LeSpd5pPOVId9uDb40rCHhaEnnnMHWKvnoC8E2hVizYjzzmj/57Zyvil7AkQFvi3DyaYutyt1DsTgMw1bMISWRKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=biWEAE2y; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="biWEAE2y"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-45c958d480aso816463b6e.1
        for <linux-spi@vger.kernel.org>; Fri, 23 Jan 2026 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769198449; x=1769803249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZGE4YuUh5bkNr/jB1KpY4pup5iAiGZtQZh24ZY4RJU=;
        b=biWEAE2y8hhYAb4xSRpXVOIpHhumtSmteiMO6egnPDCrEGxi4ADUG42blWUPpYsBo3
         rKniLaE60XfvkaEq877XyjQAjA4dSTWtBxVyF30SR67AtTNCkZM9MvMyFYov1CIGFYi3
         SjdZnVf/gSYwgmE0La9b+esHUa4Z/qISzBqDhhBsFfpWDJuwW/4BkZcGsU7CznDx5CZe
         +hiwe0Qz06ceMXSlzrrMmVYxcwHT2Z3wYhM37qpQJ3qsDSCsl4zSS+x9GxNpS6UHvIIk
         kLzlfV4cSqYHGKtCxOAFnpZNVP6pnF49ah3x1a5MPLY0Q+uC3v8ZE2dI+KizRtbkczrR
         8qXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769198449; x=1769803249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZGE4YuUh5bkNr/jB1KpY4pup5iAiGZtQZh24ZY4RJU=;
        b=aH+cjuB+/vOZfDxX+Z+jiEyMw+0haazOUJNgTb6zTUM7mS532j0au7pe85C7lH3BiJ
         EHGTGEMsgshQdxaQrV8FbCtyavSgJ4CJGEzKaqLUxyRrqkkO39LKHSco/SkvNCI6Dlpf
         tCns7tg9v62RzwFups1ZatN1GobyZPSI7zLAJ578j/dI+fNVm5SHSDVZu9gZBCHXdr6c
         NOI049SdvckI6XOGKy/5gUudvOl6dWlInCZlsx7ecLBP2PTOlweRDg/+jaFZWG0PWWr+
         PFBxqGPtyttjA9CPNfymXrsOHsx7PydV1MMtgX83L9PgM9piBLpTQiCvQQF8IomMqYQO
         LT+w==
X-Forwarded-Encrypted: i=1; AJvYcCWbaG/I+fBibUlK19I1JXQcNZT0G+SBcSXY7ssja22Av4B6LGLPmhROgFUDBuE+Jin3hFihzotat9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4XrvfPuvggRskRRInf2+wJlDZBAW5WjlMN2fpHFKv8ixGr1E2
	OI5w5u8+TNr1hn8Gn6tp55kZbNafDO6sSUeh6QKjyQbrk05p8U6Ps9mwE3mCqpY0jgM=
X-Gm-Gg: AZuq6aJ7LDdmk6VTpl65yEbftpD3YImNGcwR8HVtj5kV3g4brsSzMSlBE2HC4QHQIDJ
	u2aNwqQxF2ae/kfeolMCFsmg2HyZvvOFFv1WjugMkLV1eQ9MCeSvqb0Cq6pK49EIQcxCU5j1vlw
	OafiUEkQURGrCm4gk8ffu7MExt0py8zf9DcVl2t+YgC7wgi84BO9i1943VYB0CJdjGI1bNy1Hlg
	e/+zGi5AKzrHwi3B2U5ky5eGteze40P1hxA46sf7wmoUaOJlzhaJDAUBBoi9fyxGewacm+Pd/BC
	W6X3VLGKZT//uUDGP1SqRd0tYlzMX/kcWgKxgyAKIHi8d0tBAknyXbiXXu2LGgmjo+dOlxkkUrE
	+p0mg3OAFK779p0WyW4+coROuhz6P/Me5emEtIyIo57XFyry9VJkIg2WpHq2LeWZk9pgeIpFTec
	uGQf9slxTq/TQPKRTFohRTBLKqaGicS9VtNtIsFRd703RycRMNjIIgHl5BHA==
X-Received: by 2002:a05:6830:6aec:b0:7cf:d1b7:c076 with SMTP id 46e09a7af769-7d15a6391c1mr2303288a34.23.1769198449058;
        Fri, 23 Jan 2026 12:00:49 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:198f:2b50:c48:1875? ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d15b3d31d4sm2411128a34.21.2026.01.23.12.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 12:00:48 -0800 (PST)
Message-ID: <af4e092b-1b80-42c1-824d-16554d91e792@baylibre.com>
Date: Fri, 23 Jan 2026 14:00:46 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] spi: Documentation: add page on multi-lane support
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-5-295f4f09f6ba@baylibre.com>
 <20260114091024.390432c0@jic23-huawei>
 <ad688ba9-7771-4b64-a9d7-ec5100345460@baylibre.com>
 <20260119101116.00002664@huawei.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260119101116.00002664@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/26 4:11 AM, Jonathan Cameron wrote:
> On Fri, 16 Jan 2026 16:35:13 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> On 1/14/26 3:10 AM, Jonathan Cameron wrote:
>>> On Mon, 12 Jan 2026 11:45:23 -0600
>>> David Lechner <dlechner@baylibre.com> wrote:
>>>   

...

>>> Whilst simple I'd kind of expect a multi lane case as the example, or this and
>>> the multilane one? For me the comment that follows is sufficient for the 1 lane
>>> offset case you have here.  
>>
>> I thought that is what I did. I have one example that shows multiple lanes (ADC)
>> and one example that shows the map (Thing 1/2).
>>
>> But I guess you mean that you want a 3rd example that show both the map and
>> multiple lanes at the same time?
> Oops. No. I was arguing....
>>
>> I chose these two examples because they came from real-world use cases that
>> drove adding this feature. We didn't have a real-world case yet that used
>> both the map and multiple lanes at the same time so I didn't include that.
>>
>>>   
>>>> +            ...
>>>> +        };
>>>> +    };
>>>> +
>>>> +
>>>> +The default values of ``spi-rx-bus-width`` and ``spi-tx-bus-width`` are ``<1>``,
>>>> +so these properties can still be omitted even when ``spi-rx-lane-map`` and
>>>> +``spi-tx-lane-map`` are used.  
> 
> This comment is enough to allow you to drop the first example entirely and
> just have the 2nd.
> 
> Jonathan
> 

I still like having two examples of real-world uses cases since they are solving
two very different problems. It think combining these into one contrived example
would make it more difficult to see that.


