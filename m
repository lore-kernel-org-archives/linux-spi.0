Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9374D4870
	for <linux-spi@vger.kernel.org>; Wed, 30 Sep 2026 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776308; cv=none; b=DDiL5AlQqbEEHmaEj/gwSFcU1JhafIz3UJmmM9eIGTyFDSLwT0kvklPMY/gyiVkb1kDY5Z+GY1Qo6CDCPzBs3615TpXJptDh8kU9fNhAQYGldM1r3mg5yw8KFhl/brGKZwRQChpzF88qgx5P9tHPjSHcp56oTVR2GgM9OYJAyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776308; c=relaxed/simple;
	bh=+IoKX1KNbarkITcQFvbLMQ1gUQCVJ7Te+5R39GBUc8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8iNu/XEuQF4R0ncWpXJq0nb0YAQEZxPha0EpZ+l77PKOH4aAJGxil2bOVHxkbdyrRxk7NhmP2O1FIPQqfX9blBkCg2xt9seIEi42eDfZR3WKQ9Db5MBNG1VkoK6Nozi3P2OB1HVBiacKEqEOuLT2QkNg5RXLfGImoK6TzoAj5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEpnlQWU; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEpnlQWU"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e30a06b59so20135066b.3
        for <linux-spi@vger.kernel.org>; Wed, 30 Sep 2026 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790776289; x=1791381089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+IoKX1KNbarkITcQFvbLMQ1gUQCVJ7Te+5R39GBUc8M=;
        b=UEpnlQWU19HF2YQ6+h1Givg34TXiGLbOzW1X5TAsNO+qgXzB6nlp2+YxTAQxC6ARu4
         mb6qF1MNsm+V+GYxSluqFvxyUHo8eu0yNKt73JIXRIOMkZ+EB2uYThMEFDlFO61lcsAo
         pJ44SFDQjoW6QEJIXDVzQcoTuEcupC6oRSSxbpLjvt/a9+yZbBeIL0UzzdI+TxB2FxnN
         Jem0kiPwC1pjSEjmXkgPlwKJjR8ZpCy6rVAgP+fz6TzeIOimk4wqkPq4ouXLeoVLvxa/
         SujQkiAwU+FFBJICduj0DBRHMCZ+7PP6kKnVISR4/4cTNeFgQ6bSmCeXDfS+wZZxBYXr
         BuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790776289; x=1791381089;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+IoKX1KNbarkITcQFvbLMQ1gUQCVJ7Te+5R39GBUc8M=;
        b=up0J4zYAa4ee4lbr/1nc7Ls9xO7sjhXnJBP8JDALrnLBRDGMgIHRmL9xSQEO9C7XmS
         muGjfGpseYiCtFlA2tUPLErcAj5ZZmv6vu/AFRxEJuzQpOofXduqKK/glSDFn2zHwwZy
         AmnoTWLGcf19aJ/Fg/7tx2zlpwuox8MJtWhOoCKolok6Ar/GzW0i4Box0d+6BjEExl5F
         tFowzpqyMSK91UPUVVLTs/Q5Lz6YTJBsHNUTHZl96cY8iPYJhlamFOHbk3Xpk9GWtmza
         NoiFxes/KrscAG0K/COGAbLtZWZwJ4b+RTAo2wSHDzlqzRgEJPwuRf3OEIBCIbxYaPji
         TIQA==
X-Forwarded-Encrypted: i=1; AKwUvBzHzTkeQuZ3FhYx+fD6tvpxF8NWT4rWSFCNbD4yfG+OtPAROwgxjjdxCotYNGd6GpIxTAcoZpdc4k4=@vger.kernel.org
X-Gm-Message-State: AFuF++lIJkOIMd744sV38hVWaGs9k8q3Bv/OtlSQYfnTn/X95EvSSIEp
	H6R1EPjyhqUOXviidizOxYNxKYzlrpvqixJzqIiwAwPDsNh0Lw+a8Bvi
X-Gm-Gg: AYBFou3x8RSumBeuoD1p2IrJgD7SHA9ZSXsRErZLJtCqKaCFXCXpkanvpjQgfDUXAEF
	o1hJ0lZhXXMHbdnB0QBYvcOzBynAO4Wvlz7jz4rlYgqcbmrHVfrpvnzumn/0xhvkgOdq759C6Kx
	VlfoGxiKx3TCeySpo0/CvhtbCmKWu3EvR7HCH4c5xAIFyCa9gHMSe9QnegA6KvSYArUONitb1As
	zyp4EXi8QTe0kxCzgsK9cEEbhJVu8K8/DZkfao9Ex76lPHWtd7TL5wsbzVJ3b9zI9A9K4FQvtW2
	su95FukwegKiviQ//mQNeWHZCHUT5hBPtA+mqY9V+YSKiCj+p3rhZhQsAp10gDSppY/xPoUR54a
	kQzqaW6J7hmoFUzUYkyXka55CWFEIAJHJjBCPZt4XjWbk/W2X3oeCjKv1ff8Ehc6yJ+3bmLaoUo
	pZqWE2Y8uhuVXbOlLLPFxPdCf9rHzlyRwZBpQr1Vd+oMShtL8bvFvrZ7e6m+Ds4/moWS9Gz8vzJ
	M6dbjHEi5f2HwjXrvl/36VXE+r5e9HWVFw=
X-Received: by 2002:a17:907:3f95:b0:c26:1648:a06c with SMTP id a640c23a62f3a-c2e23de0396mr133226666b.39.1790776289360;
        Wed, 30 Sep 2026 06:51:29 -0700 (PDT)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e31d867ffsm5456466b.59.2026.09.30.06.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 06:51:28 -0700 (PDT)
Message-ID: <a57399f0-4c47-4b32-bf6a-7761d9b57320@gmail.com>
Date: Wed, 30 Sep 2026 15:51:26 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] iio: dac: Add AD5529R DAC driver support
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
 Kent Gustavsson <nedo80@gmail.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-5-cfdf8b9f5ee3@analog.com>
 <arzTnOTaL97GudZM@ashevche-desk.local>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <arzTnOTaL97GudZM@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/30/26 11:17, Andy Shevchenko wrote:
> On Wed, Jul 15, 2026 at 01:41:08PM +0200, Janani Sunil wrote:
>> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
>> from Analog Devices.
>>
>> The device communicates over SPI and supports per-channel output range
>> configuration. An optional external 4.096V reference can be used in
>> place of the internal reference.
> You haven't added a given tag, why?
>
> In any case I have noticed that there are a number of (not so critical) issues
> are still exists, so I have to withdraw my tag. But please, answer the above Q.

I intentionally did not carry the Reviewed-by tag from V5, because V6 included substantial driver updates. I should have mentioned this in the cover letter, but I missed doing so.
Some of the points mentioned here have already been addressed in later revisions and are now present in Jonathan's testing branch. I will send a follow up patch for the reset of the items.

Best Regards,
Jan

