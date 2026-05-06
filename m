Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A633736AB7C
	for <linux-spi@vger.kernel.org>; Wed,  6 May 2026 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070492; cv=none; b=qb4/ZP8L54UyXDBF7lmbATBSWe/CK8eafY/onvFM99DFrMAcoOlJ04mN914ejbeZWKowo9RkfH4iAk8vS1388OgrREqORAualqJDJN/PnSDHyd7AHdqxR+P1z3g9DZ/nAS9rNsUmUpw/3S6PHOPkyHmgBA/5C0pMasqi4nUOT28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070492; c=relaxed/simple;
	bh=vclG0yxAvF+A/2roV7osqFbBYgf+u0vUuYzd2t5GLzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPYYJRdHuQyJcj2naI09sW5T1AHzGlK5YeAfHEDfGbbb4sNXywjI0IWgCXQWUkNAqo0GDD3RrY3cb8ErpE9Hk0vmSPt0aHn5jv1VHO71DaUZDvxTXYtI9QUm8UnZbZ57/1GejjI2zaRk0R1eYc8VSfKChvOO2N13QFpoYW2BPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xskv7F1R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xskv7F1R"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b150559bso44037095e9.1
        for <linux-spi@vger.kernel.org>; Wed, 06 May 2026 05:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778070489; x=1778675289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgsWJ43+sPMyFM6YZi9dneb609gv57UFa/hUFdFYocw=;
        b=xskv7F1RGtGi8zD/UnbdcgR1YZziglp0fHeiJ2Z4aWoTi73VyKgyRHiq1KaZehrBjK
         Lg+KIP6pWBH2Ugy8gIsXOHD5XTWYoBF3aXgatwTV8dHrxyBs0VtXfr8xmVJXFT7UksP5
         waZq9xtMoKoT1YaJ4SnsmReRHGNWLsT4giytb2h/OsPHObT629UyIGx+h3u1oQq2kbTu
         txHKxzhvC9iM+p/jasZTkQqRW18yHtujShomKocfvTySM3etJAafb3NoZJ/TrFm+/gIQ
         wsS6ygZ/izRtWQYGJikLnGQFti8MTr0R49lTPYLKJE1PNHNrHmMQCtyXzYOfTHEYissc
         guxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778070489; x=1778675289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgsWJ43+sPMyFM6YZi9dneb609gv57UFa/hUFdFYocw=;
        b=GI8NQ2+4Ej2UVRVRCXGhuCgLSAEuKeeWLsJJxaFIufTItivNf9WbZ1bXKMsl8XMXxp
         MbqsklVs6EV3pxM6ZdgB8NYCh9FKYSVnn7Umid8YXhHbI8ujf2YDLX8xjX5jGgZh8KvQ
         QGXn5dsh1wFsDMkhZWpRC9pwRltfJc5CcXyRZqtPVeO1e45B3RJl18wWdQjXqBQt8uxg
         YyLdZuxO7qYmzm+hbZrJttdkc1fZAGPXM6X2rfzMLie5Bh/hIYpwTiiUpXa/gJllXS97
         BCzZzX0LXhlt/fnBaA/76INkNONbVKKtYdcCAQMiZo6+LJSyL8Zru3c7ruSSXdewMRMg
         16XQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZpeFSMk6X9bT1C7WrW8LVCJHuJoiN7bgyongL7PZISy6CWBm6SNUKeNFwg9wSy2vsfJrAme+vY74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAWdsZVFw3R5vD4Ll+A+szL5Cjgo4/dpBnZFxPVXfj9/vs1W5i
	kJTj/dgdGJA547fcoxHUjV+ZdVdGXoaqz56sPjuxV3gDP+4vAWt31zjWup6J3a0kzz5YGfTBSv3
	SudQUq0x8JA==
X-Gm-Gg: AeBDietCtCAAixhzp674KOZWa9J5ku1wjwPJo6JqXGkNy/NAysnZCtiDV8btvDm6mUc
	5hMVfvAReQGnBY4zFufIQKRjZtL5pYIhOULovuOfrcW1uLZiLNM45xFGxLz4yfHibmy8u5n8lS7
	xkH0QC2QVAgjTHykDcH6UbR8kkU7+TiVI+ByE7QdCi+4UooWhUQ1FcfA/DBqbHOP6FofB+cxh8n
	fYBwhV8Q7VtgRm/b7Pg5vaHtYiYr5G0a3A1VKrzTQCvhPsZLsWsOQ6wjLd5X6HrV1RhFP9Qi2Xp
	McS2mRb3Ksbez0eo1fzTXsIjIu/A4lHZCKYtNV6ffdXU13k9PgeBrQWt2Z+RMuib+qtmR1J38Kf
	HhaWKsZnKs1qGq3SXf3cb3Pe4kQUhWsED3nEQLjQ/MUaqXi3QkMX5U6+cFTkovyphodLGdIG3VH
	W59Js3o6WNAJQn5XHJ0klRzwZnmYWaRMu8B5gexINXmF0=
X-Received: by 2002:a05:600c:811a:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-48e51f369c3mr57793395e9.15.1778070489168;
        Wed, 06 May 2026 05:28:09 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e539109b7sm41077585e9.15.2026.05.06.05.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 05:28:08 -0700 (PDT)
Message-ID: <06406c7b-c141-4997-9921-9358cdea7641@linaro.org>
Date: Wed, 6 May 2026 15:28:05 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: s3c64xx: fix all kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Juan Yescas <jyescas@google.com>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
References: <20260416224056.985233-1-rdunlap@infradead.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260416224056.985233-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

You missed adding the SPI maintainer. +Mark.

Also, there's another kdoc warning in that file. Do you care to fix it?

scripts/kernel-doc -none include/linux/platform_data/spi-s3c64xx.h
Warning: include/linux/platform_data/spi-s3c64xx.h:40 struct member 'polling' not described in 's3c64xx_spi_info'
Warning: include/linux/platform_data/spi-s3c64xx.h:51 expecting prototype for s3c64xx_spi_set_platdata(). Prototype was for s3c64xx_spi0_set_platdata() instead

Cheers,
ta

On 4/17/26 1:40 AM, Randy Dunlap wrote:
> Add kernel-doc for one struct member and use the correct function name
> to eliminate kernel-doc warnings:
> 
> Warning: include/linux/platform_data/spi-s3c64xx.h:40 struct member
>  'polling' not described in 's3c64xx_spi_info'
> Warning: include/linux/platform_data/spi-s3c64xx.h:51 expecting prototype
>  for s3c64xx_spi_set_platdata(). Prototype was for
>  s3c64xx_spi0_set_platdata() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> v2: add tag; rebase & resend
> 
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: linux-spi@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
>  include/linux/platform_data/spi-s3c64xx.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- linux-next-20260415.orig/include/linux/platform_data/spi-s3c64xx.h
> +++ linux-next-20260415/include/linux/platform_data/spi-s3c64xx.h
> @@ -30,6 +30,7 @@ struct s3c64xx_spi_csinfo {
>   * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
>   * @num_cs: Number of CS this controller emulates.
>   * @no_cs: Used when CS line is not connected.
> + * @polling: Using polling mode when %true (no 'dmas' property in devicetree)
>   * @cfg_gpio: Configure pins for this SPI controller.
>   */
>  struct s3c64xx_spi_info {
> @@ -41,7 +42,7 @@ struct s3c64xx_spi_info {
>  };
>  
>  /**
> - * s3c64xx_spi_set_platdata - SPI Controller configure callback by the board
> + * s3c64xx_spi0_set_platdata - SPI Controller configure callback by the board
>   *				initialization code.
>   * @src_clk_nr: Clock the SPI controller is to use to generate SPI clocks.
>   * @num_cs: Number of elements in the 'cs' array.

