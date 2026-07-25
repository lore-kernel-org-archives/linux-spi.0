Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394EF33C195
	for <linux-spi@vger.kernel.org>; Sat, 25 Jul 2026 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785011904; cv=none; b=mD8DH5BgVyyAQvi8RIgvI3lhI6XeLewJLjTtUh9nzuZ8/C0hAR9mh/YTzu2msN+gX31ciD1d7lyzrJTIQOZFs1Wyayoq4VH5S02sC8TIYoimlJltObdSOY1BOny0FI2rsUhWNbe4GTD3MBtLNG/B36QCj78R7cbcWdpA/viOBdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785011904; c=relaxed/simple;
	bh=iONqM2Lq54NpnqmXjiLdtYtjE4xrJUW9mk+59xZC6g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNjwmk+eekw76XLdwoJXPthCnc0k66K0dJTSpd3D6SiwwRNamvViktLxWrORuzUoTo6LU2Ec24Q1Opal4flFHiuFL5J/lwjzdItaU12Q2QKVwtvynT/cYlWv+Yjv1lIfisXRgeJjI+0VHyBRYUu3TzYhRW1CnTX6DcXYIDrRsQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=T245BYQd; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="T245BYQd"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-451d8064238so919860fac.3
        for <linux-spi@vger.kernel.org>; Sat, 25 Jul 2026 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785011901; x=1785616701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6IaoMi6Hd0SLtKbgts/aDL0YFdHS36nKYEo+scTrYk4=;
        b=T245BYQdhzhB2xMb26XRlbPzRglEvd/9VdyuCGfwOmPkyWQLDuWDZDqTnktAKCpat2
         FNdo0Dr97uCS6ne4I4RAgFownIgs1cKLd95XgkEXt/rUEceVg6v31K8cqtD0JU2tH9VE
         9eN6Rj8LnYs7wjGjnTybcnc4JOBxyO69PxlFt4Skw+Ext1uwYmbFlOH4svgPVBB8Zqpw
         OlCI7bmiZOUpoeRlGSlHi1R3tzmEOgPMS28e9nHmpdlUpiwSw4eyRRmqa890DPnTS1Vb
         lSCdU7Vi0J+jBWK44dCvTVukx4+i20mKW7XcjppJi8VR8c4j/iouMPHxx2obpRgTY8ls
         3eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785011901; x=1785616701;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IaoMi6Hd0SLtKbgts/aDL0YFdHS36nKYEo+scTrYk4=;
        b=JTxJvkSidB2zLi3ZOjMxOJt06z7C4zoCJKU3SDZ/vJLrstxDGMRHyFQUJitcO4uykj
         lqyYDRuu9dOApqUZUUwj73UjV5Mf5vEvYynFcRgEO+YYLKNHrNVEPNWFCfKgCLowAmto
         A3NParLwSia7hgUhrEtxqOvp8CU4u/QpgQwFogtLzOEZO2l2lOhb7TbrL4+3cgmS7kqZ
         OSCHpoaEE1CHf6GVcsu8NzVviS+AZm7ZtknO24+yICKFFYpaF9HwPOw1to+TgX6jJ+Kw
         JZhWAt0kxSFATGnsJUKIlrQ3kiPV22N4tJwp6zc/4eCjZxbmmaLM2stvpzdTyiadCSka
         sGcQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNTYaspVFCcUl10i0oOuvM1QHkB6tR67qFUmMu8U1KYrnSYH0AX7lhPOIuCtYU5ATilfI4zl85x0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRdm87nOv7Zlg0UHIsMInKaT7y4JHHcMLg6Taj1ouG8hvBr/PZ
	+YJg85bQ8m6fm4uB4qG+SXKer6kYnPvkC4uyoP6IS9b9YY5tOzaGl7LY2jJCR2Mnd8A=
X-Gm-Gg: AR+sD13Luus0h3QgnOQ1Yo5ruNkMgH9aSjq4MGIxL7utomRqAiQraD3B+YenMe8rinF
	PEf/Vyi7WIOd8SvH3s3ufzZtQltlhcPu/xKV85Miu/ayPqh1Bv9DtUzsBv53kLysZTqIfH+s3mc
	BqwA8V/aAVZWpREDjNOU7rMcR0RDZoMKKf6AK5eXE3yi8tJpQ5bLiTCa4nZiFPLh+0O1Z3ZJ8re
	9vbeL49fw8ZUUXJyv2mUX1tJsen/PeAuW/AodiXr2K+uezBirxRJ4E87rbuyttofUQgD3YfBjLU
	64qsEtc/3i03+bCiFqQld1VEiCLZ/dkwyNrbjOFRuQeJTm7rVEPXbX+WhmgtcdkctPMe0jKnJKU
	Tvqe6rvDm1GxEHVmgmrrPNPRSawz/dWo1LKYs2oirESpcFFEHX46NwL2j6Pv0qdBpDrPXxqxXHU
	Ps3/3GRdy4NfaZifTvxcjCo3n+Yuxx2bgH2UNPdZmQu56sArUXX5st
X-Received: by 2002:a05:6870:3c07:b0:43b:6ad5:6ab8 with SMTP id 586e51a60fabf-457f26bb220mr3050354fac.20.1785011901114;
        Sat, 25 Jul 2026 13:38:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:677a:56dd:37eb:cf53? ([2600:8803:e7e4:500:677a:56dd:37eb:cf53])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45766f16dfcsm11225502fac.7.2026.07.25.13.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 13:38:19 -0700 (PDT)
Message-ID: <e39a9345-0302-425d-ac43-53a524f13394@baylibre.com>
Date: Sat, 25 Jul 2026 15:38:17 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] dt-bindings: iio: dac: Add AD5529R
To: Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org,
 Kent Gustavsson <nedo80@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-6-7781cd74ad75@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260722-ad5529r-driver-v7-6-7781cd74ad75@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/22/26 2:54 AM, Janani Sunil wrote:
> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> buffered voltage output digital-to-analog converter (DAC) with an
> integrated precision reference.
> 

...

> +  vdd-supply:

So vdd-io-supply to match the datasheet name?

> +    description: Digital power supply (1.08V to 1.98V)
> +
> +  avdd-supply:

And vdd-5v-supply? Datasheet doesn't mention any AVDD.

> +    description: Analog power supply (4.75V to 5.25V)
> +
> +  hvdd-supply:

There are 4 of these according to the datasheet. e.g. vdd-hd0-supply ...

> +    description:
> +      High voltage positive supply (7V to 45V). Supply voltage should be chosen
> +      based on configured output ranges (see datasheet Table 9).
> +
> +  hvss-supply:

Same here.

> +    description:
> +      High voltage negative supply (-22.5V to 0V). Required only when using
> +      bipolar output ranges (±5V, ±10V, ±15V, ±20V). Supply voltage should be
> +      chosen based on configured output ranges (see datasheet Table 9).
> +
> +  vref-supply:
> +    description:
> +      External voltage reference supply (4.056V to 4.136V, typically 4.096V).
> +      When specified, the device uses external reference mode and the VREF pin
> +      becomes an input. The device uses the internal 4.096V precision reference
> +      otherwise.
> +
