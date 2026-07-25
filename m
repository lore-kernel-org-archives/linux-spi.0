Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3572E22B5
	for <linux-spi@vger.kernel.org>; Sat, 25 Jul 2026 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785012908; cv=none; b=Zc2Bk3Y3vBHEzNummsI7Nfg/1AVaSh6MTjeTmXKUHhdK8j8MeUpRQnQwYkwAhpRKVqopfBjcfWWZLvmvU8/5Zlr71SZAczgNN4v02B57MuEJ3u/a0GrFKtPp06sYbSdWCpq4UBItWSN4xvI34Ou68P3x8fH+yRG/vmFDeEPH0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785012908; c=relaxed/simple;
	bh=Z/e68nc6QKQvwGRK8quiSuLi4r1Hwd7lrj1OFbny9/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtleQe5bjsrkLaw48N4KmWVpQdhc74o1X0c/HSS92naQLYnWnqPaLqz7RCUAPiqXcCw3WGRmFlDB1w5T07eHDHGOu99w+po4Fr32TYluUBgGMPvi+TSnkm2i5XEe7h1JIUPGSu8DcQ/qrCDJnrlYC0uNVMwHPPwKc9k0Du5C8/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UVmaj10c; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UVmaj10c"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4513435cdd2so620970fac.2
        for <linux-spi@vger.kernel.org>; Sat, 25 Jul 2026 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785012904; x=1785617704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YH9JqQUCimPMSpXV6NW6PpXAq5f8VZcE+lJasgXweSE=;
        b=UVmaj10cJnKoZsrxjsj1Io8LoRnQtj37Svr0g0AdVhrtuBYaMSvJwF5xRJKA42+ktk
         WW1cZLbAvj0LB3GJEJVRrSF7o7qyWx8lySxxEftEMxPx8vx7tvQIYL/3ads9fTLTjXQs
         rts/936KCVDvEoNC20z93NbcQQsF0syAxowAr8/2cFxJSiqGJnzowwCyP6S1AGe3HR+c
         B+y7NwyNuwjbzncal+NLWsgXC3gPzETsQ0Yy+iRATSajo6sY4E78hDGq1R0VyLCbE7it
         Ad1lBnbHAE/fGm98BwNniFlK+/NaHUskHb6C6IXgIOf1LOtkwgE7Se92Xv4QMMQo6cdJ
         0zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785012904; x=1785617704;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YH9JqQUCimPMSpXV6NW6PpXAq5f8VZcE+lJasgXweSE=;
        b=FdtNbPAeHslG1b5yL7/ecriwMOOubTWuG2JiGvlQ225rReWvWba3bd7jOVZrxFItXb
         F2pWx0HyiKZ9YvDiAzVS5lJpQY3+JBjn4S8x18taPIbs6VohDK9X/qbjjW+8YxOIrSFc
         fLJysrBybU+9X3nZLKSXM4PuL3QNViiF7MmGa/DEOonDC0+2ZlDvLXG6NoGVjn2sqqYE
         gaPysKWY+3xWaU4559JJuxUbj3KaFyPvKfgeqnBHaIIYjiRKc39iNIW4v9d80Srm8Ut0
         d1VR6ljI7O0Dmp8EzBvgqHEQOKElO1FQsXAaxlUls9t2+KuxOI2j4gLnCBr37hXgPioF
         qX9g==
X-Forwarded-Encrypted: i=1; AHgh+Rqpql5FQdHQ6axUcTS38NhCbG7lvblG7gfE0gTD6yFRhN0TgiGtpqEPy/YsovPGvLUz+AaSeSb5vOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75j5vnZdgNrpoYEjwH+1flONPyP3IkXYKWZYYG8wHq90qG3ts
	L6OWeotYpZR+TYmgZCtIpyX8OlThvs4KjagT1Q5n/yTT0UOiNI1CHet3NRkqjk1wb68=
X-Gm-Gg: AR+sD12SWSxagOJ5qFjR3l6EmysTSC3WnT2nZ+TuG5ZV4D+um2KWEUvvWhOPhUwW0Uw
	AKgGv6182au41Wg/MfyAyQ4TeoPlp+Xra0HVV8/gTHzf1/lvgw4CRSjMqd3cwDLP1ztG3oqkkwn
	VbUNHKQjxhRDX2CrMnUT6iaZvHw3qK9H//tsd5z2UuXE0znz+/RN7ne1X7JGAwkbHSMPdbUha4u
	oldeKb3NSy/5F2Q1NnrW9edjoh8Gh2Dx5rTk0cb0LTeAfFi2GSRLiUk9DfP7+9Zkne0EOrWXmwu
	gjizTFet+r/+t04ZAwVXLXubaZwz5gMElXwxsVjClUeMXqdSweaZXfuNSlRxDJAvtDNizJyHOHS
	bXqUhmFTBOQ63DH1hjs8GWR7oFgiN8dHFXkmNclF7N1Cul5HoEs9D4slWLQlpPfCcks4bF9+QsS
	vKa7xBKZowbgRRKYOmkKUrYzSYNvwq71FyVMotxI/UsTbc7iV1Ziy+
X-Received: by 2002:a05:6808:c413:b0:4a3:fb6c:9adf with SMTP id 5614622812f47-4ab69fdc1c0mr3905211b6e.12.1785012904631;
        Sat, 25 Jul 2026 13:55:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:677a:56dd:37eb:cf53? ([2600:8803:e7e4:500:677a:56dd:37eb:cf53])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab46f5927bsm5144829b6e.9.2026.07.25.13.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 13:55:03 -0700 (PDT)
Message-ID: <e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
Date: Sat, 25 Jul 2026 15:55:01 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
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
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 2:54 AM, Janani Sunil wrote:
> Some SPI devices support sharing a single chip select across multiple
> physical chips by encoding a device address in the SPI frame itself.
> Add the generic spi-device-addr property for describing these hardware
> addresses. The property is placed on the SPI peripheral node and may
> contain multiple addresses.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 880a9f624566..b59d047cf117 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -142,6 +142,13 @@ properties:
>      minItems: 2
>      maxItems: 4
>  
> +  spi-device-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Device addresses used when multiple peripherals share a single chip
> +      select. The array allows one logical peripheral to comprise multiple
> +      physical devices, with one address per device.

"per physical device" for clarity.

> +
>    st,spi-midi-ns:
>      deprecated: true
>      description: |
> 

If there is nothing useful the SPI core code can do with this information,
I'm not entirely convinced that this needs to be a common property.

And this only allows for one logical device. If we wanted to treat each
address as a logical device (all with same CS), we would need #address-cells = <2>;
instead where the DT "address" is two values, the CS and the device address.

This isn't a nak or request for change - just putting my thoughts out there
to make sure we considered it thoroughly.


