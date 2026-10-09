Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC214E535C
	for <linux-spi@vger.kernel.org>; Fri,  9 Oct 2026 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556117; cv=none; b=B6eftUtpjWbFG3bCsKOi+WWLsBKcSfEvS5Ry7SdN9GgKd+uxnc4lQCgE3ac8lVf/lkSenD0r8C40x6i3yAIFCvEMA4IgixwG2uwU/7skU5oAHWbf/NGMtEZQCjkExQoKVq6A+7R5Vp+whVWTKBh8YyJJw7pld7v2e1En7oKHCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556117; c=relaxed/simple;
	bh=tDcbReMlKW/aCLdUiODYX5ZlEgDafGJC8uBweSeMXLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxCEbKsxroZxg99/lAXgDZJVf+iwYvuU+tbHHI0Kx13KlmC7T9QkxlBIgMWvgXUozRU66k7RrBGChkDet+p7c3cRY5UTzkcI1UGX2Kbs+bEosFTU8hPAq2MO8TuN1+InJdRabOpaL1mzgPb2x2d2bwMv1EGLU8J9cX1EHB75dXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU7GTSP8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU7GTSP8"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48afbd2c386so3129612f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 09 Oct 2026 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791556114; x=1792160914; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J5qnGlwWK60nEqwsDNVA3SkC4N92/UygWdRusOcCHyQ=;
        b=JU7GTSP8xop3SqnyIFvKon6nTenhStCqzoyMXw2xiF6QRS0ZuSRz1UPkTXFAGWGWY8
         MTei0n/UkCHnfu3l92bwfHovO0n3dZBGhWavcM0CjXOzfTktKza6WEG7516OLJACyocS
         f91VExSEC3Y6ov/Xa50bPTJ0GHprXGi1e9y3IJJYpDVnnEUTc7lBz9gcR/kk/98frZuQ
         hZGo0YoLhRIp4IbFE3ymDjG32Z+Kd0wAJNsaVf+k+O4IVtrI0eMgW0lpa//BffvFi6gp
         EgxsIhj8zJfPOLrclaz7m+xjKlmAs9sQiaBnSWeu5+WoSzHyQ+66LMLEvWGtBGxnwNd3
         pDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556114; x=1792160914;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J5qnGlwWK60nEqwsDNVA3SkC4N92/UygWdRusOcCHyQ=;
        b=j5bBcJXLgA+qjoVNq2911FagvmGiPzW2g12EyErIInfU1Q64a0mvl6lN9HrtHa7WHo
         v02Ic1ic5yiMK0ddOs503nZHVhbXT4MVmsi4byeEJe3PdSJ84TxHiTrlJ16h0gQ40UYf
         hu8miuOCbWku3jcz7L+DmBttmwTARHc2rSDtdx9hrkZVMbpdglj3OVI87fuZwSmFssSd
         BCn5ernDvpA3syZRbCxaubVn2melnOCdIHAemRyEAXp/ReLTBwvQlXRkte2LixXVKDD9
         73JnDWGUgHvdSRSXc0alZyTyCYw0Tyjt6sJE7NNgxlmw+JKd68/vm5r7ndGwu/0lebX+
         hX4g==
X-Forwarded-Encrypted: i=1; AKwUvBz70hCtQIVR1+qAT1tpTD5pQkLx1M5Vw9rS08Xd5dattLeWIWsLEv3ChKZJtdHg7oe1s0GVKiyGnag=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6DuFbkiQAM2URQkwEE1XqDp7VTG3BD8GcIDRztO0PET4Dktuc
	B3xm81Cz/cSS3qSRYBNOHkDvFTOqteri90lsjpki/ivGh2jS1Delkgv0mJ+8/Cur
X-Gm-Gg: AYBFou1j4RT4B8XdewR2/4QALriHB1Cfxfn8bTt8EUA9ZHBM1+e+5njWhkA9pav86OK
	ilPJehKjQT4jNzrcG1nQkkH1YRwLqDSWG4RTMotTCmfDo4QMiP2gSvv8EpxQh6GNgHHCHlMcSDC
	E3AW+XdEgWXsH+k1rrSMIq5oB2/OozP6NhgvNkXgQUvlVO2YhxuPzpHZXorkI6WkWwkRiVPLIrZ
	zggBl16Z9X6svllDIu0m6Eqexx269Ns9SX9touohBBf94Q/6k7aBjfSJ9lW25D7+qTnSMGE/+Gu
	voFm6UjOS6LOX49/yK5dpYW+NDZAh66d1zCQFQKFCuYRZdINRpD4upMy87Tts18lvs9AlwwvawH
	wLQVvw07uIGgD2hx79ntunmwCe3FULzFNXEZvDldbZqSxczlYG7XDChmK3Y926Y6gAV79sZRYuw
	JNCGr2dCREnMqytp03kMYFWGV3xocqrTu4mQX+pgE5fINg7uDW3wL+YZl/MPAsfPcqdeWtUP+sI
	R2DJpyO94pG+haUnKF9R8EFcbLr77zxgZ/y
X-Received: by 2002:a05:6000:2303:b0:48b:58e:6cd9 with SMTP id ffacd0b85a97d-48dbacea01fmr4433922f8f.14.1791556113857;
        Fri, 09 Oct 2026 07:28:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dbae37509sm3456323f8f.7.2026.10.09.07.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:28:33 -0700 (PDT)
Date: Fri, 9 Oct 2026 15:28:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Aayush Kumar <code@aayushk.dev>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] spi: lm70llp: Use strscpy() instead of strcpy()
Message-ID: <20261009152832.4dd56def@pumpkin>
In-Reply-To: <20261009133609.579046-3-code@aayushk.dev>
References: <20261009133609.579046-1-code@aayushk.dev>
	<20261009133609.579046-3-code@aayushk.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Oct 2026 19:06:06 +0530
Aayush Kumar <code@aayushk.dev> wrote:

> Use a safer function strscpy() instead of strcpy() for copying to
> arrays. Only idiomatic code replacement, and no functional changes.
> 
> Signed-off-by: Aayush Kumar <code@aayushk.dev>
> ---
>  drivers/spi/spi-lm70llp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
> index e61e89b41..bd8028892 100644
> --- a/drivers/spi/spi-lm70llp.c
> +++ b/drivers/spi/spi-lm70llp.c
> @@ -252,7 +252,7 @@ static void spi_lm70llp_attach(struct parport *p)
>  	 * We are binding to the generic drivers/hwmon/lm70.c device
>  	 * driver.
>  	 */
> -	strcpy(pp->info.modalias, "lm70");
> +	strscpy(pp->info.modalias, "lm70", sizeof(pp->info.modalias));

Come on, if you are going to do that use the two argument form.
Or just don't bother at all.
Do the test compiles - if the literal string is too long you'll
get a compile error for strcpy(), but strscpy() truncates and returns
an error.
So strcpy() is arguably better.

David

>  	pp->info.max_speed_hz = 6 * 1000 * 1000;
>  	pp->info.chip_select = 0;
>  	pp->info.mode = SPI_3WIRE | SPI_MODE_0;

