Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607DC44A711
	for <linux-spi@vger.kernel.org>; Wed,  6 May 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070572; cv=none; b=h6rTOqnsW38vYFlyS5TVEhCXG3qYSQP6BIT6venDuqtEIVKuDZ9DuR1mDwaoyrqlvvoL1UXespaKk5uYudO7HAuz92qh9uCN2NcbUeGhr8ZLpMKQbQB+Dn1GFn71yOKyAhf2wk8yfrB/tKqan0QGMFXdekbOujJd+4olyMp1pM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070572; c=relaxed/simple;
	bh=XOZ7v8ltQwZiMyzo5VWS6ZSorJyR6knJEj/bH49Z3ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q/72MPTvmaAnqLkGxbT6lCtVNWn474Drgg/oCror/uvTIZAQXSvSlht4OBGSeI+ddUzfe+GovZjBQ3fzzf9971pzvFOpqNljlG5lqUS2EGT/JI14kNBi+y7liIUG/v7ahgBw40BszVCosEtMTpjKiQufKBTJolIHtXX6Qi/PlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KeENEyvB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeENEyvB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d102471a4so31216055e9.2
        for <linux-spi@vger.kernel.org>; Wed, 06 May 2026 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778070569; x=1778675369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MErtgJ01ux0KftOTULYSL/LrPrLq4iBEMS2wRNoZ6W4=;
        b=KeENEyvBAZnq0XJGFgdQeQn++VcX90Y5oU3H5htUHqXMXRrycmjMZRKpVKSSLUukGr
         toSPjBKpVDOVhkraEUNb8//7l40kEgKpC8rZ9CIY+lDN2mTtMQSWpppmgny/fkDq5Y/V
         3pBpVqKTSvxepQShZO3JA44Ft9SN+ABZpCQqxbh5ibnR8Cf5KbBXap+di50kY5/yY/yI
         dJUm2vZMSOI1X7T7Ih2t+j5UlA2fzQFPg5EzE8SRIh9jKE38J4k+cg2H4z9dcQmBE77z
         QGQhoNh1fPi5XUD6t/NYzFClys2TMAOgaHXBkV/R0NuePExm13r0UvSjG1j1y3B7qsUO
         s8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778070569; x=1778675369;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MErtgJ01ux0KftOTULYSL/LrPrLq4iBEMS2wRNoZ6W4=;
        b=nlQ6BVYAs9wZAv3/C20cm2SZd1jwOvcrz0e2sd9fXbD5d/LKuHjoWYj9kfW5xp50XY
         GZhO1743T+H0WGdaCUvEbWo6z9CXQSTg+NNPXjYq70tLU7eE3R5uNs7ju63wPXR7uPje
         FU7km9RHyPTzErCec5ObcLPErcUKVSRoX746+IJzgdN+sn/9GNiDW2DhB3Ym9eiJO9gA
         8io9UluAv7WQ1rK1qX+KeK0WwKDbwEpbuz2EzmNFv/c5DGbpaKc3vwVO5DTLrrLxWtcG
         OliBJhQBj5fP+MXahEh18vot6Odt/rmvalmchlfLSSXKO01r2i1vTZpcRsjmD2AQjOs2
         MtVA==
X-Forwarded-Encrypted: i=1; AFNElJ9JBfktYE0fZI0IfxS+x2gjAwjLxEutMUGxLX7EAmFxsZsAnaCqc/x2gl28QD6wMK/JSKgOFgH6hDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwChb4EUPnEU3ciCtuepeY/A797JA7OX9lIF5JNOngNQmNzOxS
	8X6e+s2DL7R7lg9D+Q1kQmq3RIh4zJElQNf5ah0WjaeynPobcQ+BEpEwpjcO89yjqOo=
X-Gm-Gg: AeBDiev2pqEOq2fq5cWtmxdovdrzFv68J6hqgtWreZ55hAQXZMAAyjq3twSN5MbmHIV
	aoeLGvUAM+NK9BWfdw0U4B8Qv2km9dvHfbENJjEqfOy/wUOBWuNey3guHaROnhVuSiZ+a7c/xs0
	w5/o2Va8Ax5/Syz4EbEJQ9UaGym1BTc+htD/WLZtKY4cZOgfcjs7f/QQj3Q9CaxBR7LTcsjLfsQ
	ehSSTj+Ho4pPls4ambW1m6I6M1vs+bjTPvkHbnJXoatBNIayGPVmtO9c+rfHMavJdUUVcXrPuqZ
	L5NXcBe1TpXWGBIQ1Uck/oP5K2tEVd4eQT+2CWQj4up+WGiDyLkiuRk6+13adAqNb1GstnzCVnM
	PDt7pgKaQLJUaYcnOELQoVT0AsJm0QaeqrR5rP3Hc0qZ2R9ltPNQMgLhDV8iZcr738HhyijionI
	YwUbPkwPKRzTotfAVR8hTyvwvPXa+GcnqbFPtfD4+paPhOXZFXhx9VgA==
X-Received: by 2002:a05:600c:c096:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48e51f444ffmr39137505e9.21.1778070568779;
        Wed, 06 May 2026 05:29:28 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f249bbsm10865842f8f.36.2026.05.06.05.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 05:29:28 -0700 (PDT)
Message-ID: <d5e1e929-e24c-4876-8590-030db9e95b52@linaro.org>
Date: Wed, 6 May 2026 15:29:26 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: s3c64xx: fix all kernel-doc warnings
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Andi Shyti <andi.shyti@kernel.org>, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Juan Yescas <jyescas@google.com>, Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
References: <20260416224056.985233-1-rdunlap@infradead.org>
 <06406c7b-c141-4997-9921-9358cdea7641@linaro.org>
Content-Language: en-US
In-Reply-To: <06406c7b-c141-4997-9921-9358cdea7641@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/26 3:28 PM, Tudor Ambarus wrote:
> Hi!
> 
> You missed adding the SPI maintainer. +Mark.
> 
> Also, there's another kdoc warning in that file. Do you care to fix it?
> 
> scripts/kernel-doc -none include/linux/platform_data/spi-s3c64xx.h
> Warning: include/linux/platform_data/spi-s3c64xx.h:40 struct member 'polling' not described in 's3c64xx_spi_info'
> Warning: include/linux/platform_data/spi-s3c64xx.h:51 expecting prototype for s3c64xx_spi_set_platdata(). Prototype was for s3c64xx_spi0_set_platdata() instead


Ah, I misread, both are fixed.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
