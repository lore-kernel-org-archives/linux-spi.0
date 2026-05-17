Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD224679C
	for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779026579; cv=none; b=i8VUd3GVb8u2guiux4FrCSB5jXbmAjaqOX3e7EX5Qh9aTD40lVjvZUB2oe+9r4QHCQhqouFnu0rPBQLgLNunDHaE4yEkdBPTilzwtl+brcpttxt6efEiodGffD28kZxRQOyX1DzzmKfanGH5JxZXn2lsYcrW0VHeWvdfxqxSFcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779026579; c=relaxed/simple;
	bh=2pCY0J09HQ9uBG6i/BAZGnB6TjdVFPhIJQitD4n2KEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN9Zka1+7j7E8PlLoHUqoZG0nSpbSQ2fQo6TGjHlBuXptW4At3iL+9gWrB9QE6ke8RmbkfSRUKfbUkS9W788s2tZWJY3kqjjYmk1sC0xLwQpoAN3XqIAVGope2oDEg7urlcsA3BmNYwdlT9TSArmCHQl+Ht0eVUNIrjWAqLXFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mps9Ycfv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mps9Ycfv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48896199cbaso10596505e9.1
        for <linux-spi@vger.kernel.org>; Sun, 17 May 2026 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779026576; x=1779631376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN4QjvlFT+D4cTwF8kFo4fBZmofob/pqIt5bg0n6h/c=;
        b=Mps9YcfvOfSX/k4S6/qEdDZP2Gvlq5Si+JWkQFbz1v0viXs8EBf4IBNP8/3lgGzn5z
         7h07ndZLPvMvkexEw60xICYa3Yr/9zHinpoxCQb5lxA3QjYm52i0OINh+RCh5NN7szan
         YP6J+1eGAvnGlJ+6w79pr/Z+Ck1yj2I5YB44jmqvGQfyFyl9XrrZcV2sIt/TYdS5ffe9
         WLi6c74SIVEgJMDT4LhIdurlT9aTdllmQBqyAW6xpTwB4LYdMb7b/lxITjb8OJtBW04k
         QphMrvHxbOtn7FMbkxbyRXuN7/tgwDb/acxZTbrOz5Q/JQa3jCQ2OHcBqR9nRSx9vcrU
         JX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779026576; x=1779631376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YN4QjvlFT+D4cTwF8kFo4fBZmofob/pqIt5bg0n6h/c=;
        b=P+wry9LNVRPcXzBOUMdmg73wC+br/ecbHd304ufJfZ270QUVsQiINYSUfaigMn1AWk
         Vb3rdhs6NHtbFddCNfIR43B5oS9HsN68nHK3xB3LXTlvFzTQJiQhxPLLS4D+OZ9Y089d
         +NCv16+pUHY6rGX9JOMZssQB2Y0JnBahpd1z6v4+QdzNJDgtWsTinVVc+gxk9Br/whZz
         WyVCik7o7hqEn0m1oCR+qsoRCF8zUIyW0obo+tghjZCOE6gGN1+Tk55evVkHPj8BGS8Z
         F483ufWxqlgZTtYKdqZDz0I2Grdbf9WZB2YgnyENlRdRlTVph+IPahxYAaEdSrDDVnFy
         1ggQ==
X-Forwarded-Encrypted: i=1; AFNElJ+HK+G1hhEBn9gAYK2YJxqxX/Wdu03fFubN0FzXyf3n3fPzwHwbz6/8aX5D9EFidRxaibsfGI2FaFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQSSQUFzksmi4pKKYW94T8HQvZ/faXH/yYY4/DDd/OGWjvL0yN
	bMaCFJeLxIEahCn9Q/7XovqylJ7A/Tn8vJ/kbx0+GvNzsYd5HOLpuo0S
X-Gm-Gg: Acq92OFOydk+28/6M31aW2mbC+Px6729c3Uhm3gcN6RFp0MR1h22QHsAVM4xnk7O4Xr
	XTV6v58+PGhNCsW+R1T6HnqOH4Bh+UzaBXdEdGd9Y49gf3hJgbjwgCJXh5YY4YqaelE7cxRrgBj
	tqey25XPNScc2lRnkIsVIFPJVFi9xsQnXV2MMtSvFUOrNW43o7d1SQjhy3KJVzpj+UlvzcWqQp/
	7ZGAr6yR3ZTqezLjCF3XNfvGbOIWgs7Keyg9xwSaO4rP3HZ3Y4tzZbWbs7skTBp1ycb3yQBhmD9
	6D+VZok7t7AFBuF3LzJfS9vqCZtWP9xs5mBUGEent+QsdewuoLoWO3GocpOE8DwqX1C2angRISR
	G+aLR2XG9yyqyPTovxDgQUifXO5x/jkw/A0mxiYczC9gvxDXHepN8zJdEkpWKBBxvLurVh2TAU+
	Ew+Qcz4lSc8qj3soJGcie1cYjRULyDSOeC45MIRWIzNNWkUlHPs2YRIRNV/LXLUM89
X-Received: by 2002:a05:600c:a406:b0:48e:82cc:4d4c with SMTP id 5b1f17b1804b1-48fe6514939mr138761845e9.23.1779026575671;
        Sun, 17 May 2026 07:02:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm182556295e9.12.2026.05.17.07.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:02:55 -0700 (PDT)
Date: Sun, 17 May 2026 15:02:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Peter Collingbourne <peter@pcc.me.uk>
Cc: Mark Brown <broonie@kernel.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Christophe Kerello
 <christophe.kerello@foss.st.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: use udelay() for short polling delays
Message-ID: <20260517150253.031dec09@pumpkin>
In-Reply-To: <20260517062554.117448-1-peter@pcc.me.uk>
References: <20260517062554.117448-1-peter@pcc.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 23:25:54 -0700
Peter Collingbourne <peter@pcc.me.uk> wrote:

> A short polling delay, such as the delay of 5us
> (SPINAND_READ_POLL_DELAY_US) provided by the SPI NAND driver,
> can become a 1/HZ (order of ms) delay caused by the usleep_range()
> call in read_poll_timeout(), significantly reducing SPI NAND access
> performance. Fix it by implementing the polling delay with udelay()
> (via read_poll_timeout_atomic()) if it is short enough, matching how
> the initial delay is handled.
> 
> Fixes: c955a0cc8a28 ("spi: spi-mem: add automatic poll status functions")
> Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
> ---
>  drivers/spi/spi-mem.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index a09371a075d2..914e35e51cea 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -1005,10 +1005,19 @@ int spi_mem_poll_status(struct spi_mem *mem,
>  			usleep_range((initial_delay_us >> 2) + 1,
>  				     initial_delay_us);
>  
> -		ret = read_poll_timeout(spi_mem_read_status, read_status_ret,
> -					(read_status_ret || ((status) & mask) == match),
> -					polling_delay_us, timeout_ms * 1000, false, mem,
> -					op, &status);
> +		if (polling_delay_us < 10)
> +			ret = read_poll_timeout_atomic(
> +				spi_mem_read_status, read_status_ret,
> +				(read_status_ret || ((status)&mask) == match),
> +				polling_delay_us, timeout_ms * 1000, false, mem,
> +				op, &status);
> +		else
> +			ret = read_poll_timeout(
> +				spi_mem_read_status, read_status_ret,
> +				(read_status_ret || ((status)&mask) == match),
> +				polling_delay_us, timeout_ms * 1000, false, mem,
> +				op, &status);
> +

That looks rather sub-optional.
Even if the interval is short you want to drop to sleeps if the device isn't
responding.
(Or this code is used for erases and you are doing a full device erase.)

I doubt you want to spin for more than 1ms.

-David


>  		if (read_status_ret)
>  			return read_status_ret;
>  	}

