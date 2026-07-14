Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5637BE8B
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040273; cv=none; b=ENkYQetgNlsa4DMbVQdWtZ/7yuWQzBBFoMHiuhBMQIr5JFaAyTjb8czQ85FhoVFkcTMkbOufN6qruccdj5RK2poFb+hBngCfLdMdhBORtNAJG8mOe4ulpYW7Nhu9B12AAa7asIKYYCexsDs5yq/mrTJRQrVUkuvE8LRhcojDrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040273; c=relaxed/simple;
	bh=F/Jgys+2iHUqANEe/A3sYIopmphNNvPEymGZjONdPpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKZc1BFJqnpVzAkcX8VgjmrYz+DeKxKkkVqPg81fZ8JPZlas10Q0fIcbtW6yJzaJtsdcdWY5Q8fAajMbqPXhXZ/qqnsapIV8POy0rOIs7EIDhQyl9gc1TTw8ql24y5JKvBoRTZiZl1TtJSP8oiF7qsYzATlgI5ikO1PAT6y6zjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=B5jeWqSc; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="B5jeWqSc"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb787dec99so2736815a34.0
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784040260; x=1784645060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ByFodd6VvmfsjIG51piOnpiF2zzXgO9EYKqqK0KYSPo=;
        b=B5jeWqScjPcvspSWVNgxh1OlG8owPePz/sBKp0tchS9eaGeoyHm82sWjDcDY7ULr6F
         zJe+NNbBPOAGymCwvAOHk2LUZrlPmy+FN65kZ+PbmXltd7BB3H5eNvkggVehlyveUMiy
         WMvsBieGAP7uQH7raMGKTQcSS9idd0gyG7liqfnidL954wl3hPFoUD/4W2BV8Z4mJLdS
         E82yMpAOfBBvfVCXx8KG9IZZij8eQ4K8lGSUDbpWtEcJRziMw9dKPj1VdvlmMfvpoFbN
         FDD/QF3jQa+I2gZ33qG7H2/fyvhqKz9yvn4rcVNAFEuOw769AsKva6zraobU96ugPXa5
         xSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040260; x=1784645060;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ByFodd6VvmfsjIG51piOnpiF2zzXgO9EYKqqK0KYSPo=;
        b=kCcpB6R6sGBLD+NPiHokJqvngWUKyQDXUfDZyWCp3Lc2UXTz3eGuhdI8MKSmC+MGKs
         JUAPc3dCAChQghaB8U6ggJc4DefIvKjex6UAJBhRfiBMqUFDku+9zVKgPZOTOrzrWYbt
         DZoxN+AvDNbmniyiflIZ844gNhGsgAXIsNHsi4NLiJHrijNUWU88WJJkDslzB3K3RIi4
         dqn81kE70eIQachfdBxdr6NohFSlcRN1KkJtSK9x0eT2OcOk3K9sAsbUOmIruOAaVCqx
         fjvr1Dbl1n+d5HN+FI3TV6/uIpiR7EdEeEA9aB5wZ68LpobFu2sa6wSJAGBLoTbUjgxL
         xiEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9j34UfXTfqqX1JnfGgrZDBfbFrTg1BGuzRQMhXykVv/WwBBWYcrZc3BP6v5hiEpVb9xhFnttGI2Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5XAPBKzYf2VMPMlHMQcSyNW14X2eMZCJmK3QBrGomeuz29Lz/
	lSbSMKoTY6rvnlzlfbF/NgNXNHFHIVWq6kL2CxYOVh3tv2f2ien6tXsJW9/BnJ3D4+A=
X-Gm-Gg: AfdE7cnin/6+XZZuR0HabZ9d+MpgtmhrmBfUFv/I61V/ygq78IA+doUexniAoT96gez
	30peeTzw5e6yl6l6d2MsVBiRiaBvZNJjal5EM3FQI0JeDQQJKXL2xKvbncdn0j+SkbTZuQOeYld
	zCxWSibnqrMQ+ieOTjSirXejLGwpZComBywOTgv8njTv8qbXQtbzFDKLv+Jqub+9a3fo38gkAiC
	pz0iQ/10S/ZTTZwETDUdGt/wCexIvHjYl+RaEybgD/wD4Ki+GYzyp8fhtUtNxaTT/iYZ693vd0J
	YFzq6zQdVAtPTFgfUVWdqCAjxAzBvC+HtR2bZ0/EI5ONCiELZ4N3tgM7tz1mf3+T4JTspnadcd+
	tNHfL9vZF3+ZjWfGgPi43l+UwSnObxMpCUjQHSIeLrruHb31UFz/VvfMra1+8maPaoZbBrsZuR1
	YMAkK/n+LoY8OwQa8EnkKK1+FFZC8ei66qqLYgPAIkMNG82QyjrIECHe8XlmRXzOs=
X-Received: by 2002:a05:6830:349a:b0:7e7:7fbc:8e51 with SMTP id 46e09a7af769-7ec097b5ba2mr8615207a34.24.1784040260485;
        Tue, 14 Jul 2026 07:44:20 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bae7fsm16738711a34.21.2026.07.14.07.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 07:44:19 -0700 (PDT)
Message-ID: <d7531ab3-aa0e-4d82-9c1f-5b0db571f099@baylibre.com>
Date: Tue, 14 Jul 2026 09:44:19 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] spi: add multi-CS and per-transfer lane mask support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 michael.hennerich@analog.com, broonie@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com, andy@kernel.org
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <alX58XKU2iD3x9y1@ashevche-desk.local>
 <6cf508ec-c139-4969-9342-d5b6717bde21@baylibre.com>
 <alZHM1UJ2JnAdikw@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <alZHM1UJ2JnAdikw@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 9:26 AM, Andy Shevchenko wrote:
> On Tue, Jul 14, 2026 at 09:09:02AM -0500, David Lechner wrote:
>> On 7/14/26 3:57 AM, Andy Shevchenko wrote:
>>> On Tue, Jul 14, 2026 at 02:55:31AM -0300, Jonathan Santos wrote:
>>>> This series introduces two SPI subsystem features: per-transfer chipselect
>>>> masks and multi-CS device support. Together they address the multi-device
>>>> setup described in [1] and the limitation noted in [2], where no SPI
>>>> controller completely handles logical chip selects beyond the first one.
>>>>
>>>> The first part of the set addresses multi-CS support. Some SPI controllers
>>>> can assert multiple chip selects simultaneously, but the existing code
>>>> hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
>>>> preventing this from working.
>>>>
>>>> The second part addresses dynamic lane selection for STRIPE mode. In
>>>> SPI_MULTI_LANE_MODE_STRIPE, all available lanes are currently always
>>>> active. Some peripherals need to select a different subset of rx/tx lanes
>>>> per transfer. New fields are added to the spi_transfer struct to allow
>>>> drivers to specify which lanes to use for each transfer. The documentation
>>>> is also updated to describe this new behavior.
>>>
>>>> [1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
>>>> [2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/
>>>
>>> Mark usually "merges" a series like this and cover letter goes as merge commit
>>> message. With that in mind, can we use Link tags for the above? Like
>>>
>>> Link: ... [1]
>>> Link: ... [2]
> 
>> Beware, that would cause b4 to add the links to every patch in the series.
> 
> Even in `b4 shazam` case? I thought it adds only a single Link per patch,
> and leaves the original Links as is. No?

Last I checked (which was a while ago), all tags in the cover letter get
applied to all patches in the series.

> 
> Also this can be done with the blank line before real tags, would it make
> it behave differently?
> 

Don't know.
