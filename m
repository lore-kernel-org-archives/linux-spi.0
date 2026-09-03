Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745A4B5CAB
	for <linux-spi@vger.kernel.org>; Thu,  3 Sep 2026 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445455; cv=none; b=X2TEMbXzCP6DGjOhUAO9R5t5blgs365ty8l8YRtFr+xiaYZST9IBG6fwj7vopywwJa5XGxVCY577JURlobzP9FwIc+alh/3+d8o7o8wAZGMTrLqvtesSIBzKGvmkScD+4Yldjn5Gqu4/3RriZJBz+ecbx3gnmriEt7A0j6Bi1Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445455; c=relaxed/simple;
	bh=FflwYYqaPCIJS/6xV+b+AbtGsDZbWO4bYd4m1uzFac0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAl0t8SbDtgQyCHO15x4lFwRF6+r7KzJIh7wTGYYcmXXOmaBifQtgq3PAWsPcgpsyeUlHlpXUPzuha6Utdq79muBM4D+U4ANt75rwNEvpDDqzjl4zS8KXHdxuL8gk+o6MHcvI+3Cv3gxVWJB9Gz4Y2kP81LXTnmQRP1bHELJ2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=SxDUoBgW; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="SxDUoBgW"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-97bf90f4b41so1173043241.2
        for <linux-spi@vger.kernel.org>; Thu, 03 Sep 2026 07:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788445441; x=1789050241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/sLblnZ/kowz5cljubMYSFLlc/UtCaMHHRCeeFpATM=;
        b=SxDUoBgWTPwPgTHBeQZAVYtz3cjprGDXdGE9gMwjh5YbJ8XRVBhLZhKw3ssWqYf10+
         3DlZzJ8hxo+ah/znsjfW7FEvuDFn2oMmM1fp3DFl+ArTJ3vzaNPeP0L1vk6FZBnMfvQY
         2oGEz9Ys1uFsO38de0RQ0I9DGptcJFzSW/CAcgJwwFEavHElWljRPs7U/9TUah9R/7ay
         GiK3eE2oLcZC5gNa/qw0di5jOqibTowWkhhoI1zZNWbC+eY+WWYgmel9r9KCtkYWDx3T
         4VGGNdFFiTWh4MCk/QoHgXxVoK/2KYFVmr/88zPAfWkEb9vLD52jIfPbpZ46V7hUzNZJ
         30qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445441; x=1789050241;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/sLblnZ/kowz5cljubMYSFLlc/UtCaMHHRCeeFpATM=;
        b=TsakI4Q+OZmtLPxIP1HHdXx4nG2JTsKbcYmBl07x0PSF2OoYXtxLSccz+q7ss59ajx
         JbdO4sK3K7tCOEj7vy+GR2YU7Mm9kx+0mfgYPdJ79p48HxaVA1YQzimk4K1C4DC8idJp
         lwNwR5cZ9bzPWxdHCc5DHTmFTAuC27WJYmsJbEbL0L6h6VwFJis7GJ3l18BJzkc5ZN6b
         ZOS1dGnB/8bdcKYRaB0Ii541MPF7uVwJilpVmM34j24aVhCteM8lwWVYmQGoeePr6LAL
         v9uXn12qkrMdHVQgA/YTBCuBAbto6jZ/6y5vhDC8RkzjCFCwcI1aCSGkSi3oNhn1r/VI
         RimQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeXUuAdWW190lLwBzspoNBM1P/YhlQT3QwZtlbwDF+QuXuE49G+5jccVGz2FiPNEE7yvC3Hk7vlao=@vger.kernel.org
X-Gm-Message-State: AFuF++kf1bgsG9HH4MOWFTFqG32gdBaM7JbnEid1KC2r9zU8l6/EXI2P
	H2N4fPH2wpByfkdU10osNifqgSRuZCPAnEYqj0c9/NUbJYWtd2Gb2mHEimi5WsXIaZE=
X-Gm-Gg: AYBFou0ZzBluDyoN0rifAqKznzjoiQGnRHRCoEH70hGYYfWHFi3lJFzYoKeo44HP/Jd
	UrpU8ZNsN3TwaF60rKd0KqFNUrla+IuQ63Cv4fNOpEaDCugQqnc5GYOf1SoIuLxho718TQPSBE0
	u8Iy6igTW8gdD/ylrGmW9afePmCz3nyNK3Ur9THwSCmzOVAa3CyHE/PNcxJIURps1RIlUsAqMom
	TGs08+KXZRPKakpZDAjk11apsRU0TnZ0eo2OI+pjYrV0Ak6bT5ou99nHSFrptsXFVM+Q3ryZO/3
	Ef/DucsivJORYYXt9SZrKChq6MTSJNi/DWy0DDsNqfq3i7vIaTVu4w6g/NMPxGoB+fV06tgJqE3
	QY3Fempb7CVCOzt9GDFg5HCPEnwz8f7tw/NUHXK+9M2cGJx3wl+HbyDDpYTE/zegBLJsa96i4HO
	njFf3TmnKS1URlg/dPxdI3BlLbZZcltsALPMtoRkLBihxZnhs8Ah+UTcYGiPkgJ+oCQd65UuNi7
	egf6ftV+/+0TKap7Cky5GOrDqluwOxQabTT
X-Received: by 2002:a05:6102:32cd:b0:784:ed9:1a1c with SMTP id ada2fe7eead31-78a1f3ccaffmr4880777137.12.1788445435981;
        Thu, 03 Sep 2026 07:23:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e24:471f:c835:8147? ([2600:8803:e7e4:500:e24:471f:c835:8147])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1b89ee0asm4420005137.8.2026.09.03.07.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 07:23:55 -0700 (PDT)
Message-ID: <db8c87a3-1035-4023-8929-aae47ef7b20a@baylibre.com>
Date: Thu, 3 Sep 2026 09:23:53 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: axi-spi-engine: fix stale SYNC IRQ pending
To: Jonathan Santos <Jonathan.Santos@analog.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc: broonie@kernel.org, nuno.sa@analog.com, michael.hennerich@analog.com,
 jonath4nns@gmail.com, andriy.shevchenko@intel.com,
 Dennis Heinzel <dennis.heinzel@irs.systems>
References: <04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <04d51e99b8cddce51113db933d806e83848f04f5.1788313558.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 8:49 AM, Jonathan Santos wrote:
> spi_engine_setup() sends a SYNC(1) command and polls SYNC_ID to confirm
> it was parsed by the FPGA, but never clears the corresponding interrupt
> pending bit (INT_PENDING[SYNC]). When the first real SPI transfer starts
> and INT_SYNC is enabled, that stale pending bit fires immediately, causing
> the IRQ handler to see the leftover SYNC_ID from setup, match it against
> the current transfer's ID, and prematurely signal completion before the
> hardware finishes.
> 
> This race manifests at low SPI clock frequencies (~2-3 MHz), where the
> FPGA takes long enough to execute the transfer that handler is parsed
> before it finishes. At higher SCLK rates the transfer completes fast
> enough that the issue is masked.
> 
> Fix this by clearing INT_PENDING[SYNC] after the polled SYNC, ensuring no
> stale interrupt is left pending.
> 
> Reported-by: Dennis Heinzel <dennis.heinzel@irs.systems>
> Link: https://ez.analog.com/linux-software-drivers/f/q-a/604145/axi-spi-engine-stale-sync-pending-can-complete-first-transfer-early-at-low-spi-clock-2-3-mhz

Should be Closes rather than Link in this case.

And needs a Fixes tag.

> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 02bbc5d0cfc5..9e9bbe109ce5 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -887,6 +887,7 @@ static int spi_engine_setup(struct spi_device *device)
>  	struct spi_controller *host = device->controller;
>  	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
>  	unsigned int reg;
> +	int ret;
>  
>  	if (device->mode & SPI_CS_HIGH)
>  		spi_engine->cs_inv |= BIT(spi_get_chipselect(device, 0));
> @@ -922,8 +923,13 @@ static int spi_engine_setup(struct spi_device *device)
>  	writel_relaxed(SPI_ENGINE_CMD_SYNC(1),
>  		       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
>  
> -	return readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
> -					  reg, reg == 1, 1, 1000);
> +	ret = readl_relaxed_poll_timeout(spi_engine->base + SPI_ENGINE_REG_SYNC_ID,
> +					 reg, reg == 1, 1, 1000);
> +
> +	/* Clear the stale SYNC pending bit so it doesn't fire when the IRQ is later enabled */
> +	writel_relaxed(SPI_ENGINE_INT_SYNC, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
> +
> +	return ret;
>  }
>  
>  static int spi_engine_transfer_one_message(struct spi_controller *host,
> 
> base-commit: 183f05a300eab41e4578337eac59335730dfebf9

We have the same poll timeout in spi_engine_trigger_enable(). Do we need
a similar fix there too?


