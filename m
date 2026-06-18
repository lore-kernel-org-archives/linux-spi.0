Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666713AF67C
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771477; cv=none; b=E8YMmchkv+up0UQ5KuGmLD7XN3UnU2yiBPocrMYNdaVdoK6pFFfWuNzTl9YAnqG0IAmi15ixcKJpyFHpKa/663qK+s7v53hVXSitpkvOjyvSr2S9X80Sm8y6vyT51AEIhq+cA7Kc19AMs0unetsLQe5SEeLDBDQ7+bGowbb2+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771477; c=relaxed/simple;
	bh=BkJEkp9s/SL76jUUgDOhTi9+9CfgU4sbWGNUCazQo00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPmHvK9tjU5zJgH9L8hT8QiFbt4DAbA3UlnFnkOL2YeGC9QEsteSHGyxUNYlbzrKz5oiuqT1F/1oGOjYNxo293W44uGUvEOx/vBWGyGNHhOzW1jYdim1wWFHKhQ238gEu+xNYhtru9LiCDIYOGy9nHFQeno5AETheJ2Z6JC+uOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-963b04fd87aso203740241.0
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 01:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781771475; x=1782376275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GI9UJOxr1l6gPfMPiF/zMOYu67uY0OJOk4A0kyzg9U=;
        b=YzXrjozEXNvnf71iKsvViAAAmkEup2apJCZospNbFzO/AxS9V7axiPC60l7c+1EztP
         pd/QwOzzR/tC+cDJ15c237bm3iHcLvHgczsEq82MDs+BaIrgEm8jHf5H/Z8Ki3soi+gl
         qtUS29gwxXMajtLcJ5D4L+X90EEk3Atj0v7Z87p79gA9c8jiRP5jMvefn+W1u+EpUC9p
         8OY4rwdePVOfaijdToTw1MTGgEFrN9fkkZyqfmX8jzVsPHBbioGnP5VaujwXA3TAkmLK
         ird1pz6CZkaX9vxp+uCNfum3r7Rb5H9eI0/mCj8SlDKNFnkz/A/OUJ4dA2utneWGlAoU
         b5kw==
X-Forwarded-Encrypted: i=1; AFNElJ8zWGauvKFJcIWAkB0pZJ35Vf/0L9VcG1GCPMusBg0K7lln3cbiXR+voFJ+onqSebkdlZxdWzIbSFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5GT3alFzn8ycemTag2ZcgzNgbzcA9UeMSxfh5po4hxLshrJV
	Vu0s/znYcjuLLHMi8pemkDU1t5SEfKZQw5+5lVHnFsAb+aQpo6f0tc4jW2IIpjl4
X-Gm-Gg: AfdE7cn6hLdD1dmW+i0lFTTWvnIWf3A3ungjR23a1lwZJPWb7h5LHEUqDu8uyAqC1Iy
	nwcW+7aVVq8qDi1qOGW7z8zX/culQELb+btOEeadAiTXPR3kBKoHojBm8VCEE+fPAlnz02C86Fw
	3exK3ai6IB3NSSLKdvlQR3UX5hIs3dyXCt5MOmd8A2GcyzkO2Cf4Xgvl2dyfMLxwHEOEZJ0R7gW
	pDTK4qLMSwqak3AIpAvCMkBHm5DUDwohvJH6SZOkPAS3Az5KkVUbJlS3aiEJjtQeNp6vJs4vHHv
	iA+by5Flo/qseqf/shfHGM6C8G1dBzEIuw8lFqBy8nc9XroA+L8reJ47oXuYer5X7mI/vN6btA7
	VjpNOYidmdlTwe/V9vqwR+I2fqkrrZGQ82mJBhn3wZ7foWv2G3E9NKrnPjDSAAWABGN5NANAnRk
	eRW2O+rvN4veQyzdNb+h0Ip0coXscmsjW4TkGE4wsmlwmNUxvPDg==
X-Received: by 2002:a05:6102:c8e:b0:605:4ff8:fc21 with SMTP id ada2fe7eead31-72927ad7ec1mr444950137.8.1781771475334;
        Thu, 18 Jun 2026 01:31:15 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966ceca5f6fsm4515114241.1.2026.06.18.01.31.14
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 01:31:15 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-6cfdce656bfso262450137.3
        for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 01:31:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/VHdyOLyGKhXbWRbhK923JSUB5GUmP3kjpCL62kexZrlDXo7Yo5I/BQUz4P7bg+20XkBd/+rO+YDg=@vger.kernel.org
X-Received: by 2002:a05:6102:5086:b0:6f0:3c5c:76a with SMTP id
 ada2fe7eead31-7292459b54emr359324137.0.1781771474579; Thu, 18 Jun 2026
 01:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618081932.172168-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260618081932.172168-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jun 2026 10:31:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVucx+_gRxc8jS+CGiqQV+U_G=6evTa_1suMEK+Mue=8A@mail.gmail.com>
X-Gm-Features: AVVi8CenwmJWTOn6QdfCagxiHKEqb10IWStknccc3zA4qu-_YEn9e8Db00cjLcw
Message-ID: <CAMuHMdVucx+_gRxc8jS+CGiqQV+U_G=6evTa_1suMEK+Mue=8A@mail.gmail.com>
Subject: Re: [PATCH] spi: rpc-if: Use correct device for hardware
 reinitialization on resume
To: Biju <biju.das.au@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Quang Nguyen <quang.nguyen.wx@renesas.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jun 2026 at 10:19, Biju <biju.das.au@gmail.com> wrote:
> From: Quang Nguyen <quang.nguyen.wx@renesas.com>
>
> rpcif_spi_resume() currently passes the SPI controller device to
> rpcif_hw_init(), but the function should be called with the RPC
> interface device.
>
> Retrieve the rpcif private data from the SPI controller and pass
> rpc->dev instead. Also propagate the return value of rpcif_hw_init() so
> that a failure during resume is properly reported rather than silently
> ignored.
>
> Fixes: ad4728740bd6 ("spi: rpc-if: Add resume support for RZ/G3E")
> Signed-off-by: Quang Nguyen <quang.nguyen.wx@renesas.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
