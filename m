Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D9C43D4E8
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020366; cv=none; b=V0tsgo3QJpK7KI+Epx4E9ULIzfNLmZh+guTmw/vVByzcvHS7QNi5o1+WcJ9xz2tcY+qzWYaBFCnNb7q3fs7J7usaWWSe1qkDn6BtP1kq94HcxPIGh5eyQHpWgoIzQ8fPd+S6qHlB8Rf/ntbRlBNUQQh8xTXi73lGGmD2l7nNTRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020366; c=relaxed/simple;
	bh=bzQ3bt1+tMt+z0mnkBv/uMNxV8ScVXXG2PPF74S6Xpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI9q+sxYLC1roH99xJMAGVWANV40FzEcbRq/oOdzJ0nz7kGD2XWi8v0lBfyM6yNNHMGydq3VwmewbiAiN0B/YWS1Kro+DZFfGIgI89Ki6NoyJ53Tqu/AJRq5lC3eozCRK892JAkhLLIlF6IVBkUAzkRMNDhjVfOzejUebVLU19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=soQiGCVW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soQiGCVW"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-697564cb69eso1541980a12.0
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784020363; x=1784625163; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e7U8hvO6jtQnng/+zyopDoytWG/iMcimedShP5n5z5A=;
        b=soQiGCVWvDpTO+4PM5iTNRLAxRUFjXNjPF9W+fNRfsdKLCyRIYhijVgUpMjN6CFCjQ
         FpPBmKSsBmgx1QNBmvLSf2Wpso6PlS03FYXzAK6wR8zKWviC2e5m9O8CYuhdNd+fCvRh
         BaYpbgwvBQXxHup3phvENRWwAs+Q8F+9h5vzAayJknPIOl0Xw9+ueYa1WwvIfOcSz2zZ
         U76Vo2JeCKJ3A+OsJCU3Z/PCt7ofHxMz8QjABol4hhMs+kpfgutLRTCbcr1UcT1uYuOt
         GbVlRolMwBAZeOxaz2Hg3SI+OpwByBY4FpMqABxtyCiwGsDPPTbWVLYNg66RqMjKhgFn
         Xi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784020363; x=1784625163;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e7U8hvO6jtQnng/+zyopDoytWG/iMcimedShP5n5z5A=;
        b=Zg2hNss+hQovCSK1mmOMhOIU98/R9wXOp66AF89/2TcJP9OTmYDYR5jnNdCFbIhzFv
         Hcued+m/w55A6xCHn189mzagTFlM2WmiW6wvNimqXPswiUX7CCMMmQ6DckEWira2zODC
         QBrYD6RQ+i3SXTzwkK5TPSIlNRIYPu8mVMPDiCElyw/Y7UywDzjw+3P/6R314grIB04c
         CGSFXpVmg+gN0IcCA60LMbiY+vJDemEG6MbMR4uOT8/aaSLD6L+VIdV/qZV/c1Am31Ew
         BS8uwbVY8edZVkDcQJRKe/6Ep0dLk618UonVr9LmNQMFYKJsWjNFt1EToBkG0xThqRgm
         FsZw==
X-Gm-Message-State: AOJu0Yx/6CdPT48NDxE6grjBWykMESF13UD4LOFD3Mq2mVewONgplGhn
	+vPafx8d0ptxffWyj/8mypUtl3Qt3DbKK55Zo8aU1KevtPyEsVveSP4Q
X-Gm-Gg: AfdE7cneP8jEu3Men1N1P2DICVGgM7kr3ZeEvw3sxtc0mSEIYKsXy2pjf65ZrcFmaLM
	jm6ZcXCiFHaED8wTqKXvAK7/v0cKI1Q6ZBq0HSFaHXYOxA579VBocj4cyKHPN0/k9OvQ/g3IItw
	capMgNnjbo9j10+lTx9K06hGTgecaSs+keWUqXFM+O0/1L3rlNEUjAskuj1WZtn6hf1sLZRbRnT
	lodmw6s9j/bqjgGD/SoFOyKDIabIT4lAyhVE6K9SQe3KSsVf5HADUnUQSJ6c8RvBnVT3K+pg0T9
	/1SEcFJD4G4bkkPzwZzkUP3hj2GGlJtYau2ct3au8EM707Bkw9ynZUqwEikUlWuijNkNqTwJyHS
	4LRIpvzHam0M+68wV8vU5tvvZjj0vim7CGKAznlUtrAtSgHpsPfWLRKsNKvuCVyAXE1FG+jT8Km
	TjvP2e3jFmb9z6qcYLpIEuCkz9K2Uw8+GnK1g5Jw==
X-Received: by 2002:a05:6402:5c9:b0:698:3e99:8146 with SMTP id 4fb4d7f45d1cf-69c5f248199mr5057779a12.40.1784020362454;
        Tue, 14 Jul 2026 02:12:42 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2922f91sm1079685a12.18.2026.07.14.02.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:12:42 -0700 (PDT)
Date: Tue, 14 Jul 2026 11:12:39 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, michael.hennerich@analog.com, 
	broonie@kernel.org, jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, 
	andy@kernel.org
Subject: Re: [PATCH 2/6] spi: add per-transfer CS mask
Message-ID: <gn7ainj5ds64t2khwgtfas72qmfim5ss5revtw3svio4jip6fw@aw5hx2qsjedx>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <3b38df61feee9a0c7e08bd03e624be12b5812cda.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b38df61feee9a0c7e08bd03e624be12b5812cda.1783729282.git.Jonathan.Santos@analog.com>

On Tue, Jul 14, 2026 at 02:56:02AM -0300, Jonathan Santos wrote:
> Multi-CS devices assert all their chip selects simultaneously by default
> via cs_index_mask. Some use cases require selecting a subset of those CS
> lines per transfer (e.g. routing data to one of several subdevices sharing
> the bus).
> 
> Add a cs_select_mask field to spi_transfer. When the mask is set and the
> controller has SPI_CONTROLLER_MULTI_CS, spi_set_cs() builds a temporary
> spi_device whose chip_select[] and cs_gpiod[] arrays contain only the lines
> indicated by the mask, then delegates to the renamed _spi_set_cs().
> When cs_select_mask is 0 or the controller does not support multi-CS,
> the device default (cs_index_mask) is used unchanged.
> 
> Update spi_transfer_one_message() to pass the relevant spi_transfer to
> every spi_set_cs() call so CS transitions between transfers with
> different masks are handled correctly.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  drivers/spi/spi.c       | 88 +++++++++++++++++++++++++++++++++++------
>  include/linux/spi/spi.h |  4 ++
>  2 files changed, 81 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 55fb96fea243..6d644adf8445 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1071,7 +1071,7 @@ static void spi_toggle_csgpiod(struct spi_device *spi, u8 idx, bool enable, bool
>  		spi_delay_exec(&spi->cs_inactive, NULL);
>  }
>  
> -static void spi_set_cs(struct spi_device *spi, bool enable, bool force)

Might be missing something but spi_set_cs() in the current code does:

spi_get_chipselect(spi, 0);

And I'm not really seeing nothing in the patch handling it. Is that not
an issue?

> +static void _spi_set_cs(struct spi_device *spi, bool enable, bool force)
>  {
>  	bool activate = enable;
>  	u8 idx;
> @@ -1129,6 +1129,61 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>  	}
>  }
>  
> +static void spi_set_cs(struct spi_device *spi,
> +		       struct spi_transfer *xfer,
> +		       bool enable, bool force)
> +{
> +	struct spi_controller *ctlr = spi->controller;
> +	struct spi_device temp_spi;

Not sure what to feel about the above temp_spi dance. Can't we just pass a cs_mask
into _spi_set_cs() and change the code accordingly? And for the default
case we would just pass spi->cs_index_mask.

- Nuno Sá

