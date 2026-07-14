Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81D8371860
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025003; cv=none; b=UUrBMb1S+IbyYadOQ02I4lRAA/EGg/tyLcJmAp/39o7tNTOGhGDtlf9BmZs43nxpUBtKPkE3BqDuUvaRKRiUS12v6OiVx3VJmToAkXm6F9WiTSTmKGpiRW0rlrqmrlbU+D9M8TBDZCQ4tMK6o7oouW5wIo/+V3xSeXagxrw3t/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025003; c=relaxed/simple;
	bh=7s7em8ctE2eEo/xyB8hEzAWjpCU/jNadqkf3Pyv3QcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k633MVJPAtp1o5gY9mZ6Tdzlneeb7T0P0JUu5fp2zLw/2PiFLzOgKteNjTZhMesotkRuQ3l6VFvLBJaItc1xR0BpSkmnYeS8Xzz2McI7aNcYDu4A2d59oRAP+unycZK18RYAMwdMNOWsR+XkHvOW6TkD5/PX4cyh+77sno3YZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC92EG3D; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC92EG3D"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6986578d8c0so6257313a12.1
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 03:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784025000; x=1784629800; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S8+c+uoDNGvXVswS15mWHZ2LQeEbNMEMn8kOB2p3/3g=;
        b=DC92EG3D9V3RxPSnSzK+n7cj47U3vAdctXGRfbExK82LhQP/EmONFYPCZyfHBb++Vu
         hnDGMVCnPPH/20UM7T9ASO+tQ1ho0UIlI58T4+aYfYiy27uBxv/ooeYK4cYbZUyE1icj
         Ivz5aQNBIGUhdy8oiURkfUIlk0KHP4tyN44YDNIEjUgo6WcQ0bU9THqBG+OZdHffsJ1d
         AIsK7fKNEe8jnS0avB73/DjxrIHYLweUPwm3sWP2nX0RsZkumHek+JqDJFZ6jnFBtkE2
         GQi1hEzVICzjwBpKPw41fw8LhPYPZJzepu972v/jCIMHJ5WKxOmmdfc5Ncf5043YTlTP
         wl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784025000; x=1784629800;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S8+c+uoDNGvXVswS15mWHZ2LQeEbNMEMn8kOB2p3/3g=;
        b=Kar4EUaW8HHCvs9Env5JehFz9IkIyX9/8HI/nSYyJQfXhE9EDAYV2Vstf4lKYMvhcX
         mpsfxqWcqySvZVduI/dUERCtS0oVQxOytZ6wESsAbQb8TACfayL/h2N94MWRW8MoKO8M
         I85FFX9SlkpZ4jwysN6/9Me1WAwYS3KlLXS5r/S+wBJVVnVTVvvQCGqtPTEDmrILnion
         YWWg1HKDkDPedJM3UniFi8ZjR98hjq0IF6xZnjyYclFGxxuXX6QubW9S3qyzfAOYzFI9
         UiZWovZhOBRkYU2Iiw9ARO68sCZy6RBhfaTfdJzsw9NuDvh5cGBtngKiJnsSva2J3x2s
         CB3g==
X-Gm-Message-State: AOJu0YyPOBc5SnhtppYexvt1y5pqsv7ycw0MZIfPAXOKfZHTHAO2HYZD
	VstxH5+087k7/NnYJrAOiU46zBCIToLHlRi6cXAv6u3yTZk1MTA9SZZE
X-Gm-Gg: AfdE7clCAbdiofXkCxQ1ecI+HvxxddyqGC0A+0uFEQIWfbibFZmieDUaWhznmLpFU3+
	QY5JZTUDIEH89LY+lZnvnpkPqLeQRlyx+4V6xAHrpUGFmPN6Qh2ff82kidwDBVZ1ElFGdNfvft8
	OZzbYPEuiYTrEzFq7L2xhhDxZ8yk9aa9euKRvCJhsNOGBMn4FTN8H2p8GmHC7gzAW/I0tPNqF4L
	KZHAW5WsuYFfuoFg+5S1ueDpCD16msv8uywcnW+ykNuw+aTpoxZKVRadAEO7tjL6voKSqj85Y4/
	602O0AR+9ZyF5ubNI1g6dVnOISOTZOWvHeJ9HwiWN1qIC3ynKV4SuMWKxyIwBCJ9BN8STU6ykOy
	RjcJ8xBLy4uF4H2XXPPA9IDCzNRV1acfepJlwKpode+URw0BvdAEZQJgbGOdUcOR2P9xEiFI1xK
	Ra4oXkdWhy2KfSheh1rvPThHEk8g4YvTT5GHA0+g==
X-Received: by 2002:a17:906:4791:b0:c16:71:d9ce with SMTP id a640c23a62f3a-c1667996520mr85627866b.8.1784024999591;
        Tue, 14 Jul 2026 03:29:59 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c166301d883sm99454766b.49.2026.07.14.03.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:29:59 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:29:56 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, michael.hennerich@analog.com, 
	broonie@kernel.org, jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, 
	andy@kernel.org
Subject: Re: [PATCH 0/6] spi: add multi-CS and per-transfer lane mask support
Message-ID: <eplbtsrc2rojtpuxdtcy7vp63fhzl4ckb5cobs45y6fmcjy3wj@g3ccws2qeg2d>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1783729282.git.Jonathan.Santos@analog.com>

On Tue, Jul 14, 2026 at 02:55:31AM -0300, Jonathan Santos wrote:
> This series introduces two SPI subsystem features: per-transfer chipselect
> masks and multi-CS device support. Together they address the multi-device
> setup described in [1] and the limitation noted in [2], where no SPI
> controller completely handles logical chip selects beyond the first one.
> 
> The first part of the set addresses multi-CS support. Some SPI controllers
> can assert multiple chip selects simultaneously, but the existing code
> hardcoded CS index 0 in both spi_set_cs() and of_spi_parse_dt(),
> preventing this from working.
> 
> The second part addresses dynamic lane selection for STRIPE mode. In
> SPI_MULTI_LANE_MODE_STRIPE, all available lanes are currently always
> active. Some peripherals need to select a different subset of rx/tx lanes
> per transfer. New fields are added to the spi_transfer struct to allow
> drivers to specify which lanes to use for each transfer. The documentation
> is also updated to describe this new behavior.
> 
> [1]: https://lore.kernel.org/linux-iio/af0EGv172ZMl%2F6N5@JSANTO12-L01.ad.analog.com/T/#t
> [2]: https://lore.kernel.org/all/20250915183725.219473-1-jonas.gorski@gmail.com/
> 
> Jonathan Santos (6):
>   spi: support simultaneous assertion of multiple CS
>   spi: add per-transfer CS mask
>   spi: spi-engine-ex: Add support for multi-CS devices
>   spi: Documentation: multiple-data-lanes: describe rx and tx lane mask
>   spi: add rx and tx lane mask to spi_transfer struct
>   spi: axi-spi-engine: add support for dynamic multi-lane selection

It would be nice to include an actual user for this in the series.

- Nuno Sá

> 
>  Documentation/spi/multiple-data-lanes.rst |  30 ++++++
>  drivers/spi/spi-axi-spi-engine.c          | 106 +++++++++++++++++-----
>  drivers/spi/spi.c                         |  97 +++++++++++++++++---
>  include/linux/spi/spi.h                   |  12 +++
>  4 files changed, 206 insertions(+), 39 deletions(-)
> 
> 
> base-commit: 093239070573637ad2b4cb56abc9c4c7ee109294
> -- 
> 2.34.1
> 
