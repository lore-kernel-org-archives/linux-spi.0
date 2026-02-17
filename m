Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFAF1C4A20
	for <linux-spi@vger.kernel.org>; Tue, 17 Feb 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771308655; cv=none; b=mhw7L0w9YZPHSVPz1zo+jxPWo/vhjEoMcDyMYIFV3WjhveQSUjAiXDvzaXPGgoIHFxiXqumYe3RunCBkbCw1+VmGFo6S5smqxfpoEJeS1Nwt09Ana3e0ssKLzF88VUdv+sR9ZTZwN7RWV49g4T+WBFWS47Vnfnbe3qt5CGB2G1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771308655; c=relaxed/simple;
	bh=RZNIWl6tGl3E2IWfidbVZrbrr100fglzO0Fmmh8y6+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0tcHZXJpHJmadwYnDQ0hX102+z/dRKTuEVzsECeZzBxCIq81oRw8Ja7fLmT3k00fnDCd9yq+5IbNGlEpnDWv0jVMg6vakTx3OS4xt2JdcGhIDNI6Qe/RdUqS9oYMSIX308gzUR8N9tg5iMUUDpmdSJ90pXfc9hzCvxDp3lGJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6WiyaIm; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6WiyaIm"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e5f52b13eso3732042e87.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Feb 2026 22:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771308653; x=1771913453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2EmaR+jdHZmVae9mRMz72mzoy+uR0gNkmyjhuxhcrE=;
        b=a6WiyaImZb0auFHUIOvyDTb3kTVIsBEezsCb/JIPcLMi1a/jnqkoWQot+djcnAUNLk
         0G5B4oUZjSJ2xvFEX0vgkqMyTsnCjLMhasKBmDwcEjVUdj4ag/XByZsDfonytXm35w6j
         bPW4TBxayDZLXvUajRbnXKKx6G/hjk1zDx/3ORDh/H25Wma5OC9dgM/pA+loAJEWt1td
         BMC1hnLJOFjk8mbrF46Nxd+tV9qpo/U78ABdQ2VawQDDoOWQZUQIxVa3fLdLpeskGwPP
         3kjwVHwCRUYUg/Bn2XR5GCWY68GvckJfLViGeCRyA+LhFDOMvHb579EUTkh8senxpg4D
         38Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771308653; x=1771913453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2EmaR+jdHZmVae9mRMz72mzoy+uR0gNkmyjhuxhcrE=;
        b=HLbGEBh5RxCtLSBzBVOO++6DFhd2NrdXS1Xsk76pTTehXnbUSOIgpU+au1QFet0jZy
         UeskqH0U+hi0k8KK3F4YNjY0yUFc4p0iEwlMNKUL2K9sw3u/yxysWk4wrYTMy2yG4lAw
         99JyBgzky5j5D1tnE3cPKXIocY3DJPmaBdVPfjcOx6v+6yUwehA094dbgcGPeGy9RSXN
         IqLiihQmPYuzLmSI7fTGQ1Wr9Ht7ifWrg1lWkWXGQXYlhjZkhudtut7yPBWJnc/tZL1n
         2pg+a/7eYfesTD8noR/cVbD+/LWtVAiCOiKJgn0vAHXwHfLp+ziHMkFQ6ouwz17hX9MP
         /mEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpeguu3oIAGd/QjAzQc31fIhpjCDyJrZpwgmXtiUh1kw2wr/XbFJmvoc7sokHrrzlgQgZfqd5g1C4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6vv3yWm54lQ9GRdfrHWxcpnrwHV6XLZdEAcRD0oF131FwOsa
	jTuMp9+C2gIBo2VqcKL+yA4LkmWT31lHPoL6mFXglHrxS635zRC3L/LG
X-Gm-Gg: AZuq6aJhjnjOkv5GvDDpwkJI5s7svnbIjNo1kFkHnfv2CYw049dItO5eSuF9u938Hwq
	qqlVVlZsrVsF0binBm+/tK8+ldNhE8HkxciC08Xu7a2vIRLuwInWwBece+PRzeGaJ0l9TPaBcxZ
	zvq0cL6796IgZZTBxrhsmkV8ve7vSUpjwKVLxPZopqYPs/NlNmgCfkLYNHkwR9gg5bCex6s9onu
	IvZ1JkA/ukrpNL0yJPtUnTapBFWLtgJnpwF1Ze34iAmzvFTbQnUvA3VSjVoGNjeHi1PePZuTthO
	b5SWi+J4KonFI9y+du0P1Mr2k9c8wLy69U1KCQIoCgx+0XSgjel4/YDus2i5O7cyskG4OD7wb62
	gzapY/UUDC8yS9WalM2RCpK/oaBGpx1pQarDtdRWmF0XLQoCp3dPUOYlcBx7JzMxjDKuwSlVhqp
	0q4sRV4Fqa94K/JNcXVRxHLSlLv4zrlfl82ihYgC2SE7KIH6AAjpjESlcPEr8sMGKZVvFpEO0=
X-Received: by 2002:a05:6512:3ca1:b0:59e:1727:fcff with SMTP id 2adb3069b0e04-59f6d3879demr3028546e87.44.1771308652390;
        Mon, 16 Feb 2026 22:10:52 -0800 (PST)
Received: from [10.0.0.100] (host-185-69-74-59.kaisa-laajakaista.fi. [185.69.74.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f56867fsm3665403e87.24.2026.02.16.22.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 22:10:51 -0800 (PST)
Message-ID: <d1ba23bc-d8cc-4109-985f-76bb454c6d4a@gmail.com>
Date: Tue, 17 Feb 2026 08:12:18 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] omap2-mcspi: periodic zero TX in target mode - debugging
 help needed
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
 linux-spi@vger.kernel.org
Cc: broonie@kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org,
 vigneshr@ti.com
References: <941806a6-0deb-415d-8af3-e78d6104da1c@yoseli.org>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <941806a6-0deb-415d-8af3-e78d6104da1c@yoseli.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12/02/2026 17:53, Jean-Michel Hautbois wrote:
> Hi,
> 
> I'm seeing a puzzling issue with omap2-mcspi in target mode on AM64x
> and could use some help understanding what might be happening.
> 
> Here is my setup:
> - AM64x as SPI target, external controller at ~1 MHz, 1 Hz frame rate
> - Target mode, DMA enabled (k3-udma, not legacy EDMA)
> - Fixed 64-byte transfers (matches MCSPI FIFO depth)
> - Full-duplex, using spi_async() for continuous operation
> - Kernel 6.12.y (also tried mainline, same behaviour) + PREEMPT_RT
> 
> Periodically, MISO outputs all zeros instead of the prepared TX buffer.
> The pattern is surprisingly regular: every 42 or 43 transfers.
> If transfer #10 fails, then #52 or #53, #94 or #95, etc.
> 
> This number (~42) doesn't obviously match any power of 2 or buffer
> size I'm using, which makes it more puzzling.

Curiously matches with the answer to the ultimate question (THGG) ;)

> I have verified a few things:
> - TX buffer is correctly filled before spi_async() returns
> - Added debug check: buffer is NOT zeros at submit time when failure occurs
> - RX works fine (master data received correctly)
> - System is mostly idle (basic Yocto, systemd, no heavy load)
> - Logic analyser confirms: zeros on MISO, correct clock/CS from master
> - Forcing single CPU (maxcpus=1) does not change behaviour
> 
> This suggests the data is correctly prepared but doesn't make it to
> the FIFO in time. The issue seems to be in omap2-mcspi or k3-udma,
> not in my slave protocol driver.
> 
> DMA configuration:
> - Using k3-udma (AM64x UDMA subsystem)
> - Single DMA descriptor per transfer (not cyclic)
> - DMA-coherent buffers allocated with dma_alloc_coherent()
> 
> Questions:
> 1. Are there known timing constraints for target mode DMA that
>    could explain this periodic behaviour?
> 2. Could this be related to k3-udma descriptor recycling or
>    ring management around ~42 iterations?
> 3. Is there recommended tracing/debug I should enable to
>    investigate the DMA/FIFO timing?
> 4. Has anyone seen similar periodic failures in target mode?
> 
> I can provide more details, traces, or test patches if helpful.

I would enable all interrupts (channel 0 is the relevant for
non-provider mode) FULL/UNDERFLOW/EMPTY and see if McSPI itself reports
any starvation.

Iteration is number of one-shot transfers (of equal size or variable size?)

I cannot recall anything which would result such an issue, but the
consistency is more than interesting. Re-reading the TRM for SPI + PDMA
and BCDMA (or PKTDMA is servicing McSPI?) might give some clues.

> 
> Thanks for any pointers!
> Jean-Michel

-- 
Péter

