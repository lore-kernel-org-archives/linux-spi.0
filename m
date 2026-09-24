Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4653D0938
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216096; cv=none; b=DHLzbltwBgZeUbBVmhiKvMuaSTU3dlO94gtye6H4/b6ONUBlwRmRbm37qybhNKZFaIMNjAH2eKTfpFipQkGy9yTfulNNaQ+1wBrFiQvuuCweO3hWaW/RIpoOUR4wjmKJypeb8kbIH/ksYXUGIlvGak871Zr2+htqDawg5yGZkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216096; c=relaxed/simple;
	bh=8IrYIX+nOfcakkM7/Z3PGPHAeSZ4D2Fr5eds+h+4gc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWCq7rfZgNudQ3Zn4LddUE1IA7rtUy2yJIzH/bjKwpN1MgI1UID4U0ptclFxNBeGVWw465/Xn1Gr3nrAhNXqgGjAxCi4NOmeJa+fOdEwd4Q3IqCfx5pA0HV9pWpeN77TN7MVoH4CIcE2NWgR39Vyc8qau1izmufekQfsOb2E2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTscs6UJ; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTscs6UJ"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b355ffso774508b3a.1
        for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 19:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790216094; x=1790820894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9n1xLtwZfMoWvvLkdGoxwpegQEwUeD6t6y9z2tkYqM=;
        b=nTscs6UJal3qo8jlZ2zTTe8WZasOzFHaV2rEwRy9pLIQqyE9KaHjz26JsSBJBunpoP
         U5FLjgl33zofmViWIPxeOzDQ33n9kXaXBr94Jzfd6fD35cW0acBRkSmnCmieA4WUI6Xk
         oEXZrqTTze5DOO1pom2qoBGyIMBoG3xBWPuoRh4FJNa3BKqi6J9r4boO0kv+oYwv879I
         +4d0TbwyEQAuRXgRH1QmWzigRTYndIOfZe2ilH3pp356gACedvLEwxeKL1mvyYZg3CMQ
         77o30uvFUhobzUMFtc7Vkg1ozZGJpDi2Dgcrhx7nVilbrost8F2S+yTJTlq3g25A8vpg
         e7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790216094; x=1790820894;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9n1xLtwZfMoWvvLkdGoxwpegQEwUeD6t6y9z2tkYqM=;
        b=xx40VRmsB57/9GtLLq/a71TQ6kwp0AhLm+wE/VSZWwZBR4QXBghxOf9RDjEdyaCK65
         t9QV+DYvA+YWdRTfzDuLMvHnBJfS2Ya5az6Q9uBuTBOpPpcX6qIcN0u0ZutgofwmyjOH
         HM08i+fzEmU37twULLI6pidagKqBzsNd75ms3zmFn5ZaeLsO0MZkhYUpco/I5u7raOvB
         7z6bYmlqsVOzS1dUbNNlILZ/gaND79nt2v7KdqTVqig23AkAuF1vUPL4y/sfBlrDzZ5e
         Vow579qzB2UNWUdNW4/ZV0TYqGP2WveSgEinY/klMYj+yED40QQSb++LDsV2HNy9PBp1
         vcNw==
X-Forwarded-Encrypted: i=1; AKwUvBxO4w8RtqiE04VJwndDk2J0PN+vA6y4ld5UyrO2Wtck4ogtj+QNIR59YoZ5na3AzH3ivCKkxW6C0S4=@vger.kernel.org
X-Gm-Message-State: AFuF++nes/HsnOJb7sMAn+NBdr1WaB7vdN2jp6eO6Cxn1vA9TBIDNz2X
	AKrmmbF+3sDFaB8dBBNG6VDy5vwIuvWV/HMu6t6Ea8cW+2/3GyBwztpshbgA5w==
X-Gm-Gg: AYBFou0/Ab77RAvwqy2Tn5LWgtiU9Ipgj4/aN3JSIvN+nnt2KNzWjIkhXTX/d8s/L51
	b9ktsuH8/6TVOnpISMM8fG3oPkoAGit/OZZzX9YI2ozBBE7MPLsbIZZp7ZrGNdL7rkhr123bL4n
	CkTPkzL9Al8cZ9Mwm4e7EAYdCa5GOiRoGlEO54+bRtUiMFffQqj2kL82o8dglq4twgAAUDER50D
	P9/j6pRPya3Fho0lWf6dsYlENLbrsxpxvxLUm9uRC7dlM0jQszWhRWneggDjCrlZFE2yjqXMKpU
	Ug9GgVlGcgvXFzWRxJPij/lw8MrDVWZxhO4DBIRnPsmR/akChqeKdHioy+KPf9Ywlpp6wa9gD1h
	bX/k3TvzME2luUPAzbAORGqrpTFpsHcgQa/aBCXmSfCzsb1yIQzyTEx1qiHbTgTxdm/LodyS8ro
	BgFcREmsodl1eKHA1Tpr4HSf/ldfntO5OGmAvBxtdBiiER005xvJhtdqYTA7k3WZVe14zXDZcKW
	f2YpAahzCG0w9n9Uxtg64nF92ES43KgY7YCOsq4uNjIq12hlRA=
X-Received: by 2002:a05:6a00:9093:b0:874:706d:9631 with SMTP id d2e1a72fcca58-87e9acf16b5mr716577b3a.35.1790216093965;
        Wed, 23 Sep 2026 19:14:53 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1afb8e37sm2069214b3a.5.2026.09.23.19.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 19:14:53 -0700 (PDT)
Message-ID: <c2fc4b72-190f-40fa-aba9-c301db42598e@gmail.com>
Date: Thu, 24 Sep 2026 10:14:51 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: ma35d1: Add Nuvoton MA35D1 SPI controller
 support
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260923041926.425551-1-cwweng.linux@gmail.com>
 <20260923041926.425551-3-cwweng.linux@gmail.com>
 <arPFHNrYR_kWl8vs@sirena.co.uk>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <arPFHNrYR_kWl8vs@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Mark Brown 於 2026/9/23 下午 08:25 寫道:
> On Wed, Sep 23, 2026 at 12:19:26PM +0800, Chi-Wen Weng wrote:
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> Add support for the SPI controller found in the Nuvoton MA35D1 SoC.
> 
> This looks pretty good, almost all of the comments below are just
> stylistic things due to duplicating work that the core already does but
> there's one query about possibly excessively turning the controller on
> and off.
> 
>> +struct nuvoton_spi {
>> +	void __iomem *regs;
>> +	struct clk *clk;
>> +	struct device *dev;
>> +
>> +	/* Protects read-modify-write accesses to the SSCTL register. */
>> +	spinlock_t ssctl_lock;
> 
> It's not clear what this is protecting, all the users look to be called
> from the SPI core in a single threaded way.
> 
>> +static int nuvoton_spi_set_speed(struct nuvoton_spi *nspi,
>> +				 struct spi_transfer *xfer, u32 speed_hz)
>> +{
>> +	unsigned long clk_rate;
>> +	unsigned int divisor;
>> +	u32 clkdiv;
>> +	int ret;
>> +
>> +	clk_rate = clk_get_rate(nspi->clk);
>> +	if (!clk_rate) {
>> +		dev_err(nspi->dev, "failed to get clock rate\n");
>> +		return -EINVAL;
>> +	}
> 
> You probably don't need to do this on every transfer, the driver doesn't
> change the rate and it's not the cheapest call.
> 
>> +static int nuvoton_spi_configure_transfer(struct nuvoton_spi *nspi,
>> +					  struct spi_device *spi,
>> +					  struct spi_transfer *xfer,
>> +					  u8 bpw)
>> +{
>> +	u32 speed_hz = xfer->speed_hz ?: spi->max_speed_hz;
> 
> The core will ensure the transfer has a speed set.
> 
>> +static int nuvoton_spi_txrx(struct nuvoton_spi *nspi,
>> +			    struct spi_transfer *xfer, u8 bpw)
>> +{
>> +	unsigned int bytes_per_word;
>> +	unsigned int offset;
>> +	u32 val;
>> +	int ret;
>> +
>> +	bytes_per_word = spi_bpw_to_bytes(bpw);
>> +	if (!bytes_per_word)
>> +		return -EINVAL;
>> +
>> +	if (xfer->len % bytes_per_word)
>> +		return -EINVAL;
> 
> The core ensures these too.
> 
>> +static int nuvoton_spi_transfer_one(struct spi_controller *ctlr,
>> +				    struct spi_device *spi,
>> +				    struct spi_transfer *xfer)
>> +{
>> +	struct nuvoton_spi *nspi = spi_controller_get_devdata(ctlr);
>> +	u8 bpw = xfer->bits_per_word ?: spi->bits_per_word;
>> +	int disable_ret;
>> +	int ret;
>> +
>> +	if (!xfer->len)
>> +		return 0;
>> +
>> +	if (!bpw)
>> +		bpw = NUVOTON_SPI_DEFAULT_BPW;
>> +
>> +	if (bpw < 8 || bpw > 32)
>> +		return -EINVAL;
> 
> Again the core is checking this stuff.
> 
>> +	ret = nuvoton_spi_enable(nspi);
>> +	if (ret) {
>> +		dev_err(nspi->dev, "failed to enable controller\n");
>> +		goto out_disable;
>> +	}
> 
> Do you need to enable and disable on every transfer, or could this be
> done once per message?  If you need to disable to reconfigure it's a bit
> more complicated, but otherwise it's overhead to bounce the controller
> on and off.  Potentially it might glitch the data lines.
> 
>> +static int nuvoton_spi_probe(struct platform_device *pdev)
>> +{
> 
>> +	ctlr->dev.of_node = dev->of_node;
> 
> The core does this for you.

Hi Mark,

Thanks for the detailed review.

Regarding SPIEN, there are two hardware requirements/behaviors worth
clarifying for the MA35D1 SPI controller:

1. SPIEN must be cleared, and SPIENSTS must become 0, before modifying
    CTL, CLKDIV, SSCTL, or FIFOCTL.

2. Clearing SPIEN does not change or tristate the SPI CLK or MOSI output
    levels. Their output levels are retained while SPIEN is cleared, so
    disabling the controller does not introduce a signal glitch on those
    lines.

Therefore, disabling and re-enabling the controller is required when
the transfer configuration needs to be changed. However, I agree that
the current driver does this unconditionally for every transfer, which
is more than necessary.

I will rework this in v2 to avoid unnecessary SPIEN toggling and only
disable the controller when required for reconfiguration, while still
honoring the register programming requirements above.

I will also address the other comments by relying on the SPI core for
the transfer defaults and validation it already provides, caching the
input clock rate instead of calling clk_get_rate() for every transfer,
removing the unnecessary SSCTL locking, and dropping the explicit
of_node assignment.

Thanks,
Chi-Wen


