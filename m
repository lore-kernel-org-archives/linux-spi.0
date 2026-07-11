Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3073F2D29CF
	for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783806919; cv=none; b=Ne1PCtkDjQNJZe8pHCyq6v9qdKuq+9VgKLpOVYnO9IVRAqDpTdKB1+ADVJ/7Gl3spdU0Ycd6SREQWGj3l/pF1u8KyUjKanpfatJRAB/ApAcD350ngjk/uY+AFBWvj/Lph4S+aXBQxTue1fo2qF406qVtx6OZqAjYSyCPxNPcCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783806919; c=relaxed/simple;
	bh=+g/zQMRr25BR6fKjHXZoDZ0Xm5YR7ayk9SrrK7joU9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaHdYw/8DfW5/lWR2G9lUg2VjUrnYvLsICd3jtcKFc3GY8ZtWoMEsjy+PtlYu701sK491WdKhUjdCBaPV5lis7GEVHvb0gxTeQoNWPobWdfVE5bEpGu0o7L9jCXSnCQmzVonUnVitPw7756kW3zspuvgp34yri/jccYMX4FtWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEhPteiL; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEhPteiL"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381b831d535so2472892a91.0
        for <linux-spi@vger.kernel.org>; Sat, 11 Jul 2026 14:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783806917; x=1784411717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8FLFQgdcqhO0RIIwKxkkuCrdHtU1MdsA2yWXjq6XIr8=;
        b=nEhPteiLMBfXyrY1gyPWawvaA4bFkYKDj2gVvJl1xE5oif40oGc71MPzcGjpeRhoXN
         +D+xBsOtGgt+B3jIWiY4vzUdPZ2oJEJCUX1KV/815B2VG+guVKsKdQpyi9B+oUQQDD1m
         7UiEtmOYAVV6QOMNzembBs26CTYJ5zJ0CVw3QmJPMnLtYmaMgVy7GwEWBzpPKGz+fqeN
         t5GPTZusvM7qtyfwICHiVkRNa4UysdhQD3fc1OaTx3jU91lRY3JEIBdq2X/TE58ee/YC
         dsP2uklaonChIKEGc8CXrjC6j1ZwwAJLkcJ3/PvzvhjoP+i8645rF/lT9rveU0jN2vU6
         +QOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783806917; x=1784411717;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8FLFQgdcqhO0RIIwKxkkuCrdHtU1MdsA2yWXjq6XIr8=;
        b=juU8cxYQdNozIgJ40FenLr97dCgwGhLBoqKFAzj+OU8dAGG8ShcywWmcPmAnNKYITc
         bUSnC7KWSavCzpvpURSW0zyc9RhWP38OBBGxQxkTUTlMCU7mdhdWuuoJaALWbAiCfzME
         utJvNKRCWns4OnsktQBiFb0Esv0QNnkmrJyfC0+byzUidfh/h8dLzgZILVNDqeO2JzkX
         2LQ0Atcs3oU4zxMybijqviHuSzNL9DuZG/xlmGoH+qZ5SDmLgGxumFOSpiuv86AxVqog
         DQvmmOZl01BDpdofacIkQdGWpOTKnnvhgjPTOE29zpRrY4pLa2huHTv4QG6cQ7Pzi94r
         bVNA==
X-Forwarded-Encrypted: i=1; AHgh+RpQ+U+tkwBryMUrcyrENfptYXOox76D9I6rjZnWKTgmgTbDzmxC2r5vvrKb9/PjO+nWyuygH5VKtZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybReCBr6u7BgMzKPx0sOeEdpd+iTGluUf0vSn/sRViSe/znk+B
	D/WDIKzezkTqpMaGEzV6FzBzxBDtaJ6SeLFrO1NHp1JNEUtuElLocCiv0yTUDA==
X-Gm-Gg: AfdE7clrwIBOZnDsuD1tkOb2MQ5aI/OGjQGk0WCZvw2+S2vh2vICaYGvj+7MVXQGAUJ
	/kbVWe1mf6vnBJTGDooRqNMFvtoWLVUyafAPIAN8/ansf4xuveFHv1hI+2HY9GkwKgBkn9kq8vs
	BAyQqOBKCBRVgMqY5BX//mEUKHEpCOMFqkU+MIvInUqsc+nkHuVNQTZkirwzYapgdQDnBtoH72l
	+ZpStRBQW4+i7Ln75mEAwXp5TJ13QdS1Hw7nUCx+CJZEdX22GAE/ujDhqKml7PFljJS08Fc3y3m
	78Q2jetDu/v1QvcunsBrro5LkYpayOqOu+lz+TsKRAyj7XZKAEAvvfU8ZWDxi40bJvO5H4aat/F
	2P7WETq0+jkhbDRhnMHO47UyR5B/K+cWtEGiA4bCfpDPpHFG5zovCngIqim0n5P1hlAHQ5kVa98
	ySGilpfpM5CWAeQ4CrJqH8cQx/no7mlYnBZoIaIBNWgUvPVikuV9TWVBCWPa7rGZlSSdW0G0vKd
	Q==
X-Received: by 2002:a17:90b:540d:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38dc7752969mr3988834a91.30.1783806917501;
        Sat, 11 Jul 2026 14:55:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm35851752eec.24.2026.07.11.14.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 14:55:16 -0700 (PDT)
Date: Sat, 11 Jul 2026 14:55:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Shih-Yuan Lee <fourdollars@debian.org>, 
	Ronald =?utf-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>
Cc: Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] Input: applespi - cancel pending work on driver
 remove
Message-ID: <alK4jVB5dTp1nvuG@google.com>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711131140.18777-1-fourdollars@debian.org>
 <20260711131140.18777-2-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711131140.18777-2-fourdollars@debian.org>

Hi Shih-Yuan,

On Sat, Jul 11, 2026 at 09:11:38PM +0800, Shih-Yuan Lee wrote:
> During driver removal in applespi_remove(), the managed private data
> structure is freed by devres. However, the driver does not cancel the
> asynchronous work applespi->work, which registers the touchpad input
> device.
> 
> This creates a use-after-free (UAF) vulnerability if a pending or
> running worker thread attempts to access the private data after the
> remove function returns.
> 
> Fix this by explicitly calling cancel_work_sync(&applespi->work) in
> applespi_remove() before cleanups.
> 
> Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
> ---
>  drivers/input/keyboard/applespi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index b5ff71cd5a70..3bdb9e7cfb8b 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -1822,6 +1822,8 @@ static void applespi_remove(struct spi_device *spi)
>  
>  	applespi_drain_reads(applespi);
>  
> +	cancel_work_sync(&applespi->work);
> +
>  	debugfs_remove_recursive(applespi->debugfs_root);
>  }

For this, and the next one, the issue is that the touchpad discovery is
asynchronous. I wonder if making touchpad detection synchronous and
making the entire driver as PROBE_PREFER_ASYNCHRONOUS would not make it
simpler and more robust.

It looks like Ronald tried to do that in [1] but unfortunately it was
dropped on the floor (my fault :( ). Maybe you can try it out and
freshen it?

Thanks.

-- 
Dmitry

[1] https://lore.kernel.org/all/20190721070523.24695-1-ronald@innovation.ch/
