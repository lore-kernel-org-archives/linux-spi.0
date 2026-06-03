Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1739449EDD
	for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2026 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484602; cv=none; b=U8u3HjmWldmw6XHbmC4UYrnw4N5j1xHM9oJIRFae6FeSPUzNZSvQsKxZmkT6yoGaM5seGRONw6FPIAN3uVlrNS9wAV4RMvfgzx01GrV63nd4rwTvHqRtAoNWySdcuZW7p3l0At3DJ5AC2+nX/V//wnJ5c4zYM/wicc/ncHeOX/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484602; c=relaxed/simple;
	bh=H74Lq0TSr0QOVoOeuu9C+dc+cedTm6HEOLOz6/S1OMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qc1ImSbsipJLpRMlUJWFVohzJqL7jt0mXBOpuL7Q7T1X998RnZIIJF+eOUzFDZhFQ858bWDsjcFHmivM2TgpyC5gCiDW/vkr0zQB1fFsm16KK0MhRPbQSGvX9fRr1tktfnKkZf4rthCHH7aSX5F1psoOvLXGGX2kJRTjYJIg8b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pV+sCvAP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV+sCvAP"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0bd02d97eso42190135ad.2
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2026 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780484600; x=1781089400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RASJEjVAR9afFVw3X7mPRvBm05E0D//IY850D9FxOG0=;
        b=pV+sCvAPNd+F2pOBCQDATO019HfByIj0hFlrY05FdCo0SJaKv5vqzH5opLD9/6xXWH
         W/pPqzZoOlmQhf7QpKXqXUHXfoZHKNHGK0ZSoLLGy2KXFq1hMsDJOlGMf9fhhTKmvrfl
         sBeKPoohO7ekqqR8N3777CusurQkznM3qV3MIinGKGgoYF/PbYqx+lsmz1LVVMypm94y
         LMCvHteAVLGiVsd0gJGYKW6GjMMFYP9ahrTGhcpQrJjQ9LLSiVSc8xI6KESze23ZKL3G
         LRoCIV3RPCT3FvnW1xbQsk3KxAGMALRQfXP8P58XKA8w0ZV7L1Iu31d5bXcjUJDvp7l8
         THFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780484600; x=1781089400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RASJEjVAR9afFVw3X7mPRvBm05E0D//IY850D9FxOG0=;
        b=OTAYMZn2inLhp3Gt9Ofd0zFzViYjjdJVNPka9bJIFQd+eI9116OToawM3ohy5lWWzH
         h1AymemPjqbPdGehDgYPX8jM89frvGD8fbBLCB3EwoNSTTJokHAAosquyk+eoaZCODdL
         aM/ZGQenGoQt8AdomufYfTBoBXgNFuFpk3yKbmO0K7NkHs/d9rG3Vw9OTkTIUV+M8WGe
         TFbNnbZk9G3+MDlo9nvITX3VQ9rvyfZ5qHm7iQcuXy6aJhKlJOlqsX1xghHoS1pxU4N+
         lKNEb8bSJI9hQYQpr4JbM3LFQGY8gK2y69UUd9XeBQ2wqzv4Fn3weN/1PgfV5jJTqvOP
         fMfw==
X-Forwarded-Encrypted: i=1; AFNElJ9g3nu40wKDMvBr/f3+4jHnjdKS+sbrzKW3OckLTBobYkGISHa1aGyiuZ7nLjVkhTDgMhjSosOiNmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzueFR2/ZAlRiSvRi8J4SCwSdLpbfQlQPH0lCvsCUHh5A08pTQn
	ra/QTOgdkQaG4oA9qAkFM0otPL0I0yHsXQTUgjsSdPv1pQ5nfXMbj88E
X-Gm-Gg: Acq92OFqFVhwi5FBcKu0LI4c+wy9bOd4VoND9fkt8ej3YUuJKcgJY1A3zemimKVitwN
	MLLf2p3CWZ1BY1ha27UOwmMPpULFMilkBSVRGy/lXD6w6INA96NZ4YbvLcgHv45FhM09vr80yjz
	gv3Za20nvWxKTUAnjkKFqiUKzTDM+5MUqhxhiSFqhY6JeV97W2Jmh0Xb81nUgOFRb9X46dyouuG
	MGPQxCiCw/dfDiDrMLobedlutVfV1zOwpITWMVIaL+JpZCFcR4/Mej2MUMUs/vgQym/NB6N1CYG
	8zZUNuJYaW87D6mIAwsZGKYe7HzIwvwENCFB8gxCUhNdStlensg/QkJF1OTGL8GcSZ4S7FxygqL
	pTjosCRhbNWcOzmuGe1n0qqNgEoQT64LW1LtD8kc6hy9TkGBD7Ms9DjVpFn70xJt5QbQCIfMEeN
	UARIg8NWoF/Q0ZRwex6WybYe2vBDP8zP7d+jsDou35AYNpd+3wn7goOvEyQZql/oCQHCc7VxXP5
	xzT4twF88K+zg==
X-Received: by 2002:a17:903:1252:b0:2c0:e5ee:f554 with SMTP id d9443c01a7336-2c163a24976mr28261115ad.8.1780484600180;
        Wed, 03 Jun 2026 04:03:20 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e1b6sm21738805ad.38.2026.06.03.04.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 04:03:19 -0700 (PDT)
Message-ID: <5d6ecdf7-1987-4ecf-ad59-06595742cc8f@gmail.com>
Date: Wed, 3 Jun 2026 19:03:16 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: Add Nuvoton MA35D1 QSPI controller support
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260603043551.1062112-1-cwweng.linux@gmail.com>
 <20260603043551.1062112-3-cwweng.linux@gmail.com>
 <d32634eb-4eed-46e6-b378-d42df0b1c75e@sirena.org.uk>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <d32634eb-4eed-46e6-b378-d42df0b1c75e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mark,

Thanks for the review.

I will address these in v2:
- add "depends on ARCH_MA35 || COMPILE_TEST" to the Kconfig entry;
- convert the file header to // comments;
- split the low-level CS register update from the SPI core .set_cs()
   callback, and make the spi-mem direct CS path handle SPI_CS_HIGH
   explicitly;
- use op->max_freq for spi-mem operations instead of spi->max_speed_hz.

I will also fix the subject lines in the next version.

Best regards,
Chi-Wen Weng

Mark Brown 於 2026/6/3 下午 05:30 寫道:
> On Wed, Jun 03, 2026 at 12:35:51PM +0800, Chi-Wen Weng wrote:
>
>> +config SPI_MA35D1_QSPI
>> +	tristate "Nuvoton MA35D1 QSPI Controller"
>> +	help
>> +	  This driver provides support for Nuvoton MA35D1
>> +	  QSPI controller in master mode.
>> +
> Other drivers for this SoC seem to have ARCH_MA35 || COMPILE_TEST?
>
>> @@ -0,0 +1,579 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Nuvoton MA35D1 QSPI controller driver
>> + *
>> + * Copyright (c) 2026 Nuvoton Technology Corp.
>> + * Author: Chi-Wen Weng <cwweng@nuvoton.com>
>> + */
> Please make the entire comment a C++ one so things look more
> intentional.
>
>> +static void nuvoton_qspi_set_cs(struct spi_device *spi, bool enable)
>> +{
>> +	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
>> +	unsigned int cs = spi_get_chipselect(spi, 0);
>> +	u32 mask;
>> +	u32 val;
>> +
>> +	if (cs == 0)
>> +		mask = NUVOTON_QSPI_SSCTL_SS0_MASK;
>> +	else
>> +		mask = NUVOTON_QSPI_SSCTL_SS1_MASK;
>> +
>> +	val = nuvoton_qspi_read(qspi, NUVOTON_QSPI_SSCTL_OFFSET);
>> +
>> +	/* SPI core passes enable=true when CS is asserted (typically active-low) */
>> +	if (enable)
>> +		val |= mask;
>> +	else
>> +		val &= ~mask;
>> +
>> +	nuvoton_qspi_write(qspi, val, NUVOTON_QSPI_SSCTL_OFFSET);
>> +}
> Note that the core deals with SPI_CS_HIGH, the driver doesn't need to...
>
>> +static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
>> +				    const struct spi_mem_op *op)
>> +{
>> +	struct spi_device *spi = mem->spi;
>> +	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
>> +	u8 addr[4];
>> +	int ret;
>> +	int i;
>> +
>> +	ret = nuvoton_qspi_setup_transfer(spi, NULL);
>> +	if (ret)
>> +		return ret;
> This uses spi->max_speed_hz but spi_mem configures p->max_freq which you
> should use (it might be lower).
>
>> +
>> +	nuvoton_qspi_set_cs(spi, true);
> ...except where you're calling in directly at which point the driver
> needs to figure this out.
