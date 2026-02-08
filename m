Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9133D33B6E8
	for <linux-spi@vger.kernel.org>; Sun,  8 Feb 2026 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770542717; cv=none; b=Emw46EoZBQDJYtaqj7VzLfOXRiX3O9dloqUIME2sJVCcL+q7FIbaiCjNKlT87wnq4HCXBTUvZ5EByMEyW29z4lmwNZL3NUqpGYIxhfp9Qhut9PeBuH4gLPZrFtkNs8aaP/Whi0sPRB50bv80lViJ6zW2usA3glBaz8PW3g18bAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770542717; c=relaxed/simple;
	bh=XeoEd6PTxccp07L+s3/OmGwhyoss8PjEBCE16OPFOMc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hLdQyG6RMaS3bXQdgggEoOSsRCeAU/h1YQFPSidc5OXZ51pU2uY4GfipsH+S5xgb3NpUqUntUTKWbw/DGI6acOy8GJR4J7WqxOoMtHv8CUMsUQBzA1a3VDrTrWv8jhWxgjE50M0YbgTd0VQzrPjmQgwf4pmwwDGzYdIDEzNekLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMNekdAp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMNekdAp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4362197d174so2019880f8f.3
        for <linux-spi@vger.kernel.org>; Sun, 08 Feb 2026 01:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770542716; x=1771147516; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k1pQBX12h0BSUE4QM+2bV+LNA/Oczy6ilqlLzeMHL8=;
        b=cMNekdApxL5+9gNfKqPjqTBHnozGiCTZKYbRQd4ZT8V766z6mqNdOtIN5zaAMM3+zY
         Ccfuz1Uxqi9+bTejQpBxdJFnwFNtl8e+9DfeSubnxiDq6WSGMqEm747p1/Cr2kzLnRkA
         Llb/635HmYVBJB4MfFizIPiS+ANEUgQoIiHmV9WDRvmG7Kjx49gMJ9g1SMilEx7YQYXH
         HYsOnwLfXk8z1mW/XCYLViruoVu1qlIWAhCVUWC88btngDCzwx4seWUCSOB2jG2cMqWJ
         0gP8vmZovNjVzoBxGG9xkZVvYyERVYQIrOHXXq2bBiEuzaidmn43w9n82CyGys1J8Qbj
         f68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770542716; x=1771147516;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3k1pQBX12h0BSUE4QM+2bV+LNA/Oczy6ilqlLzeMHL8=;
        b=TNp+GgsUiS6VUxBI+dg5aagNe/gB/BWO9a2aVqrKzHMPFMnl0j2jYtaqoL0ZqIqqTg
         NfD5OSVhCml0TBaiYc97vQYjGfwA5Q/88IY8aPUGfpKrDHN/YICfMKG7AtiMpX+FGEZ8
         xjeF4fOajFM3Ivf1Us6HgcmvJ6y0+sHBVWAPuCyrIwaY1OZTV5xVimXzKbLtkKOpJIxb
         83W6AvHbNYDy+HKa8r9JzWNfCABqRNKZ6tmsKku5qIuOgMktTeP7LL9TvB7Fa349t8rH
         zsbAD3/IntJGpHqXr04T6b4nifOoRaLHFfmRqQQXN0jm1HReP/QTMOtDRFvMCZVxfGm6
         GjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaX5HJCTIbqTjxYQlwC/ZGXRjznyKQRavlw+0R8PtK9XFEBVqYwOLrlmxRnqS76SiJpqc6T+fhh1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4G7WFJ6SUM50I28wQJGdOwaMjkyeRtQIXngJpSn4OE7jz47h
	0eQZXUYdNzNbyI2/aPpO09hERtRwg9gDFuWMfHsQ/KB3dP+cKC83f4JX
X-Gm-Gg: AZuq6aK2RYHx8+Qop0YnVYn87TWwzRoq5P/I9/EVkJrNANEH6CoJFg43LAdPgY+oMOq
	8Wsu/228qCO8KHInn60KXYOkIW69tmGlQediQ354hb4M4vetWT3sEoWQFte8+y4Ze2GaAU1FyNo
	xMAefOHs1pqbd/f2Zn+WvjE44Zua15ygASK9cIwwCrq1OUWGkaWZJ3O6ky24QeI530zW/ngXkrZ
	gUl2+nBuuUZ4Qt3XqkLqbK0nKLQg0wa6B9O5Wlw9nYUTd9gkKtJFhfA4mLdMT3gr89c+xp6muSa
	3BCuZQQYw7PaQ4ucm1ILKl2iCMqDGSQh+lDQ/Vn+VKS2I33eUHfG1Wy1H4Ymw9IJ54dPYgdQo0G
	egLLppt6701rB00BPqJ2Tub14ZjHSm8UyZv5WQaYhYn2eXDkcp8EPk9cdpCW/vUI2gmb3RaCki/
	mrVf6ekqxlX7HNBNv2oeSa1Dg+p/kcqSQanrZN0ci8D0JoKw8ffaRmkXjYksQ=
X-Received: by 2002:a5d:5f82:0:b0:435:94dc:8c78 with SMTP id ffacd0b85a97d-43629378331mr12835803f8f.40.1770542715900;
        Sun, 08 Feb 2026 01:25:15 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd211sm19565112f8f.13.2026.02.08.01.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 01:25:15 -0800 (PST)
Message-ID: <95ba8b40af82959dac08d3576579eb1451f28364.camel@gmail.com>
Subject: Re: [PATCH v2 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Mark
 Brown	 <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Date: Sun, 08 Feb 2026 09:26:19 +0000
In-Reply-To: <8685e3e53667e82c7cdfd66ee6fb1ec3d3c009cd.1770393792.git.antoniu.miclaus@analog.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	 <8685e3e53667e82c7cdfd66ee6fb1ec3d3c009cd.1770393792.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-06 at 18:07 +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
>=20
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

...

>=20
> -	ret =3D devm_iio_backend_enable(dev, st->back);
> +	/*
> +	 * Request buffer from the first backend only. For multi-channel
> +	 * devices (e.g., AD4880), all backends share a single IIO buffer
> +	 * as data from all ADC channels is interleaved into one stream.
> +	 */
> +	ret =3D devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);
> =C2=A0	if (ret)
> =C2=A0		return ret;

Ahh that's a pitty. When I read the cover, I thought we would finally have =
a multi
buffer user so we could fix some issues with it :)

- Nuno S=C3=A1

