Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA154086A
	for <linux-spi@vger.kernel.org>; Sat,  7 Feb 2026 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770489000; cv=none; b=MiUgwZjEtGUMmkcJysmCVviibhRv+pHuNp+A7B0gdN12cwvi1IeSeAiqUkFyBfe75YUdy4CE4g51T/W268/euuPKkDOxg15YXWAAaazjTLP0VzN3qiWIn0sPRZrRYh1kaGAN2gR8ZACYvfcXGKkKlHIPHtljYZlyVcRs1RdJFS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770489000; c=relaxed/simple;
	bh=uh7byIWYb33iGmTL/H3fo9DQqCmVUzHqkr5paC+gcr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OXTPo+diu12pj1YEWsWldQY+GGh+idged2JF+2RWh6lp6Uzsn49Rwu174h2SAK3V1Xj0vPoVVznISN+oEvNhYX8DEChvOx+cpuenWbZ1ifEZQbBwSdlop04La3A9aSxuB4IYGLn4+p4TuuKUYX6T3+9fdLDVxDdqckIB3lItnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RXzyOrB+; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RXzyOrB+"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-66a12c77a2cso1791545eaf.3
        for <linux-spi@vger.kernel.org>; Sat, 07 Feb 2026 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770488999; x=1771093799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFRUlZH5q2I0e9gz1CToCErzc9pGDkWhvEbaw5FlmCA=;
        b=RXzyOrB+DfCYb3LafFNRQ6J/lrqylxFnBqrBGQ6+InPuJX9rHTn1Eh9QVaJgar3aDM
         BFE9QosNICEkLAf+mMWKonVYI4BfVdSiWNYXQmEEjUQi79pMJtg1PGKgD4Cn0x+3uZgB
         BXQXmD5Va3sxIegpeFp912Hi8JHzU+tAJxonWDpCs/WmATfSVZAEct1YcDbDoH9akJ37
         gY77G5cPIkxnW5clpHLK0WG+RgwQmRLoHOBOrUSPlg/zodk93UzWR+SCLmLctVWjXcOB
         VIRj/53o+wjI5FNykjxmG5PkhHHlb9fmikvRKar3JTMFsfybV9Kbtufu+G0bqxPYZd8V
         zM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770488999; x=1771093799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFRUlZH5q2I0e9gz1CToCErzc9pGDkWhvEbaw5FlmCA=;
        b=DeCGkhGh4Ut2Xj8ONcM5jShoEZia8eE/v6I/ZJ2+Iv2/gx97TOLWgWPgVrltBvHR5h
         tkbvFDTYx8pios5PNDEeBZ/Zxnjc0TKB12r0xvhHsrPsVzdKGLtRxrgzGw19Jmz82pYW
         jxQLCqA4Mpcm/Y3YfWOPaAT+DMMCZrvRwuvIs3x18ZxYjH8ZVDALt2rm9WpCi1SHEfyW
         8ZErnEhVBtKe+SQilXadRTaIw6Y37iwA+uex2XdWynGzGaNO1FJgJpBk861395vNzrd+
         EaGr3yP0wtnqy7r6oc2H24ZwNazbUQsV2a0gj2GurDJ447s+rJZQaZHu8Zk4O6+hvmbJ
         6aiA==
X-Forwarded-Encrypted: i=1; AJvYcCVoS38OCR+caILldfkI8QhgeLEkn0yuhmpqV1j+26ircRj2AYNiupP4+/HrMfW0H2c1GUZSDFnYMlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0aPv0LOcntM980H+bbdA4MDIoIZWjOrP+hOejOaVmWGw5dFq
	ggA0M77M6mKnUbwEkd2bv3GR5Dy8jvmYlVXAlPcvcUre7YOBfZCsFkTNeAGzBWfWoW0=
X-Gm-Gg: AZuq6aJIuxpYc3H76xVnDjsZaRAPB1BEvb4PYZf9TwbDuJjIpoa8A66v+S8VQgKq5k+
	EZD0embxCtONae0fd/2pvrB5aqXPDhgL8khgGbqebfMf13kGXVEeFgtgDYBqgyRT7pLmZp5BqhJ
	vzGtXuacwqZxV78vk3Fw8GKJIFqTjN9ZXH2G7J/V31WDSaiXzwwKrnJ35RClzSl2eg6UPPm9A63
	kXPwDnL0ZzLasF/0XPKOGvGm85H4icSahPGK5qvIwE+d7mIaAJcTTvqUuolzqhFi+9CJ+jkjHds
	Kf9S3teiUqbXuOVhGOWUaIAin28EQ6ZIR/1N7e11iYfWq1aCIShYMFf0/iiikgljWovwtEDJZPV
	+LXe4ur8mTLMY9V7tOpTLp7AkPt396voC/ZpAf2wYol80q70Bv4XOCpVbbG5Bf19k5QuSzYW039
	0XlfpoysDlJH47MjeTIwJfKVTXuaxw3JLh7k9um5aZFRDaRj+wmz/VEbPBcA==
X-Received: by 2002:a05:6820:1808:b0:662:fa52:9302 with SMTP id 006d021491bc7-66d0a093d47mr2896617eaf.23.1770488998988;
        Sat, 07 Feb 2026 10:29:58 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:74a6:843b:f33:21ae? ([2600:8803:e7e4:500:74a6:843b:f33:21ae])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66fdf303607sm122595eaf.14.2026.02.07.10.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 10:29:58 -0800 (PST)
Message-ID: <fbddf502-c6e3-4bf9-aaff-baee2aa83ef4@baylibre.com>
Date: Sat, 7 Feb 2026 12:29:57 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Mark Brown
 <broonie@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
 <8685e3e53667e82c7cdfd66ee6fb1ec3d3c009cd.1770393792.git.antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <8685e3e53667e82c7cdfd66ee6fb1ec3d3c009cd.1770393792.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/26 10:07 AM, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.
> 
Reviewed-by: David Lechner <dlechner@baylibre.com>

