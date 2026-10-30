Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333328;
	b=oGGGsYHq2VM80PoTvLC0YfSQFc66zzXoLlGlivM93AjnZN67231ks1sVTaElY8JHqeyc
	 EhVhPKuzsUGZgiMA32tEqU1UltcIQDFpRc9JwW1Dd2F4Q9z74xAUIcq56msmPNXbPIKQn
	 hdqr5VTq5B+8RihhYqxApYYsNLryrPdv2EDdyDnmDsL086TZduTw50mn9T89cBrf9V8w1
	 Rstx7CyWvka4FTNMu7XQEKBiNG4/IKeriC723ETQru56gdUdFyTYYfeVt3hm6dPbfntra
	 tCvU2RFEADUf7u3jGMk/R0XNxhE4Ry+DiNsk5McihEEHBSsCIOpBz++0UvztUn/oaCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2oyZPxVsUGR3lEqjPv6CqcgMqDvTEtbVpGv2X19Zzdk=;
	b=GYrok++o8Y1oOy+NBqnhTTjBcYOBMgYyKGoPsMB6Xz4lPs/4RVJXF4zX0M3uKJd0Sf3Z
	 p8UIVDzNRmk4bDZ3Ri/g9hSpLK8uDuiALkVP1xjFDlISVAReFWmCclyIDb68sEi9+uWpk
	 ey4Lt0dJuenIXz9E7F1neSPiBZlaS4rQmTuw1cElzThcIA4n+DdeEsDnpu5IEF7gMqiGF
	 WStUdtNVhr9YWvoslrO9pGWKgVHfftMo34XfgyWMHDM3oemrcWpP5dQjjMB5NU8Pm8ja/
	 6p4dgSaKcutywNh/coW7N0Z5EGUbFBnxzlmLcbv/FoxHr+/P5tPXNbdT5QH4hdIvVPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=guW+sKpx;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D640606A31A
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 04:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D640606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=guW+sKpx
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-35b2c599f43so721361eec.0
        for <linux-spi@vger.kernel.org>; Thu, 29 Oct 2026 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793333326; x=1793938126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2oyZPxVsUGR3lEqjPv6CqcgMqDvTEtbVpGv2X19Zzdk=;
        b=guW+sKpxxfru+jvDWjH7g+qClU0xEqlqQcz5Pf3hUGUYWFWaVdN2oIl46Robhpbyvk
         /xnqjDS8NMAmztXaC7ZgmOHSYfgsJY0iGP/KLp7bVEfqPOrT+sXL+aTzANB5jmgzLlm3
         VqHHDIMBiO3whPYPQFc1PI8Gw+l7cmFKFew23G6tgwi6UIgjrPI44CCZvN+SljLZsLcy
         RYGMxM61G1/CN6XNkehX8GzNpcJpaacyiFc74bUWlYmj1+Jv7Em/9b3Kvg5TSp7KLo3f
         A/DE4ft81r6pLaWULoiLhA6+Ig2TUsvA5T2q1YVhuNm+3gA2aBOZMM96ZjHlbo36HpqW
         D2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333326; x=1793938126;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2oyZPxVsUGR3lEqjPv6CqcgMqDvTEtbVpGv2X19Zzdk=;
        b=iDsS3mCOu19A9IE+8zWceIyVkoyCVX8GqC1DVELn8WUf4go9xk0sstXkoQ4GwBjMyW
         Mxq2KcKGUQcNj9BhPJFlgHaoK1z6+G1KuNiE1ALVo1T/JiE1MeVA+KedG41iLsk3Lyci
         24zx0BhnJ+q8+p3fDCwHlBJOOMNUe5wVEUYoFQmMvvMqVLBgWFMfQEvnHC15DyS3ykCg
         YnehaEMrAdYida8/UhvJvK8dTyZ6SMgW2vhttct0MZjolIChaYVDZETd2aOqj4gHCjN4
         OeaIs48p4fnsiXi+D4uT6nKwqZ11Hl87GpRr1x8Ojo5FKOS2jw3HqMnZYaSLDChXevIn
         8Umg==
X-Forwarded-Encrypted: i=1; AKwUvBzD6hKvZ+QBpjwHTdtK17w4m6Gm6GHaapwzy3byg45STUh/x2DmUq7Uz50WbbY1CjxWroKk0QZgzsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7UxMtuSVpj/I52J3t3ySkBF8weNhoHIbJ+2JswRJOLEdMAAqk
	ogSkmBAiPk0mNyC3U6wb1obZKKXRoYcsDJGXG8DKw3qiiSNmpCTo+Jhqs5AQhMPKqG0=
X-Gm-Gg: AYBFou21t88n99Ru/Ty0A+kQp3IOLVbagAotXFmGt90EmVRV2GGexEzFjBtiqxdAXpi
	GAhf4cFfsnaVAdRVsZ3FmnRmQX+xqYeYxu2hwlshJB1BFcadgtmD2bHDelsBCqqL15VH9wWYXM/
	2gcr8HktD2ZORsFSkHTwW0QvOBbxF43TWblBjLTYpqQH5mzF58lAZawa5XjzW3ck5yVQkEHFvIf
	cvLVtLR4dvvs/bJhSBMcR4T6fxg134fifJxsCJpf8DHNj0w2SuDeGIiyZc+Z505sbGm9zLM2lIO
	SoaMqAp7+Ik4ZwfArgDCATYdlAmu057L13mcIY2Q0KbBmNbxsIoPn4RCrxNbLGTDOgIzkWLDfoP
	IuhOBTUkgaK+/W+0V9pqfADASp26dr+OO2ilXFXgqFfrDTxNokLmg2Wlmsuq3vzkNicOz9NheJk
	INrnw+OpYvHIFdPBy8QzdoGoSvGQDHFaGEQQnJaR10T+X5DqagVjAnyV7h7ye0bFxbZgHEKAEz/
	QJSmjq2WnvsNuQ5u8I0+uYbNl9ihyoPEyiVLasPC6WrS5lapDPpmb2FNGBZvrkHfEBDArvfQKEV
	S4KpK8a2wMmuhZw7r9aW4tDxzuwBwulhzTYuYTQWdKXs6K50fh1p
X-Received: by 2002:a05:7300:a9f:b0:369:fb01:2eb7 with SMTP id 5a478bee46e88-36a4235f45emr1732875eec.13.1793333326139;
        Thu, 29 Oct 2026 21:08:46 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af91bsm3272988eec.8.2026.10.29.21.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:08:45 -0700 (PDT)
Date: Fri, 30 Oct 2026 09:38:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] Add devicetree bindings and maintainer for
 spi-virtio
Message-ID: <auQYSv2ad5WJSHdI@vireshk-B250M-D3H>
References: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it>

On 29-10-26, 17:27, Francesco Valla wrote:
> When a virtio transport exposes a non-discoverable bus, the devicetree
> can be used to declare its child devices (if any) and/or other
> properties. To allow for that, the virtio framework searches for a node
> with a suitable compatible in virtio_device_of_init() when registering
> a device [1]; such compatible takes the form "virtio,deviceXX", where
> XX is the hexadecimal representation of the virtio device ID as defined
> by the virtio specification.
> 
> This patchset thus does not introduce a new functionality, but allows
> proper validation of nodes tied to spi-virtio devices, aligning SPI to
> what is already being done for e.g. I2C and GPIO virtio devices.
> It was sent initially as part of a different patchset [2], but since it
> complements a functionality that is de-facto already there and is useful
> beyond that specific use case it was sent separately (also following the
> maintainer's feedback there to separate it from remoteproc-specific
> changes).
> 
> This was tested both with virtio-mmio using qemu-system-aarch64 and with
> remoteproc-virtio with a Zephyr backend (with relevant remoteproc-virtio
> parts still not upstreamed - see [2]).
> 
> On top of that, I added myself as maintainer for the spi-virtio driver,
> since the former maintainer's e-mail bounces back and its owner (Haixu
> Cui) did not update it after changing employment.
> 
> Thank you!
> 
> Regards,
> Francesco
> 
> [1] https://elixir.bootlin.com/linux/v7.2.8/source/drivers/virtio/virtio.c#L488
> [2] https://lore.kernel.org/linux-remoteproc/20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it/
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
> Changes in v3:
> - Add Francesco as Maintainer of the spi-virtio driver (instead of
>   Reviewer) as replacement for the former maintainer (Haixu Cui).
> - Link to v2: https://patch.msgid.link/20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
