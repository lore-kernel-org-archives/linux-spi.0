Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66C4370AC6
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 11:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919120; cv=none; b=h1p9luV/g4BFpzWLKLe5k+aPw02pVpCj5ax0P/hxiMj24dWHLCUCWaR9O3L7qdv0GNLIYPTuD2mGlNAoUXcFh0PKXMo/IPK70+ZOPJ7DCm2HNVnqszrERNeaPPhukFOu9kHQKm8UgQAwP4BJ//ptPBJbrIk5lZ1iR2O7NaL9iKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919120; c=relaxed/simple;
	bh=S/5uyfhhCgsSjb9t77M59co6shwLNaNk5RDo3PmKTLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LlwshCpCyLO7KT9hV5k16jb8NnnZw6DkgUMtIuiL7zEGSJtrawCmIf3jVH1W8Rhupv9fpsMf5cBUn9TPtxfjxCheaSUugbc9evvqIWRjRQFTXF0M0oCkjRDok8JC3sMl+fH6pzXlwPp9vLCGTRGwCXVM72pIS/OUlSnIn4fUfVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebrGdBFf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebrGdBFf"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84232e83ca9so1749329b3a.2
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 04:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780919118; x=1781523918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RBJSxqfT0copcCoPASu9D+tQdpKRcrHjtldnEnz33U=;
        b=ebrGdBFfJsflAknKx+DaZVXgwHue21UNE00fNRvNyA1Q0WQBN56vAB1N8KlgphqxbE
         y6k/usViD+QyzgWzM6+qAGyqODV6TC0zhgHAA0Q3xO2d6AuDgl2IFH9Ciw1nZdrVohxV
         w0+NhVN/oYcCngKbBJ+4rqhec754R2a4TcS9zEZvZJgIj1hH67+iqpgD7CHPrpH1rdjr
         aPQjUIW2R5FfCRYSuheBdKdUE9R5BStcDpOqplw3/GPtqbQSdhwcj81vLQ6phIZMeEGp
         /bTAV9Mu5ROAoHn8AX3ZU/xY5PHyv1rXhQoF8USahn+UmCLC5Lu0IYvaBqGhQ7cVNCgE
         uzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919118; x=1781523918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RBJSxqfT0copcCoPASu9D+tQdpKRcrHjtldnEnz33U=;
        b=XMwsSjF2tzC7se6mrW/kY1L/w4RBfStCYTLoHJYQl4+md7kln2wvEk4DtV5BJMjbz+
         GFSK6M2sXaYz8ipX5j715QCbSV5g5D3TkQEl0hINth03vF7S/3GJwa5REgWZ64pUqbmG
         9PulZED3Q9OeZyt6XSsTe5KkORhw+f0v6MqJjk/gRu0Ydq4Ocelf/7qXl0oZzpoVs5N7
         gvRl7kbTajs5/NAg7HubjOJDn84vWu6SRCJJxEqVXEZKzgBjdWmtkxR8FxtpNCPhx64E
         66QvZcxQPFrofrni045Qz+YCZbRgWGfGG97pieLk0HElVhpsyBAdUNPJHHrJHpmj61Pz
         T8VQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iDfd35yV+6Ds0tUJRtiC2Q/B/5mph+StsAX8SvJcKOtCXlr+1mkkn877gbRtvV8qy7H5aCb9K9JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCI+uZ605QLPq1llectRz2LB8gPVDL9hFzwmAqpSC+I0wFNfAD
	kWHjvOO4ClO7+E4dtVg/zX45HHMW/MBmjpB5fz+ZmDm5aQ8EncdxpPWx
X-Gm-Gg: Acq92OFcPlTBAeOVZF6diNZvN/KPzewcxANi86tEVTV5rSWQWwyfUkz8wA/mIAEgDTX
	iQf2576M4D9zXC7FVVXgZoaZ23mwRpI/edHE1Dd0A0vG7F26qaSRcEiUOzUTk3XgGCHab+WZMKn
	V3UUXEIOW/I7wxi8R3mSU4SD0slTDBY1K1TDFOmZtGpeYYPvb+suQeCjR9UfwcvYdFVvwlYjr+l
	13lA8L9aF7IBNXm8pZwhFtE/WdA509ZugWKf0WFPaZWy9fkdp0qW4PXCmBT0zBvDzI15pa777ly
	7JbscwaGXg9Z2hg/ZZyS+XmYlZRLYpV3HZre5IMQTVfivAtiKSzgX00nSR923MHoqs2bnjqMlnT
	eOtwfsh9HCnIjwM6gLJ4XXrmF9OxLmL8hma35y71S+K/AtRP8Te6SDt4nCRa05GTM89NIm8qBA3
	5vv3VjSXuybuu4ztZ22Hq+n8ELCi0kpljINcQON85qfYV6+qRbbanKNVQ1hk+C2cjod5ednXTwA
	fGbjtbDn/OUFQ==
X-Received: by 2002:a05:6a00:1996:b0:842:2f28:4e36 with SMTP id d2e1a72fcca58-842b0f90897mr15772480b3a.17.1780919118219;
        Mon, 08 Jun 2026 04:45:18 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828836efsm17689182b3a.38.2026.06.08.04.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 04:45:14 -0700 (PDT)
Message-ID: <79e704ef-bcaa-456c-9d0a-0680bd885563@gmail.com>
Date: Mon, 8 Jun 2026 19:45:10 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI
 controller support
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260608025009.1504971-1-cwweng@nuvoton.com>
 <20260608025009.1504971-3-cwweng@nuvoton.com>
 <8e751df3-6237-4c8e-9c87-34bb67e435f7@sirena.org.uk>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <8e751df3-6237-4c8e-9c87-34bb67e435f7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mark,

Thanks for the review.

I will add mem_caps in v3 and set per_op_freq for the spi-mem path.

I will keep the direct CS polarity handling for now, and also add
SPI_CS_HIGH to mode_bits. I understand that moving this handling into
the core would be a separate issue.

Best regards,
Chi-Wen

Mark Brown 於 2026/6/8 下午 06:53 寫道:
> On Mon, Jun 08, 2026 at 10:50:09AM +0800, Chi-Wen Weng wrote:
>> Add SPI controller driver support for the Nuvoton MA35D1 Quad SPI
>> controller.
>> +static void nuvoton_qspi_mem_set_cs(struct spi_device *spi, bool enable)
>> +{
>> +	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
>> +	bool assert = enable;
>> +
>> +	if (spi->mode & SPI_CS_HIGH)
>> +		assert = !assert;
> Hrm, we should have the core deal with this.  Separate issue though.
>
>> +	ctlr->num_chipselect = NUVOTON_QSPI_DEFAULT_NUM_CS;
>> +	ctlr->mem_ops = &nuvoton_qspi_mem_ops;
> We don't specify mem_caps, I'm vaugely surprised nothing trips over that
> when testing.
