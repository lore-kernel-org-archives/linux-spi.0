Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CC3385506
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040628; cv=pass; b=LPyed3dzLvxbdYClOROjeKEFu3KB1zBO6htVquICKhFNp1OgNoehF37is8734JnSKRdILvaeahLVfx6KDkQK0oieHhZD6JJYqQqUoTLbIDGnsniH+ejPrH9FWzX1J+UtWZUssu2R69bv+3/MRO+2mRF25Z67F98+Z9SsjIV5sQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040628; c=relaxed/simple;
	bh=TbynbP/rbCQk2ywH5TiPVu9krPSvulMPQby7aN5rr0s=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjsbOI4UReXhp2L01jjl8dB2jXxUw3GDj3sF93Q6Iu4n6Q5wj2ELNj5Z/6A5DUjw1BKaTihezcLoIOVZta2TwZSa5Z/MaDxR82RqVsRUOJZV8TIz9dMu5m72YjnWHhWmrhDGKxigPGstbXzaCHR1S/AYXciECsGH3ejzksnwQ0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TcmC/V6Q; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TcmC/V6Q"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec450b950dso877578066b.2
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 14:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781040625; cv=none;
        d=google.com; s=arc-20240605;
        b=XzGbhDuImN3qN8LUK7qSxmHOxqeXwaO3u5IAvASiYBaA+UN1DElb1wCqO/rYGozhUZ
         4yBETAh0AhwFkXLp98Fz2kBvu7dYRIVCfv6bVzUyrNaKLmzW70au/F6Im98BVPe6VBai
         7Wy7CVbUYYp0WgA0dXbFyvN3QoYuPozUDwyFdJINZbSifmZQehnlZICDhk5+dsQphYSA
         WJXOLMKPxJjFFZwlsLoFXWM/d/PfSx3GmNI4bGj30P83Gr+AGaHYUJ5Ue+buu/c2FvtX
         ZjZoNYL0Wt4ytqDpVWixs06+oJifUYUKCCnB0dpEeuOCTvq7ScrD2UsyHo/PQ9B2LPmK
         H76A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=OyaoLWvSBSKiTIcOe7IFeaXY8jjEo9UJ9whgcmi/C6I=;
        fh=o2dJwWdHkNHcBb5FJmRguZ4PAzSS5LeglMQhoa6LWXQ=;
        b=af2q0xfGVlWnsGDrMkk23Dn+W6i9/RvTqQpH2LWU//8ZN49t9Rj2MvI2M1hmS74BOy
         pmb0D3EN+BwK7lZF2N/J91gw9/Ftu5qW6J8ftxbBA0HKTUU/ZjglK4kXKM7YSafogqJx
         pGMkfiFhkFD2AxgCMDPScITsBA+0aLgKMoigTkOPyumr5v+MPdherXw++EN0H/q1nJLw
         ycOHcAaEROSvbL9o4i05L62gJgtqptyS0RZFBsM0TnTDkC+CS1bOuhzfwa8n2cc2+Rmj
         RtDa+tCa3nk66mLua8sz4FzTr0y7d+I80oCAPxFtaBqMofyMK2oY9PxDeVP7RMqB2DWx
         7ljg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781040625; x=1781645425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyaoLWvSBSKiTIcOe7IFeaXY8jjEo9UJ9whgcmi/C6I=;
        b=TcmC/V6QXQfxwZKSWjtKlkvjOwoGt3xSPNg+O3KPbq/fsdAH7hoPIx2dJMRtxmQTDN
         c/FuN1pAa/+rFBM/8t6MyolmQjEbFoaajsLcwXG1asaHuZ0TYbMK9sODkclAppLdvDa8
         XEqEr8UlaPYpVpXIivFBHpa92NURMdaJ+DmTgLEoFu0oHxzM+5JLV35D+p9VDIjXHUKN
         Uvs5gA/R3tFy5Wc6kL+WSt84rmFgd588ff00SnkV/5TwmN+369ZaQj/8CpoOOQ7c8iCX
         /ZKNIoloMz0ViWo2W+9uOwnZ2zRmN7jrXekx5SWZaz+Z37Prrq/QMjiQ2YTGWz5v5osl
         CoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040625; x=1781645425;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyaoLWvSBSKiTIcOe7IFeaXY8jjEo9UJ9whgcmi/C6I=;
        b=HdEgjPWrwShWavScTyKKZj6PQLA1bdecqEMuJaF9+HPd7kB0k7cxoeUjYGCvZYmQC+
         p8v2/NN7wPoGXs3NmGYtop/hUxFYX2m5qZtPMolfTJ4IzuZHO+QCWL4wSwDyYm1W3UIS
         vUVfbGRh/M1QCUJdc9sotTzJsEikXsV9ujxaV+5yUsOcN/9fsuUb+GUGCJk0FWXXVnrM
         hodg8UCNGU/KwtVOAdG1mtJGbm2jaSOr1RRVZv7oXc34CwjcTwRCC5P7moHNvuRwBK12
         VFNL06+1SXdysRYPeITWYawNGAFrZfi9tD2lbDynLf8L4glWjBpKv7KlR1bMn7id7/UT
         cGvQ==
X-Forwarded-Encrypted: i=1; AFNElJ8A17gUBNUd3L9tpdbf9W2bRREUSrPdqjz79jEcGZhGd9UbH7uxyqe2FYspkqZ+W+NJlWAyIt3KPAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWYkX92wIMw/A8lyss/kDx0Y0ZBMteOK2W0pnaceZS+bhh6AEF
	u98rrk1SV3IFaP3HDlu5lYu78YX3YdqdOgh8xNxqP7/RygH5T/9/+i7M+0Pu+mS/wn/QH1Fsmzy
	wJonQX0mqFXx6RDuJoIAORI5ds306kypJUjmDZtbwjg==
X-Gm-Gg: Acq92OH0yS0aM5ULDAAJ5FxSh3xqV8TViRQbyT3UL2EWFtO18pszEdwMX2/l4N+2QOB
	lC5iE5tBbuWBNFOcchKo7eGUHNiqRn1KUvSPgYMKaGfdv20XxHAwT/di3n0XhoX3usVHDfAveB4
	SNfve8GWehj6aaKZLSlHMUYJ/+RaKPQtKiBXCMqEnF8nH/OmyLDPLNN56oRzIcezZrhYPxWNRGq
	bpfPmtNEE18J2wPrUb76O9CVlTDfarevuuXdGkoA5PuAQ0Uiy2egC4hq2RJ9jIvpX383rR6X0zv
	24jWo+opVH7Q/Fn0jPPL9We2O8WL1dtoHBsrg0GpqVtm+Sk=
X-Received: by 2002:a17:907:8693:b0:bea:3e9b:83b5 with SMTP id
 a640c23a62f3a-bf370e63a84mr999800966b.22.1781040625083; Tue, 09 Jun 2026
 14:30:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 16:30:23 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 16:30:23 -0500
From: Angelo Dureghello <adureghello@baylibre.com>
References: <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
 <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org> <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
 <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
 <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
 <2b532d56-dce4-4f6d-84e0-2fd87d5494f8@kernel.org> <20260601144332.GC4918@lst.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260601144332.GC4918@lst.de>
Date: Tue, 9 Jun 2026 16:30:23 -0500
X-Gm-Features: AVVi8CezOGOq-MNrhv5y2nA_4hBEGDCtfXzAaSWT86Uo7sqynIRfYGOJbVIBc1M
Message-ID: <CALSJ-wAaOsizvHGiCdL_mSKS-LQGJKgbnUeBAnE8H+h-7xOGhg@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, 
	Arnd Bergmann <arnd@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Jun 01, 2026 at 04:43:32PM +0200, Christoph Hellwig wrote:
> On Sun, May 31, 2026 at 11:42:26PM +1000, Greg Ungerer wrote:
> > I don't think that is right. The way the underlying data cache is setup for
> > MMU ColdFire (via the ACR/CACR registers) means that individual pages cannot
> > be marked as non-cached. So coherent memory allocations are not possible -
> > at least the way things are today.
> >
> > It would be possible to set aside a chunk of RAM at kernel startup time
> > to use as a pool for coherent allocations (since it could be marked as
> > non-cached via the ACR/CACR registers), but there is no code to support doing
> > that today.
>
> With CONFIG_DMA_GLOBAL_POOL there is some generic code dealing with
> most of this.  But if this driver worked on coldfire in the past,
> it must have been fine with non-coherent memory and could use the
> non-coherent allocator.
>

Ok, thanks, so the driver is working fine with non coherent memory but may
be just for a case. I will try to setup a better SD test. And will send
another patch to have dma enabled with non coherent allocator.

Regards,
angelo
