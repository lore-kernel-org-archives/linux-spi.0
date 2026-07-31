Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C44E222565
	for <linux-spi@vger.kernel.org>; Fri, 31 Jul 2026 01:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459903; cv=none; b=nrbWMH+CfVtyQfHK6pDQ1Fj4mkgHUAK98/JnEF5BbSA0/I8bxsFrf0ycS7VammvxYZ5hTOooeXTf6TNoqoWTbPW9NkbroDoU/HNP4BeRYGwnxUJCCU+JIOH6MgiZxc33Mo4kP8NhiwgRNGpLHTwSViDuF8sEFmyEUfV9D6h+sKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459903; c=relaxed/simple;
	bh=Ub/ljo2qBnXw+rZPga8aeDvObXqkLbLSa952ZHCWtBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HPdoKzWI1s+tSR8iS39kIYnUvyn1s++oSb8a8r/iTSWCxc8zZcjL07FPUZGEdRmmcyBrM8qJGpjU3/ZvEhRU96h9FjAgPgSC8sQlneVDsCWFdkvC3oXSGKTtseePI3DBySiPkipUiDm07y5+ErsLIdMjGotHo9pGRlIv9XAdqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HirRTdO4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HirRTdO4"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso226139a12.0
        for <linux-spi@vger.kernel.org>; Thu, 30 Jul 2026 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785459901; x=1786064701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lFttCK6+IiI9LAnY0cBt5R9XII1QMStajnONswWnhUU=;
        b=HirRTdO4IW/41/VRSAYdIDEvqGRwp1lzui+lUfrMfJLiH0ADLRhI8iPzdQAbngrhA/
         PGmv+vOgP5D1qfErSXKQJRvAgl0+x0Lr1YfVX+X5fQ9zoXGo18KURSdlK1K9gJPiBKF1
         wZ2hS6b6sbvGZabh8gPemhvS0/FbuUDTdKaxGtLnAJNO7ojQ5VM9+a7JUyvzhv9vXaT+
         855jqrUbbzmqX4BOV8OjTZZzjF/cSYbgoF+mKIGaVtmScvqcxN6uSb0xBKNIt91unY9v
         fjxBikHQIxPpDSvLYi6N9ibdp+feA2V4ZDdLtX/xzfIuusuBPICT16N4izAEeRi53yOx
         nz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785459901; x=1786064701;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lFttCK6+IiI9LAnY0cBt5R9XII1QMStajnONswWnhUU=;
        b=e0SSY0J7ZGSxjFoj3OzoJxhNf9JNPjLcJA8IaBBeLKVq9qWqTxXPg0o1S05u65F17q
         hJGzLtcNtpHPNJjMZ+drJtLOcQJTEw5+gJzUdSpoMv9uznl/xUTSjFO8kJm8IR+vy05p
         NQRxy5pJL39pA+dEjOKtpxbTQmmUHCRRkl0rXdaWwsnlZqqXAFGeYQxe7XfThd5R+dA9
         D0eKdJXRm2+1+5CSOQ8mBRTNa8rLnxueBuB9C9SIgKz/KTsUQowqXoBS9Hr5Qi4LCn4k
         wVe+B8rrkWQtPQDfSgXjOuU/gLXCVAXVz7p2+4DGu02dQ79d3vtKqP3a9vJQNYDPvDQa
         OzkA==
X-Forwarded-Encrypted: i=1; AHgh+RrgUzo1bkRwoU13cMOY7a9VdJr3mFIIcc2czzo5F+xEVk1qM9FX1xoZz6pTYZ9KvTYNzd/nRtEUQuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziOZJvRZmkDYHHyNWjBTodjIGbrM70BNqSln5RZcDxOk85m/B5
	bAT9q2xCjMGSTk9LOu0/71KGTeAdOj3f7If70t9ZdEYxi5rWYvThayir
X-Gm-Gg: AR+sD11mkEqrfp/C6qICiyPuXYUhCK/cafRjsN523a9ESvLyjmOaoPPpywBGGK/85PA
	U4rtGf7lPtlh4UlwQwG5YgOwB09kmQTnmXJP2iWmYX60dSnorlpvU6rUMFljY0NrRY66xFODWCq
	18JFtap1ilmgXmaaCwKGrIP1mET4isn3lkP1EJh4NlOg8qgAUAtFxvRS8S2xdpB8XKis6qb/1v2
	8jP5449panCjiHFL4R9oZnvHGdbyM2R8VT0Kf4cXsla0wcGdlrMxAhfYFjutOR4tvQeYsfACUK5
	DJBv0ucz+sj4MuFt9UbbsvtQ4LuqV58KFet7aFG8pzcPvmvMtIL7685S+zgXTMjnWpSDKkYkRBb
	XZPRM59vmxpjcYtN+xF+28ajpa4QCbgwmvTTM/oY6GLX8kFccHHdc++Aan0dj3YZtigCfXS9+k6
	3NefOT2bTrjhhbwoDown2p7iMSeT1CSv/ZfCan0Lz7Rl3Sm8OlVvrWOea+7D6FU5+zxJh30Nb57
	4fyWmP97moyEtcbN1d8Yhf0ysHuDHnZ7Y+AXOar
X-Received: by 2002:a05:6a00:12c7:b0:84c:5349:daa1 with SMTP id d2e1a72fcca58-84ebc425d21mr3954345b3a.76.1785459901336;
        Thu, 30 Jul 2026 18:05:01 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ed5e30a41sm17865b3a.58.2026.07.30.18.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 18:05:00 -0700 (PDT)
Message-ID: <6c5b44c6-f06d-4f4c-b014-5a06601454ab@gmail.com>
Date: Fri, 31 Jul 2026 09:04:57 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI
 controller support
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260727091833.750051-1-cwweng.linux@gmail.com>
 <20260727091833.750051-3-cwweng.linux@gmail.com>
 <f698ec65-1677-45fa-bb05-34aa8e092100@sirena.org.uk>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <f698ec65-1677-45fa-bb05-34aa8e092100@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Mark Brown 於 2026/7/30 下午 11:11 寫道:
> On Mon, Jul 27, 2026 at 05:18:33PM +0800, Chi-Wen Weng wrote:
>
>> Add SPI controller driver support for the Quad SPI controller found in
>> Nuvoton MA35D1 SoCs.
>> +static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
>> +				    const struct spi_mem_op *op)
>> +{
>> +	if (op->dummy.nbytes) {
>> +		nuvoton_qspi_set_bus_width(qspi, op->dummy.buswidth,
>> +					   SPI_MEM_DATA_IN);
>> +		ret = nuvoton_qspi_txrx(qspi, NULL, NULL, op->dummy.nbytes);
>> +		if (ret)
>> +			goto out_deassert_cs;
>> +	}
> I would expect dummy data to be an output rather than an input, we don't
> want the lines left floating?  There's a similar thing below when
> setting up the dummy xfer.

Hi Mark,

Thanks for pointing this out.

You are right. The dummy phase should be driven as an output rather than 
leaving the data lines in input mode.

I will update the direct spi-mem path to use SPI_MEM_DATA_OUT for the 
dummy phase. I will also fix the generic transfer path so that spi-mem 
dummy transfers remain output transfers instead of switching the lines 
to input.

Best regards,
Chi-Wen


