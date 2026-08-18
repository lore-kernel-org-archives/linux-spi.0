Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ECF411F8B
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066823; cv=none; b=I6laWdGV+7slCwMMDc+xt6mKxyOyJAy29gQSDo09IWlqKqFLc0mNS000VobwAiooAredt8vQuzEHpSOz0hW0Yk4atI+xIFRpygGdkYAyNWaPQwXGeTzS/ghSdJltJdLpQagkwilviZfmo33XAPRzSuOWoJy3ewThn0imqEOQ+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066823; c=relaxed/simple;
	bh=QSd6gWWtq1bdwkV8O6HBDb0DHl3OP1mJHng2FNrIQ2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNT3+e7YO+scOQrmHBnrg0/M7dFiQZql+6rSA9jziOoH/QPDqVz3XIb9ONy0rb0W5SqaqzE6VE0lyzHpna6m50YqRcndkWWbJzFO1oA6h3avK+Bq8Wg5oXuORZecCXtDyWcy+cTRvjTKmfaDksVKWKU9ycS+lJJ/KwaB8uMomQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KHrd41ji; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KHrd41ji"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-451fd21113cso1575892fac.1
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787066820; x=1787671620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kLtKE6/TI9W76ovkmU8N90Nok9aj9iybCFeLZbc1gOg=;
        b=KHrd41ji0SVU4+FujnXA3MfdJ0jGx5HAn0NtogY8OVWwMh4Tn+EFofBNQpZSfGELkk
         CKvQgKsrbpJJ5QjoVxVxAybVSGHJBE5YexHuzQfcbPcYH5g8XhfE8xeUg9NJionFEHDK
         6ehL0UxQazvs0BJiLAaS95CdJ3kgRx6ajJju3Q7jXRP/jiq0gYrrGBA1r+k+L/E72hMU
         WsG4Y6tGoautmIFFCWvGDTkKXlNDgnuZzywY/WfHX/1FuKNHQRUzcvIlbhvX0jh04zM3
         EeoYDKvnoj6uBtQ6k02WISHT/5swcWbo+Lghyd82zdn8mkykDa4iQNuHFOhE9WpiRA5I
         0LUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787066820; x=1787671620;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kLtKE6/TI9W76ovkmU8N90Nok9aj9iybCFeLZbc1gOg=;
        b=Z0MjQ+2pbPgIQzOy7giPEY+8zIgK0kSTmgOwgsU7La+6/nctNe9KD9kcKGtW/mf+BV
         CimrGvTDUZwKyStYr3DnXREyKhdwD9JLMocHNXLThZUY1sVJBNOUzSG0p4aY94Hl0al7
         ldQ6l3acf9ZvyUcE0/4sB2/WFgXYvjluUc8DMw+uQEUHgy25wWerJAJV0p89FnAz4LRw
         Gzn0nJaFbsANZY6B6lXix9VOrQjxwgslYk/Ud6iKWnHOLn7NxpMesLtzS76faqxqe6ZF
         46Pl/ZtjnJqexrDdK0YXf5DpgZAFqSCh6ir6ULSjul0NkywHgd7/l8augsuvx7k/PTPx
         a2eQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp2Dy+X3rYi9F6Mry5Vzmff+PJ/ao/7/7riJ019PHG0uBTkZmhtgkh5KFzP/L3fSq7jn1WC87Fyau4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpStVfQLuXBXT+WjHCAGSpYmmP8W5LgB2eLzCnhbbT3Jt0oEQP
	fnULrUUx0AEK+r4gkCh523GzWOPkAS+ZDW6J+nQ1U7LDK/FI9wGr8arkuB/ZFv/bax8=
X-Gm-Gg: AR+sD12Huk3QtJP8SsyTe4Wrch161XYWpVnuF3JZ/LpvxGGJzl5x2uacUwICUr/h2Rn
	aTD/7Lvxp+iR49LJb8fmGitH59qZJjlBkP/lEjnOvM1JH+isYgSPDw/kpSyevv+8dBINCaLm569
	MN4WpBDMEEJSyAoPgxT1NojrskuW7TcGfy/Lg71UxcIx5Xj0aAjj/d0dajL1P+xrh/ExTHbG1iP
	ce7RTGbc/QZ9nDTUjC/6E3ufS326cf5Z5SQdrjdILli/wYFTW1hmlpuBBFa6zcUterYfUKSeY4O
	cxC/3pcslLPTw4J/EdmZAmzBiNhdllEH8ArF6JMNO679x/SOgUVcaWPv4qhSBaP1NoxD5VP+pZl
	LStLl7y6slws03r/iKNDdepgHDTtWHCe1UHox/GE/Z5rZ981c39nk8aZF7kT9LNhTzv4mvzIwyw
	dMOwo3+VYw/QFNFT/fywJmayxXT1dm8TEPPWjO77Ea5qYOLnXCrAazFnmyYWhs1Bb3XzzhpsPcy
	t0tEDinIyHacw4enKe4jTUFPQO++3Ftse5fPWc=
X-Received: by 2002:a05:6870:31b6:b0:456:e4ba:14c3 with SMTP id 586e51a60fabf-460a41ce84dmr4914642fac.2.1787066820338;
        Tue, 18 Aug 2026 08:27:00 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1cf0:fc72:ac61:29db? ([2600:8803:e7e4:500:1cf0:fc72:ac61:29db])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45f22e940c5sm3273917fac.18.2026.08.18.08.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 08:26:59 -0700 (PDT)
Message-ID: <1c0fe275-3358-49ab-a238-7eb89127cce8@baylibre.com>
Date: Tue, 18 Aug 2026 10:26:58 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: iio: adc: ad7768-1: Document
 multidevice support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
 broonie@kernel.org, jonath4nns@gmail.com, marcelo.schmitt1@gmail.com,
 andriy.shevchenko@intel.com
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <d19a27738ac13307191dd09cd4a3ac5df7f7ba32.1786973376.git.Jonathan.Santos@analog.com>
 <9841fd2e-434f-48f3-90c1-d62718d6d4d2@baylibre.com> <aoR1Uo2W5BtiYRSY@nsa>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aoR1Uo2W5BtiYRSY@nsa>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/18/26 10:14 AM, Nuno Sá wrote:
> On Tue, Aug 18, 2026 at 10:02:50AM -0500, David Lechner wrote:
>> On 8/17/26 6:32 PM, Jonathan Santos wrote:
>>> The AD7768-1 family supports aggregating up to four devices on a single
>>> SPI controller, with each device occupying a dedicated CS line and a
>>> single data lane.
>>>
>>> Extend the `reg` property to accept up to 4 entries (one per device).
>>>
>>> Add `spi-rx-bus-width` property to declare the per-device lane count.
>>> Since each lane is bound to one CS, the number of entries must match
>>> `reg`. Make it required when `reg` has more than one entry.
>>>
>> I don't see why we should have to require the spi-rx-bus-width property.
>> It seems logical that if it is not present, then we would assume one
>> lane per CS. This is already how bindings work.
>>
>> For example, adi,ad4080 and ge,achc have multiple CS lines and don't
>> require any bus width properties.
> 
> Hmm that's my default then! I was the one requesting it. Basically
> because of:
> 
> https://elixir.bootlin.com/linux/v7.2/source/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml#L76
> 
> So I thought that $refing spi-peripheral-props.yaml and leaving the
> default value would make dtbs_check to fail if one used 
> 
> spi-rx-bus-width = <1>, <1>, <1>, <1>;
> 
> in DT. 
> 
> Won't it fail?
> 
> And if we don't give the property I believe we'll have:
> 
> https://elixir.bootlin.com/linux/v7.2/source/drivers/spi/spi.c#L2509
> 
> And given these series assumption of spi->num_rx_lanes == number of
> devices (which I don't agree btw), I thought we would need to make
> spi-rx-bus-width  explicit in our bindings! I still think but I might be
> wrong and I'm by no means an expert on dt bindings schemas work :)
> 
> - Nuno Sá
> 
>>

Now that I'm reading the later patches again, it is jogging my memory.
I forgot that we want this to operate like a single multi-lane device
when reading data.

So for that part, yes, having spi-rx-bus-width kind of makes sense.

And I'm thinking that we might need a new property to indicate that
this should be treated as a composite device rather than main + 3
auxiliary. I'll reply more about that in a later patch.

