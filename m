Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A42F8E94
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785722778; cv=none; b=asiuTiIi034dPteF+WgP6o0LN68dsY6rsywt6D7O/qPGBogLkFnZBre+Y8HeJ8HFFM4FMikDP+aHcinXXpkxoqRErrk+9LESyGjbzcov/eDd8TVPimirkz4X5L+BoLBl5RXEG5Kj2A6SHojQ1HhHSR91wzfTDKiaVcaslrRv4Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785722778; c=relaxed/simple;
	bh=8Yv3hh31LT/ea1kydVeshMQp3oy3EXGN203QyIn9mjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AldzU899DEz5dFtJiXz0Pq0dAuvlWLWO9hcirRDJHz5oEKh0KmwsAvC9khLsKJ6YAKpMrWpbPpzMg8toyYzDuwjLNZnKox7WwAHdrqooyK93z2N11wE466O3ZIAfZr0SCRudXSIiyO42e/2XRURsBJp6LR7wotlReLvVy6P4O4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyXck0ss; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyXck0ss"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2786309a91.2
        for <linux-spi@vger.kernel.org>; Sun, 02 Aug 2026 19:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785722776; x=1786327576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zBpvBewXJUAUQskEE9gVJKiIy2xHWWYPydLmxFZvPhA=;
        b=NyXck0ssIL66oPpr9E8Rlx3eXsxC9fmA2ucAeYuiWdIabOAyLeDIeuzJaZCSrNvTnP
         LMniQfCype3d8sy009P8Zibi7wOkyT2rh8GwDVeGzGAoELjOMV//7rsu3KnDNAMHXoRO
         Ffzk1+cFVSflgElDkMva3gpbI42fxgKOm175kZ/UritzlAHYSVqX8x17O4JSp+2nqCoL
         ci3xBOfeBZZP0h3CQ2NKVMRAbG1+FUO+HfiXITsYoL6mSYBSUQ721PvYt1JSU5vokHiS
         vCRK0RNKSUCeA4O2k9TRqbmvG1G/zi4AEx4UrxZ8sdUDwhSjjauTDzx1RjVtQ13OvLRT
         H+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785722776; x=1786327576;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBpvBewXJUAUQskEE9gVJKiIy2xHWWYPydLmxFZvPhA=;
        b=KyFx8nNBNdTvppAa/AzsFUHy6oWMNaW75ACM30aVkgfqm/ZKFOqCzMnIUi11s7c235
         NUUnNmOxDcaZVio3LpyK4LydSC8IlFPhmS8qQdNWU1Q8Ke9QNyMeBzPkKblYMA7pFNGb
         AhIsK3DfhK4AcVRnhVLxQmbM4WInt4uzCHde3fZYBWKMlTc4HKdvg7Lm6XkW4JfFmZmf
         pwyJT5JHXttsZ90UTFyLR1dyN78nw0z9KY9QsYM7DWfqDYiJ3xX4TInQgSEMmeTzDO41
         sImYrU08PSTdtDMFfhwZlvt+8X8dS7TX394Amgu4NgrPhXop89+us4Fmtip3EiejzdMl
         NxvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6+vPhQcRxmSK1ukAnqqp7ktESEl8kA7V3Rbd07H15p92g8P5SP0uI1YseQ30cWKgT+pWqIrQTSNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7A+KyD9Y8I1smasuSn24IC6zkRUYv1myPUDq//6QaxBKNtjDm
	6zNlpqiG4hD9E/3SPDIEAUfv/IpQNQLbmdRbppwP07YVEdBQPM1jZKSd
X-Gm-Gg: AR+sD10Dg5cyPRpnWTG5yRlPiXDaFBedf59fX/o8i/ikAu4kxoEqFU/p1KUEzZXh7Tv
	WyoqIack4NiM5uAxISo3f1hlnEqmUrCm3AqHPHGkQ01kKoPLwyBTJUw2WRIBQ/jCWs3SG2ZbSLJ
	9yhsP2xnNkqkRTSWkcpBkJI9yY1iu6cUQobA/9Wn8VQgNnvv5gPQZp3C2K4xo/oV1pC9YrjP9ri
	RkWiEfF1bc7Vb8cJB3xPqfwRRf+ONXj5E9vr6ySeLQ7Y2f2BWljYdWqZyywKKd/rgnwTId+8XFV
	Hs58gTN/zU49Akunyz0nUSvA+hwEyKGwtpUjGgp2zwX8fzS5I8rtzTOYsvHzmdpW2FtbDh8uiHQ
	LI98JHKMa+BVGwI0ly60QZIN3+brClYgMBKPVFYw9V8l8SIfu95Gd1ILep79NZ172Va+gw7Rw/+
	p1K1HUoQVuv6aeMS904bWOvzxT6B1HzDczR2Pw4TZwsKW1TizUCy64zwUUSvofPQCV9prm+cn44
	wXF554da020CHc6MqOR+9M69BkX9wXu0id+f4dM
X-Received: by 2002:a17:90a:c104:b0:38f:c8f6:4ab4 with SMTP id 98e67ed59e1d1-38fc8f64da1mr3417332a91.41.1785722776096;
        Sun, 02 Aug 2026 19:06:16 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2e0f409sm3199716a91.4.2026.08.02.19.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 19:06:15 -0700 (PDT)
Message-ID: <222f1bd8-e680-4a45-a7b3-d6e8b653c2a8@gmail.com>
Date: Mon, 3 Aug 2026 10:06:12 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton
 MA35D1 QSPI
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cwweng@nuvoton.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260731023818.1626075-1-cwweng.linux@gmail.com>
 <20260731023818.1626075-2-cwweng.linux@gmail.com>
 <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <5769eae0-1b40-419f-8311-0d919bf619fa@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Mark Brown 於 2026/8/1 上午 04:28 寫道:
> On Fri, Jul 31, 2026 at 10:38:17AM +0800, Chi-Wen Weng wrote:
>> From: Chi-Wen Weng <cwweng@nuvoton.com>
>>
>> Add a devicetree binding for the Quad SPI controller found in
>> Nuvoton MA35D1 SoCs.
> This leaves the generic binding's support for GPIO chip selects enabled
> but the driver doesn't set use_gpio_descriptors so they don't actually
> work.  Either the binding or the driver needs an update.  Otherwise
> things seem mostly OK so I'll apply, please send an incremental patch
> for this.

Hi Mark,

Thanks for pointing this out and for applying the series.

The current driver only supports the controller's native chip selects, 
so I will send an incremental binding patch to disallow the cs-gpios 
property.

Best regards,
Chi-Wen

