Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878703C1966
	for <linux-spi@vger.kernel.org>; Mon,  9 Mar 2026 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076479; cv=pass; b=lj64eGoLeWE/aPcaC6mS6dnyEMXwzmRIPOBcJEQKagQxubZ77jAkPpm1AEG9XEc4zbvgsuWfzEMCxiXfrTTVbRgX5zhkYHFoZVWtdy0mtusyY7Gl9cULpFA4hnSlm6npjX6c675Njmy8Il7HnKSpDC1/jY1Q6QN/oowt2woFIHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076479; c=relaxed/simple;
	bh=l29lN5gInZzHXUIrk+ZoIn3pwYJ9UMUbL1wkQ1JSvUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EidYEUHZPjvBsOhpTw/NzlsWxp/aSYiFTPWLV8NLUb+0rgKZTyKBEWtlWkFg4bZAklbCWZkLR+5P1b6fG178Mv4wrlkob0TorptdB6f0m90GD1Y560dx5Bmx8kWYfdSJzyJX1WuqX3HpEd0gNq/UEgk82mXGi8PGlAAq/OJHdk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0pRT7Km; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0pRT7Km"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a8fba3f769so51875745ad.2
        for <linux-spi@vger.kernel.org>; Mon, 09 Mar 2026 10:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773076478; cv=none;
        d=google.com; s=arc-20240605;
        b=iHo7nnDzZgijyzbYZepaUVc4CHyPj7e2iGJFaHyAC0tozQZAwJnMtns0vW9iwrLmZc
         Bzu/EcGYjdFusCK6+F8XVI3QQMyrgGP9G84mmGfR18oqFipnc7uWD2UwEOUe6o8fZXHO
         9W4Xppnf2M5axzkjTHg+7DCnUZAleMMQGrJaEBWxA8lgaPd4w5fAFlies7J4mYq6qUHs
         ryT1da7Rrs1vPPY1kVkVW0IyYHARjXkzksECfJ3dEpfZcrq0HhOWUnygVz5bdrOOD+Vj
         IJ+qDNQKJsJ+iQjSt2Bkv/vlOMBDKCyPsuTbYaqLvA6LzKCmIDam+X0txbLmUi5cS3qd
         VXrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tjsgR+2CRjAh8JNtV5+Cb1v0JZ/Gymuic9XSyJ4Xs88=;
        fh=xbnWpW/cHFJCq8yNc3f1bhuxRveP2QvLrd+c59udk9M=;
        b=CMli9Kz1tO5/b83Irtec1irQwz28/9BedcbsJgd332BHEQvOqA6aBZhC/ueyqBtMA/
         weshCcYKE0J0fIttNhyJMz++Csxaxi/S1GAy5WKR3X3uqPK+SiwhuqxGFIhOyPZJXYtO
         zfTkhB1AIsiTyDMGCqqCB41+lBA/vXcwdrVz2X1I9qXN3CHyd08H23D/kjjXd6T/evhI
         0wFqacyyfBOWGcpSYpelKqddOs1z0myiYJDwiuPz2sU1DIzeFaLy5M+xNnvNDGX1v5q+
         Y/Z9HFQu/b3fSTsM7oZCpECisSRKTwKL/l3qBhewy5zLTMs9Eldbc7IaGiTbl0U8jqv2
         N8ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773076478; x=1773681278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjsgR+2CRjAh8JNtV5+Cb1v0JZ/Gymuic9XSyJ4Xs88=;
        b=C0pRT7KmiK38XPG+BuS7OMc8H4rKLu26YI2jfbeDYELs6xOalPDOjm/UR3SBecWqpk
         SgG+PvqG9Eg5WrcDkWRj4ANPpA9+astTY13pG6/D1lsKOl/Gj0XiUXQjjSauwSDRPnyd
         gjgAOoGxSg96DBcg7TTGQyS0vj2as9LAQQYvRhj1SEkhjos/8HxDUNW+zsn/Qe8ogKyP
         b9j+R9infeVthpZXiz2o6gYKpFdYzEC56pEJhydJshRh/SptgRxuqS7saHpLv2xVGTRl
         Y15WicItMTQguq4pJewqwZ3Fvea8EqCZp2pC45Pm1xjQQsYMDSJ7SZ97kfpUC2WmcTkc
         Hweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773076478; x=1773681278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tjsgR+2CRjAh8JNtV5+Cb1v0JZ/Gymuic9XSyJ4Xs88=;
        b=hOkylpuBKoO7rvFhHY3O6Yc0ICZrdrzhw7ZEVTHes2iO1mbWvbknc8ud5LzTWUQLZ6
         VSl0Y4hX63bGdEoi5MQW0ZkSMHxuLd5HNHQPPJpWOWeEBgjQVfIBK24dbPffVfD5fRfN
         BUhpi41HreZSkaX7EZbkIERE+I2gSFZ6XhMuLt+7Iwqm5MX7ZHaEt1mqFE1g87zGN2nl
         tBO7obvL5HD2eHPP4PoS88jrlUGdsyZwrhsgmO6jcgMcQtA9+b9lHVbmmow70OYlfGnh
         uBGda6JaOqvHBpfl0nhFFw9w641F/BnR2SXDkrXBCBvX44fqKLcaRwQkpJgaWopnP+GZ
         SHDA==
X-Forwarded-Encrypted: i=1; AJvYcCV4uqxsXoXiOr2T4RpqppPTwrL5bdiwAOCOrFHjKxRrpUhGXpLS06all4IbVB/rSKSMvuZlQ1r/a8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYIqkNAnhjho7CeaAqYLrdi7wyr56vhVp00qKX30rUjFU09Pmc
	QX4v3tFFylG/2f89Nk2fQ1lrO0o0Ing91KHT2p78VI9ScgdikmYedCocBbRD47oYElW9Q1iqTTy
	xL9X+6lFpANJfuGHsBnvpVOMuTxPsPeA=
X-Gm-Gg: ATEYQzyc5TIjc84zoz2ozYf7Fa3h6ZLheEk0GMt26REo9QVPUHDM7ymJiELSTI6JJpd
	GDaVH74jQYaq8qjNdAFt42j+VNCFbUh12E2shsPajkfPuyzfivEnkcLMbPCdvD5TGbYC/DJwigN
	AOCpKgcQ6KIaVqh5Yy1sy+vM7SRmZYuYvFpmKPhXT3E3Kk+Kpl0hR9HyarcWPFN4Vow/1zTE21g
	aeA8/6M/Qa2Wn4OgGEIqKb6Z3DQjnn3VJpA0v0nFtSzuLlZdqa9c65lp8S0YWSQQ0YSPHB0Ebhr
	A9sxGpyE
X-Received: by 2002:a17:903:3b8b:b0:29f:301a:f6cf with SMTP id
 d9443c01a7336-2ae8243435emr108577225ad.35.1773076476823; Mon, 09 Mar 2026
 10:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305-sfc-v1-1-6fbf6df0e899@gmail.com> <52755ab9-7387-4f4b-95d4-2bfdeedc3e5f@sirena.org.uk>
In-Reply-To: <52755ab9-7387-4f4b-95d4-2bfdeedc3e5f@sirena.org.uk>
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 10 Mar 2026 01:14:25 +0800
X-Gm-Features: AaiRm53J4G3yrXI8HJ6leV9ZFby5HBAwXjcN0JvsfYQSy0YFE0AUPPrn31xO1q8
Message-ID: <CAN4SLj2NjGSFqG4hatQd0CL=RgkKJXeQJZuYPRM58-vp4GqBEA@mail.gmail.com>
Subject: Re: [PATCH] spi: rockchip-sfc: Remove redundant spi_unregister_controller()
 call
To: Mark Brown <broonie@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Jon Lin <jon.lin@rock-chips.com>, linux-spi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:29=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Thu, Mar 05, 2026 at 11:38:21PM +0800, Felix Gu wrote:
>
> > The driver uses devm_spi_register_controller() for registration, which
> > automatically unregisters the controller via devm cleanup when the
> > device is removed.
>
> > The manual call to spi_unregister_controller() in the remove() callback
> > is therefore redundant and should be removed.
>
> Not just redundant, it'll be a double free.
>
> > -     spi_unregister_controller(host);
> >       dma_unmap_single(&pdev->dev, sfc->dma_buffer, sfc->max_iosize,
> >                        DMA_BIDIRECTIONAL);
> >       free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize)=
);
>
> This does mean that if the device is being force unregistered with
> children still present those children might still be submitting SPI
> requests while the DMA buffer is unmapped, but in the normal course of
> affairs it's more likely that the devices will be unregistered before
> the controller.  It would be best to either roll back the use of devm or
> add a devm based unmap of the buffer here, the current remove function
> has correct ordering.

Hi Mark,
Thanks for the review, I will fix it in V2.

Best regards,
Felix
