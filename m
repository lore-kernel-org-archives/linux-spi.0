Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794200940;
	b=aL6wkR2Dtmmpku5Np9lvsZqc+cCR9R1frS13lnCDKZ9TUGfwHUj57gR+PttBlWMylkfc
	 5NwVIRSVuopZFFY7ZjCKGvpWKpCf24errzSdzqHawNFnwylK6YIq5l2L4mL5NtWB2yU0M
	 xEEk4YuuTfi0q7lU3oXyTs/WUhIxjwkFmY/m0pZPauDzKlWzwMw4yvmZ+I3tFlZyKdXuU
	 HAw3kGRFDxSoiZQoUifYnJG9UequzuT5tCQsmhz9v0XO1KQzTETW7uwA+ZMYvB4v7h297
	 4nGIWDFkVQtn+b4QjEX2Sgydzf3RQQb90zTzqO5qXFCzk8+IbYNEc76uicIlt2BXclw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cunAw1V91oucnsdDfdF6SnKqgoVGUX++JtV5G9Lj6OQ=;
	b=qQ/HFcj4d7SR+OjR7JLCC7NI3FaIpnnEuFlJY1YC+qxGZvpZR8/iGkwXi9OkSGQxwn0a
	 30wJdaCOgw73AGg4v/c4fGmtlry4Ew7tXnybP6ZYUCT6Int1nchXjZ5OJH59xHHBYvnTz
	 uW+kUhiPZb9WXeBl2MIwm0na9tTzXbVt7CtavAIaCXG16R/jX8OSrHEpnYqDiq/F4bts8
	 Oh8W5BmZJ0WcmcHySGHytJn7R9lIVTlfOGCCKPmhfX5QYedHNlN3WQiRsJO3OACY3oEw2
	 ypIHfjbm/m0ESX1FJVULJLBFXowkjH0vyhtp1qTjWmKHjPcfJlpNzI0hJnotLK5g74g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTPEMszT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62277606A321
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 05:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62277606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wTPEMszT
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso595843a12.3
        for <linux-spi@vger.kernel.org>; Sun, 08 Nov 2026 21:09:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794200939; cv=none;
        d=google.com; s=arc-20260327;
        b=IXt0hZHDWv/9tX4KtvG+B13Iqn84/QqarEchzMUekks1ajgSvkSDQsnTMLH8DBWB5v
         nkxZWcgODJicucbN1ut2zoPfALuU0Bwq1fPZR0SK2gwyy6vIs29Rqnm7/siuzMHzNGDG
         va/leM+kyxue7zow96x03jj1KWCerJ3eUGk5fGN2eJPiII74NyZZev1g46sWH54wVTdg
         jQFpta5w7G+ZqIL3U2pa7hgFZMoKaFhND3iMxF4X9w4NOdr1TKBlhM7Vj5rXGEjrqmyr
         Ha61pdfgzn9MMLMCCwMBWxLdWgocKtA2YPfWdZ/tWTeZ3NQoQa3z/MMFCFcHaO3qvLDu
         +Dhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cunAw1V91oucnsdDfdF6SnKqgoVGUX++JtV5G9Lj6OQ=;
        fh=IfpXkbEUVAg+9AgQazJ1wSvlB0a5XTrWxocYQOcVfdM=;
        b=YL7L5vm6b5YelR8Dh3o1SHS9c42Ke4nHDzbAwu8tN7dv1kMbgEhKHvLbCALEs3SBzA
         g+qjbVMYN5cmDVp8yayz/SdplHVxEpTsuac11k+lKUZF5JSdegX4/efgnMIZf4rhSpt6
         GjO5/s9HMxcYbajdfL/2XAsaYi7Kc41iFXoDzhsTOPoVnq5AXN4NBCiR0ZSlE4vs4jt5
         WyRdNx8CPOr74QKQCw6XfMH+wGYoQcYCb3WvSafQi99e04M2PgJM/LDhSOPggOKYkPGm
         tjw/tUE09CYRD1R0HkeUa9SCuxEVGuQmKPeO9BKT0+aLl4hL5BlUqMGYZZzmCC8k8ZzZ
         38gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794200939; x=1794805739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cunAw1V91oucnsdDfdF6SnKqgoVGUX++JtV5G9Lj6OQ=;
        b=wTPEMszTnWV91ZcIlaY2yhRo9wbze3qIE6M+50WoAVluEC0qs7v4wiCTKfz0r0IHeq
         KCPc03yTP9VWZqDbq/zgFRwi2lSK1VM5lqi72Kr9yTm2IRrbXciskF9FDUZhJsKSaAkc
         1J4KY1Y+Ivf+CMwYtWxyydQG1cXuQCAdpAd/j0hu1kilUloqeX7K1b4YYvC/9rjQrotJ
         SH+cB6zN3x8b0t6FGdB3ZbVzO0VtbySjKzYAJ2/5SE1sdC1Otbk8S0a0HLJ1SbfatCNc
         Fl1J4YPE/5Fd0OISx942XQrGJv/OQ+KOehuzCcyDI9KBU09KdK4wbljY3mrzj2MFWuEt
         EjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794200939; x=1794805739;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cunAw1V91oucnsdDfdF6SnKqgoVGUX++JtV5G9Lj6OQ=;
        b=PKbKWzeO+w7N5YoyfV+PHatyUcqzUgEb4rcM5unJmAzrgMzzbuEPlYf+CRGn0dst3T
         n9q4CIbHs25I3D/X6ZwxxioFOcaNvTV3Zn1hVeeHLDDgHuVfaDcalPUWRPFndWdINQsJ
         0hTtlDrfaZCZUuwgJIPsg01BzfN7ECh1WE678Ogv81idpWnRsJQpV4DT2vB5mlruJYxU
         JfDJKA1/jlAb0q2hnwB32+YzbZlkHMifCnRZqNZS9NdnvUF7CbIEdCxVmLzyT/+U9eVr
         /UQJNC4qnSfLthMciiro8eozwredQYMTr6WR9c+a3Xyh0avCyOvDA0+WhrkoX9Kb+F0Q
         mapQ==
X-Forwarded-Encrypted: i=1; AL+hErEbkPX5UzW5fScXcQCssaAlaE2qpzK3DjiYJTihet72EJdSszl5+2csZxNYIOusCG31/wWl2h1JRWw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+luu9lkwIiatrB09koht2tWQPzoIBPowXmdummHW8UZQICeks
	KoDtfcmMSh2MUc+z470Ahe3Wh4dd1zKPes9gE+bniFba9MMj0KvNrFjXE8laQxkVN7o8cbh0qv2
	HjIFSCJ401JfPJbOSWbixTOG1h5Lk140=
X-Gm-Gg: AYBFou0C8KKkw5xYRO/u02zfC4CY5xY8ZWv70L2O6GfZ88iblG0JsPjo5nwwmD9h4Na
	6c1MNgjIy/aKelGXOG1Jwa+9y0Sl+VYwTiE83CNSeIAWMTAavM53t2cSOgqBpmFWaS88pbbd1TS
	IMsPg8gH8Gi7+0zNTYRAOOIlLvg+PZQo+IYgrGi78y6UTKQum/BinieGKz4t+RIR053VJTrxu2b
	6+j5IVVhQAOlOLDk3l8IpNmuX3NKcF3IeI/WPnk3FMs99PyRIjeN88zm1OSDx9EI8vXmeF/E2x1
	wM/xRSbtJJzfQselkx5MZGLe0IvOLu5+DMpHkvoNJA5/gvK03Hq42F6irQwG18crFFmwme9VFXy
	xLxWLT5iPUsCGhm47PvIwekrVRQv1ZCMcS57nPEI=
X-Received: by 2002:a05:6402:434c:b0:6b1:c5c3:9624 with SMTP id
 4fb4d7f45d1cf-6b7224553c8mr1984042a12.22.1794200938525; Sun, 08 Nov 2026
 21:08:58 -0800 (PST)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793689461.git.zhoubinbin@loongson.cn> <7258e7e16b8a563e60b7129946c292f70aeee1d5.1793689461.git.zhoubinbin@loongson.cn>
 <179406466808.3424803.8169701061345998672.b4-review@b4>
In-Reply-To: <179406466808.3424803.8169701061345998672.b4-review@b4>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 9 Nov 2026 13:08:45 +0800
X-Gm-Features: AclHuK9co97_tP3diCq82twGE0VR9UQNhWeTGrqj1IeLNbjjNYur-RyKJ6mcPPs
Message-ID: <CAMpQs4+mZXroi0ktC88TchNeOvGfto-qgJ_HFif79pcdWZm7Pw@mail.gmail.com>
Subject: Re: [PATCH 8/8] spi: loongson: Add interrupt support for SPI controller
To: Mark Brown <broonie@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark:

Thanks for your review.

On Sat, Nov 7, 2026 at 11:17=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> > The Loongson SPI controller can generate an interrupt on byte
> > completion.  Add an interrupt-driven transfer path and use it when an
> > IRQ is available, while keeping the existing polling path as a fallback=
.
>
> > +     /* Read out the byte that was clocked in */
> > +     regmap_read(priv->regmap, LOONGSON_SPI_FIFO_REG, &data);
> > +     if (priv->rx_ptr)
> > +             priv->rx_ptr[priv->count] =3D (u8)data;
>
> We should really have a handle_err() which stops the transfer running,
> otherwise this might run after a timeout has stopped things and told the
> user that it owns the buffers again.

Yes. Added loongson_spi_handle_err(), which disables SPIE, clears
SPSR, and resets tx_ptr/rx_ptr/total so that a late IRQ cannot write
into buffers that the SPI core has already returned to the caller.
>
> > +static size_t loongson_spi_max_transfer_size(struct spi_device *spi)
> > +{
> > +     return LOONGSON_SPI_MAX_XFER_SIZE;
>
> Is there a particular reason to encode this limit, it doesn't look like
> it comes from the hardware.

You are right, it is not a hardware limit. I re-checked the Loongson-2K3000
manual: the only byte-count fields in the SPI block are CTRL.nbyte
(SFC custom-command path only, max 15), SPER.icnt (interrupt
granularity, max 4) and the double-buffered FIFO (2 bytes). None of
them limits a spi_transfer to 64 KiB. I removed the max_transfer_size
callback entirely.
>
> > +     /*
> > +      * Split large transfers so that each individual spi_transfer
> > +      * completes well within the SPI core's completion timeout.
> > +      * We allow roughly one second of data per chunk, capped by
> > +      * the controller's hardware maximum transfer size.
> > +      */
> > +     speed_hz =3D m->spi->max_speed_hz ? m->spi->max_speed_hz : host->=
max_speed_hz;
> > +     maxsize =3D min_t(size_t, hw_max, (size_t)speed_hz / 8);
> > +     maxsize =3D max_t(size_t, maxsize, 64);
>
> The core should already be scaling the timeout based on the transfer
> parameters?

You are right that the core scales the timeout from speed_hz and len,
and that the old speed_hz / 8 heuristic was both redundant and
inaccurate. However, we hit a real timeout in the field:

    dd if=3D/dev/mtd0 of=3D/dev/null bs=3D1M count=3D2
    dd: error reading '/dev/mtd0': Connection timed out
    0 bytes copied, 0.891911 s

The core computed the timeout from the theoretical speed_hz while the
controller (no DMA, a few bytes per IRQ) was much slower. Removing
the split makes this reproducible.

So I kept the split but moved it fully into the "software policy"
domain: a fixed LOONGSON_SPI_MAX_XFER_SIZE (4 KiB) is passed to
spi_split_transfers_maxsize() in prepare_message(), with a comment
stating explicitly that this is a software policy, not a hardware
limit.
>
> > @@ -23,7 +23,11 @@ static int loongson_spi_pci_register(struct pci_dev =
*pdev, const struct pci_devi
> >       if (ret)
> >               return dev_err_probe(dev, ret, "failed to request and rem=
ap memory");
> >
> > -     ret =3D loongson_spi_init_controller(dev, reg_base);
> > +     irq =3D pci_irq_vector(pdev, 0);
> > +     if (irq < 0)
> > +             dev_info(dev, "no IRQ available, will use PIO mode");
>
> This either needs pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES)
> or a check for irq <=3D 0.

Get it.
>
> > -     ret =3D loongson_spi_init_controller(dev, reg_base);
> > +     irq =3D platform_get_irq(pdev, 0);
> > +     if (irq < 0)
> > +             dev_info(dev, "no IRQ specified, will use PIO mode");
>
> This should handle -EPROBE_DEFER, and since the IRQ is optional it
> should be platform_get_irq_optional().

Get it.
>
> --
> Mark Brown <broonie@kernel.org>

--=20
Thanks.
Binbin
