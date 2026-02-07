Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A382EAD10
	for <linux-spi@vger.kernel.org>; Sat,  7 Feb 2026 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770487779; cv=none; b=uWPPi2C/JTMy21W+nHdln3zNTruc+FS4InwGbyaPBrO1+w5tk/9zCsamLMy7zPqc6tSXRer0Rnf92lI2zONel7KkMdQBxuB3fdoqBjMxLK3tCddjSUSTCstHT8fj7KL0wpZx8YowwPb6gyRLAZiNW2xdic2pp/Dn/q4ZoQd3uQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770487779; c=relaxed/simple;
	bh=Z1RlCkvjAKV6GMKhbwoWjgZvhZGNQ0TOlPqMxvRH9eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NxjnGiGVo+TZNZUnz1u/9w3055IPnRibGoRzDsWn+hdyojSCvKWW6M2I1ieyqubZf4trD31stvicUZnejHXEJtqwr6Wex3bmPMZ1KTNsoxeBVOMzR8hqW6Tgk1bn8IN0Xnt6Gxjkpesk2UwgPdjjAXlzv67JEOkbBOpRAIid9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YasdDXT+; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YasdDXT+"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4094b31a037so1902723fac.1
        for <linux-spi@vger.kernel.org>; Sat, 07 Feb 2026 10:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770487778; x=1771092578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=doeEscZbmqUzRLkmGbD2wulpXvhEwLpY3gZ7s/QLWDw=;
        b=YasdDXT+PSQGxVL4yqiV6baqDWcuTn+aeYlC+08D6q3bByU6qswlUJW1KJvBtFfb8G
         ddtfvmCXJoFMI8tHG61s7X+7EFfJD0mgiXEPxghWHI5g42E2/crplxnXzmXurq/drRAA
         zek9l3gXbx1r0F8SPaEbUxDTGs/75oBfhJgLq8degjPmTGBWglKMfvPvQ9ZHA2UQsavj
         yk9Hhw8lwi4K31syJ7STbd1o57+POIfmgrJfgYaSywTWdi4UVmeg7jgR+e1Oi/JkrSa0
         /CikZAy0wJzfW6f/2MZ8A6EZvnzrahxEvfj/7YHUIHbATVWzqD0oBLLLwAkUnaUNF4Pb
         WM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770487778; x=1771092578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doeEscZbmqUzRLkmGbD2wulpXvhEwLpY3gZ7s/QLWDw=;
        b=d4kX9xs/d/mq2h8o108qD8cf5UF3I3NnmCZu3RNzDBHte0LWQteWql3GRpgvstK6cp
         BzSejo+x1c3ck7JBg848x/b7MxzQEKmirxEihSI15cCzx6N0ym4/b2QQczG+56QMZJQv
         pNkXjXxoDxgNwhyNnTlfMS1FxFdaVic8kP2TF28HfvffBOds09viy93HcEspUvFyyOwK
         9XvOqk67ngaaKUk66UAWIYRFRheNw5Q3oqTixE3IA+PSAvlymmVFpcRgOp5QuIxB4gTk
         KHEHTLG77lcDJYHRAkBXXk0wLliJPJqoeX3/aTB0mTrIrPOqmurZpyfwTYBEeG+T++nE
         aX0g==
X-Forwarded-Encrypted: i=1; AJvYcCVkWvxbWuh8iLmuO38o2bKGCRaM7+2hf6p+GT9NbFxVT7mF0vy5FfU0Mfna83sAPHs6vH13yoFLbBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+P7BYEFT4EaMF8S9liHQZCw4xJZoI/gd2/dhXDsH9rqdbob/
	Xjf9jNShECo+MH516jQFb9NSup4gvRzDNnrLP8azCuTaQk8CLEzF3TEDR1PjGKNMfrg=
X-Gm-Gg: AZuq6aJvCBX7zWF6faZrInaNdNxAlyasw2jNf7/gPbVx/wGGhpiCrGQRFZk9HU+WDBP
	0pkwq4iSx4HmfWwjHvw+/A9STjZoVSM4gpHS7axBZ+oc5fCNBBiM6cqL8XONtp1lkvVR7bYra22
	pYp2sQrQJareZaug+T1Zd4bW0JPMPWCAZ5N7Kzxwkk4VA2p63ZtAugOGf5mgWbCcABz8xLLxokj
	t1GgSgvElreFmIhJf/ObVXKUKSVXfWWEIkGE0Y0qEBt+Sa9XtnziHJS9q794FF2oL3YzuZUfNcG
	JmBCFP20GAijFrRA85R5HRPt26axpTLI+Y5I/3r32wS6HuykGDm1QzYYtBvOZDqTR/ENBT6k3Pf
	QE10BPz8TKdZlXrbx4LUs42SwqqVTXR5Rp5l61NEC5n6kPPbMrb0jp11hjUJXcMzaasCR3gLaHl
	2G7iXojMGu2kpH4pmT3/q/rtgGJ8eEPzQWUq3xPao4UR21W71XnSUxab09KV6dwURSanlT
X-Received: by 2002:a05:6870:799a:b0:3ec:321c:b2ac with SMTP id 586e51a60fabf-40a9777b8c4mr3621662fac.37.1770487778043;
        Sat, 07 Feb 2026 10:09:38 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:74a6:843b:f33:21ae? ([2600:8803:e7e4:500:74a6:843b:f33:21ae])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a99787738sm4509503fac.15.2026.02.07.10.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 10:09:36 -0800 (PST)
Message-ID: <8fbfcf7c-4acd-4a7f-a5a5-34baad84e1b2@baylibre.com>
Date: Sat, 7 Feb 2026 12:09:34 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] spi: allow ancillary devices to share parent's
 chip selects
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
 <bcb1eb34fc5e86fd5dbb4472ad1d3ea3cf3e9779.1770393792.git.antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <bcb1eb34fc5e86fd5dbb4472ad1d3ea3cf3e9779.1770393792.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/26 10:07 AM, Antoniu Miclaus wrote:
> When registering an ancillary SPI device, the current code flags a chip
> select conflict with the parent device. This happens because the
> ancillary device intentionally uses one of the parent's chip selects,
> but __spi_add_device() checks against all existing devices including
> the parent.
> 
> Allow this by passing the parent device pointer to __spi_add_device()
> and skipping the conflict check when the existing device is the parent.
> 

...

>  static int spi_dev_check(struct device *dev, void *data)
>  {
>  	struct spi_device *spi = to_spi_device(dev);
> -	struct spi_device *new_spi = data;
> +	struct spi_dev_check_info *info = data;
> +	struct spi_device *new_spi = info->new_spi;
>  	int status, idx;
>  
> +	/*
> +	 * When registering an ancillary device, skip checking against the
> +	 * parent device since the ancillary is intentionally using one of
> +	 * the parent's chip selects.
> +	 */
> +	if (info->parent && spi == info->parent)

spi should never be NULL (or we would get a segfault later), so
if `(spi == info->parent)` should be enough.

> +		return 0;
> +
Reviewed-by: David Lechner <dlechner@baylibre.com>

