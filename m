Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91048094E
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042323; cv=none; b=D/wc0LWUIZMI5hvdPdOa09dX9ipOJbHBgt0ZNehEuUBGJm6vWIKUKaGftf65QPrTYXA0lan74bxtosKEfRkDbMZePUaGgxmlQFANy5dLDheaMAg3v/QQ4QtPiOgSYFbXkLxt0ri7yURTL3mnTuiTxXUi0Myku9Lx/PZlSxo4xyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042323; c=relaxed/simple;
	bh=O72NQanomfjhavN7F/qHh2eko7A3dz3Eoobj/WSMH5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQERPM2YBcFV+dxx4X03Ipa003/6UxxwdW2VcTiFQrrxBnX5aE+UV8rTGy9m38fNEp/FmonpHOS3kMtJT1aqeDscGYo7N2YZmu/153j3pfkWzh9Uye162Fs9gQG1xe4s5fJ/0I7PMYIXm0ohlIj5CR3qnsCoBsEaBZgNORyVdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ZWP8AaHW; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ZWP8AaHW"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6a198cdc4e4so1481662eaf.1
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784042319; x=1784647119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmCnXZIw0JD5s9YL0UXq5CVWEdUQzRT7gvcW44Z4F90=;
        b=ZWP8AaHWnLArllofE38Mw0ijL+pWRK27F2pygT2I+02ISFux38Y9m0sOpucPiNNK/H
         /VswC/rXyJGfp0FuBnhleAXWXVPMzaEE10Vfp6vncbIoVF5U+6swkLt5qGBgn9kAqyzg
         eeqzHR0PklrMwbMGpVtgqF8pi47AYTMIyoiFRgMo4Hv4oHTvkz/fxikxSXRtWHibHCCd
         WPQk1OnIn1qa6z/SA7U7COSpZug3ze5JBw57/ytfsfwl96pQsc0Q2W7nTo/9RUK0PVj5
         5D+93VOJmeowl5fPMSyDZ3TheSjQkmoZzq/T2HhCDnU38kSSkVQHU6CW0LUKXWNmYR3H
         MMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042319; x=1784647119;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kmCnXZIw0JD5s9YL0UXq5CVWEdUQzRT7gvcW44Z4F90=;
        b=fMQ+7aHtWxuFTRSjgVACV+pvwKGaJ0r8NMM+LK5HGxJdt5SVoY/RS5RsUDO/sXf0Yf
         4odM1enEdEgEmS6Ut98L3fUSW1dn9HMfiHzJfgXsv2SUENeWmwrGvBA0d8nZ65yBPiIE
         C3GyMsFdihpnV13tlT49y4uwNA8ERv14QrmuLNnCVrf5ZGR9zco7KyGWXkql4KK5xUl5
         iOhM7J4RlHDlSp8TDVoqz32ojan3guQLxxCldWoLe9PqYoHRrWHGJfCgHM9rZFLxyE9i
         DAagJx4/us6gJV806Msf4p3F93U0WE/s2gHLsqBN9AZoDj4DPr0ivqKc74VkiEORjOnl
         evPA==
X-Forwarded-Encrypted: i=1; AFNElJ+yqws6Vzvv+QKOBstJRXXjl6jgEJ+BDUepmodnWv9zMt3Ko1DzyW51gDMGLxXO9Rdl2J7E00Xw4CA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CrOCsD/BeV/WlU+SAeoEBPGpWOCdhAfpq5T+g/7BR5yTheLb
	dKbq7C/O9eBVxXW868oR6xBw7z7FG2GT4Gym00+i/lh7HObN5bhb0h+1/JrwqVXfd/yNSg0HX0U
	ccYsA
X-Gm-Gg: AfdE7cknLIj2CJYTkiSNU3I+cLgkbvgjY1Vqu6SrLvhQ2JemAuHDU4akNd/fKejpFPj
	nCUWcYPCvhubIj1vFfXhmfttKQL+O+DS8J3Bse4rqnYJ3N74g6P2otkmPrGBO0K9Vus3RDBIorC
	/1vs4AlZKGwULvRR0+RL1CeZk/BAfzFQmf3Iqh4qsM8uP2DZSBLjWf+pHJSQ/t3FbczwTCF7VdT
	yx3S6SyMKwfhzY8ekgo8UP4FTmkqI0wn9VJYwSoOC7drmxjU+vVkoblqpPcqCJlc5+UbRSClkMo
	dZY1MHz1esvIwCIzlvgE0/AW9ERrqS/LkgqiRE4X7snLn9cQrcJKEGXMYilIIvF80GqUYLQz7Ig
	30hZ+Jsz9NWzOXJEPW96Foc1BnXVNDBwfa7CRR5Zq4Zowg3lbnETqmqfECQLnmzUV7Y3nSVsDOc
	+sLOShx4xpwXXtVxusgRJ80y/1YsAprzUdT/KWWJ6xK/YJRImptltogwvx8nU+0L4=
X-Received: by 2002:a05:6820:f00a:b0:69e:3c79:6e7c with SMTP id 006d021491bc7-6a39a6d68c1mr10017365eaf.46.1784042319220;
        Tue, 14 Jul 2026 08:18:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a37b58f98csm11352409eaf.13.2026.07.14.08.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 08:18:38 -0700 (PDT)
Message-ID: <234f8ff8-ae3a-4563-93cf-49989f29a642@baylibre.com>
Date: Tue, 14 Jul 2026 10:18:37 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] spi: add rx and tx lane mask to spi_transfer struct
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nuno.sa@analog.com, michael.hennerich@analog.com, broonie@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andy@kernel.org
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <a0b2db6f6e436dc0413e61335b2d1e2ec2f6f018.1783729282.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <a0b2db6f6e436dc0413e61335b2d1e2ec2f6f018.1783729282.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 12:56 AM, Jonathan Santos wrote:
> In SPI_MULTI_LANE_MODE_STRIPE mode, a transfer currently activates all
> available lanes, but some use cases require operating over a subset of
> lanes per transfer.
> 
> Enable dynamic lane selection for tx and rx by adding new fields to the
> spi_transfer struct. Controllers that support multi-lane selection must
> parse the transfer struct to update the rx and tx mask lane-wise.
> 
> Peripherals need to set values to the new fields only if multi_lane_mode
> is set to SPI_MULTI_LANE_MODE_STRIPE and they need to enable at least one
> lane, not necessary for enabling all lanes.

As I mentioned in my response to the cover letter, I would hope that we can
avoid adding this. The idea behind the mutli-lane support when I added it
was to have a higher-level API so that peripheral drivers don't have to
figure out which lanes to set when.

So if the alternate solution I proposed doesn't work, I would like to
know more about the specific use case before accepting this.

> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  include/linux/spi/spi.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index a9988db3fe2f..f4473d53b6b5 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -986,6 +986,12 @@ struct spi_res {
>   *      (SPI_NBITS_SINGLE) is used.
>   * @multi_lane_mode: How to serialize data on multiple lanes. One of the
>   *      SPI_MULTI_LANE_MODE_* values.
> + * @rx_lane_mask: Bitmask of lanes to use for receive in
> + *      SPI_MULTI_LANE_MODE_STRIPE mode. Each set bit enables the corresponding
> + *      lane. If 0 all available lanes are used.
> + * @tx_lane_mask: Bitmask of lanes to use for transmit in
> + *      SPI_MULTI_LANE_MODE_STRIPE mode. Each set bit enables the corresponding
> + *      lane. If 0 all available lanes are used.
>   * @len: size of rx and tx buffers (in bytes)
>   * @speed_hz: Select a speed other than the device default for this
>   *      transfer. If 0 the default (from @spi_device) is used.
> @@ -1131,6 +1137,8 @@ struct spi_transfer {
>  #define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
>  #define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
>  	unsigned	multi_lane_mode: 2;
> +	unsigned	rx_lane_mask: 8;
> +	unsigned	tx_lane_mask: 8;

Just make it u8 instead of using bitfield.

>  
>  	unsigned	timestamped:1;
>  	bool		dtr_mode;

