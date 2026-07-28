Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AF3914E2
	for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257686; cv=none; b=DitGjpxqo+nkDzGbORFUIWWIzn5WreUZ/4bc689EpIfti73PBzW5nu26PR9GElwMfD7EyNtArsAD9HmCu4xEyTtPQO2zOCLvFxUhE8nzpzI7Bmk8TrtJP0HZhBsOmSgyTmdlVEXQR4tMs34Kk9dycikTdN3O4l7nhDcjTeg36kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257686; c=relaxed/simple;
	bh=jhSuL7gt9VIpF/6X00TJsqok9yskPwKTngvmyB336xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDiHywkwrUadakve98OG69Aj1Jff7/SQO55nb0Y3X3XVXlqLMiSQdbpxR0sYAlWmwRySbq4H6fcij+7OlRVbhvWx5UhgRA1Rhva41kXLRyqVwBPGsFttMa8YQtHDzrxrXqdXcW7JnDYOr8HLaNbTi/YUrvwiHm0gRzw3xg/3JSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9BEWwb9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9BEWwb9"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so99778f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 28 Jul 2026 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785257682; x=1785862482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lW1gGRbXyp32cWc8RnOmCHBS0mWa+Js0uD7RvlhagQk=;
        b=L9BEWwb9mNi3QHRZxtd7JNr4cvX7ydc+N+epqEtJSvddyzuWq8fcOlUSDFU7GeSXqP
         nPqFi8lDfrqWyOVnsG7M2cibJmeYqDpXfWW13ftLfEUmb+r/VKKf1WXwQrw6qg2SRBNo
         Zp34ZR5WXKIMESAoNhMw+f+jTJs39Pr6pT7WlcIrqiU/kAxJoIKp+B/lunlEYtnkbp8n
         qCVYQyTmNyNoo8MA6PG3wdt2UU+4lG0dd7GpAOaiA/83l9IKDSC7FJw53a8OLDpji2Ah
         WjAKZDeeDA88HpkLh5Pc+hMtnU4xAxOpUMBen0l9E0fHn4Yf4RIyWrylX0T230sMZYmi
         A34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785257682; x=1785862482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lW1gGRbXyp32cWc8RnOmCHBS0mWa+Js0uD7RvlhagQk=;
        b=lXfppMSfUq7ERM0V9s9kdxa6XQ5dq1cgkbVHVQqL/352PFuvM8tPTl18SkXNgGa+Ry
         h7OLuHgodkA/bYuTBAVpUXn/WIOOHFvOYpUhlxu/ZsZo45gmyGAHPQ1NydwhhnbvZzZO
         EBX3+Cps5UCSRuSh1e5QbuPIHfek+a5yz3dceXCThYNcSJhrVA61FHgUVDlGI4Dd/By3
         CNbweurirkX3ztrQhsawmjVNOW/2d1H1hsrZFhr0uw9Id4RpaTXLY3mv2tvJFGeaoWAM
         6vIky75bA8OpeOajgRiRqoOXv9qOMTNCs+H3XQrMMaL+0c4n5twVIio9gWCOZdwl0Dcn
         T4Xg==
X-Forwarded-Encrypted: i=1; AHgh+Ro044kaHSM8e+Sa2R0nUm2f3j3Q3BmYhMxypyw5sLQU0Ms540gwUslSn49U+VCnZgw9TOqe099NLnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIoz01zcIXMO7bH+9TrqOgg5wenFmdDEfYdi0J1ibSCg8xCap
	uzFZ7PoyZsUt6v5FgV/B2208xgwsk3M0tr++QSsfj/nIOCBai7DgIXdD
X-Gm-Gg: AR+sD137qBmVIzZNF9x7unnqNGj54gnSq7fPvo+MrDuVDrpTSJZXl2faqmgFj7tUeHj
	KUQLtCDifH1p8l6NslfszlEUVgZvVYojtIGmqsSlz6NwCVAT9mEJyRy32LH1KFtA9THJjXmZ5d1
	tdDjJzLe4vGMkSNRnzsJuRP8L1Hf3SeDXIzk916VmbJn65xE+aqgxWBeJ/P0k7+YIodEHEdAAsD
	ppQ85LXgTOrOffo9ypBpXjbri2d4winhTlWTVoX2AAV6XkZBn3gOrLgg+T06/pzW6CnyDV8riJH
	I4r2SHoApjQqqTjF87ZYm0bbmDt48/LBbAbwOWdEiL2BWvATsrwce4UxJQqVI4mNkSA2jgM2ThH
	CJb09Wy7C1In//3EfHX9MdpG1Fnk7ZvXdpsj6Uh7z6XE1r63nSgQRHEKb4MIDSYLQCaXBDQ==
X-Received: by 2002:a05:6000:471b:b0:47f:90a4:ff41 with SMTP id ffacd0b85a97d-47fb1ebbdf8mr3941679f8f.58.1785257682051;
        Tue, 28 Jul 2026 09:54:42 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3a88sm495883f8f.6.2026.07.28.09.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 09:54:41 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:55:50 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, 
	Marius Cristea <marius.cristea@microchip.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>, 
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <amjfAV5HvcIxOdv_@nsa>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>

On Wed, Jul 22, 2026 at 09:54:13AM +0200, Janani Sunil wrote:
> Some SPI devices support sharing a single chip select across multiple
> physical chips by encoding a device address in the SPI frame itself.
> Add the generic spi-device-addr property for describing these hardware
> addresses. The property is placed on the SPI peripheral node and may
> contain multiple addresses.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---

Acked-by: Nuno Sá <nuno.sa@analog.com>

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
> +
>    st,spi-midi-ns:
>      deprecated: true
>      description: |
> 
> -- 
> 2.43.0
> 
