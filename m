Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712FC47010D
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552209; cv=none; b=O7/AuZ85U89uPe/bYMoy/PBJFrKuzAbroj3xCm3rafrMZW3qfYeUGa4TWQ/eXN+JuN7ZSsYeOZM54qoyka7iXUiHJEZkVYsKOmWuBh9iChH/5C3QxreyteDHlBtfVE7O0JDoJErFPlNEIhcBOMWoudTMmSlNMJCO7KXm8d/N/wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552209; c=relaxed/simple;
	bh=1nxBbdYt4NyVpUfMMbPHXMdAVynnyeyFD7RDA7bfvEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQpYSyB5FUc68GyLZm+Uas/syJhDGFEWq1E3KJ9+ZjPgK/yCO8AVG3blInwSIH1qWQuGZWTeGV29O4l2mJzsV4mPdqiabEoVIqS8nKSQpmSEp/faJ/s7s/xwK/8DcCDMXgXYQBcjYnNxUQeA1WM/UptmbJb4JMl7UQCY1IeeiTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FTi3TjSU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FTi3TjSU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-496b7622a83so8276495e9.2
        for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786552202; x=1787157002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SmkTZ3IeMxC+OXIAB9iDoircMZw2Dwc6lMPotGUqEQg=;
        b=FTi3TjSUHzc/HRjywiEBiHCFvI+9lPZ4Y95+kXqA+LXmvwLYPKRRbDrhj8lEi5t+fm
         rG5Js2MukdneqsDPy/XsZVlFfnbzaDps5ATNiBq8n+suWV4CTqs0XWOnCjzxjlHTM86T
         WQTrct7l7fUkU4vub77zSd6gLndrYkJvMW88O1ZdptrTzMOuOEoY2OREbDvc0aALJMMM
         caiNmbXumWZnqnyMm6vYESGE/Ln9kqzvt/fVXOzdmGU5WNf7E81rsi5dCDjdfLva8emg
         QljOx4vZb2l8eRVPqAmL6OgvwQgRiZaOqR7UR3B+y9SNLrKslOgMmBjBdjKuNMpmTMtk
         RT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552202; x=1787157002;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmkTZ3IeMxC+OXIAB9iDoircMZw2Dwc6lMPotGUqEQg=;
        b=gBY3Ay/JapMMABP2QT+cjPHIT3vpq8UoWysgfTBmJjbGJA0a/PGWK2unWgOVNXJji9
         +J2alJHlb8hF5HUMpB54uOtfP8/1d12hkes/GiratRi4wvBuEDPWDrmAksu2zUXOqEmx
         PCSw6UzozhinutsxvOLRJECzrmy71IgrEtnrE3mhBUt6OqY9P/ec2TLhURc7ZqZG4LN4
         n/hghHcJT5aQqY6bsHbTLO6AYjV7QNimN6d/nFEII9SXYAOQC+lKaRZk5VRZ5HI56gFt
         //EAQCFGeq2zWMYqK7eolPH7J396jqgcvRrD3LD0XbeHizPENWi9hwzCQymL93ZIR9uX
         EwCg==
X-Forwarded-Encrypted: i=1; AHgh+Rq/hTpli/0UTB99agAlh/NjVHUt3MFtnbTQHMH7N9Mhca2RVCe+MYThV51YrUVenyzBfBFfvX3ey38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKkEbVSoQ3E51X16T5IXhXJ7AhhohHvb/YNAoCjTOBc4lr/rrc
	yROvzRiCI10Awf1Zd35yMdOXAxydi7OR5qvsCZic7y5/YuS75mCDPIpRUbPWCKDbKR8=
X-Gm-Gg: AR+sD13Vbo5q0RbH7ycRtZfKcVSqZ6thjYYgI7Ux/hR3sdPpv/MgtByt30YOKa5Ce8t
	x0ALVkMlkshlpSnPhIP1BL37CXe8K09xdp96lDB1bwIzRAnfieeTBFVWMYnGuCHJdAf49ivbVdu
	YbKiLb81ZNZ4xzbqR7HP8tChhVXLXxOqwH0kEhGpwd7rxtZAwMXFHAsRggDQPMOLVV9fNLGuqxf
	b7b8cd3QXnDOvZOG/H3UFO7qLPRf+S05K0uVHB6/AsQMjAo+tRpakYwptYGG9plv6nDqj50Yqng
	9f8m/x0GkrwRZHGRlL6W2DI27gtMvdaAUGh62AjrSWsRPbbH6Z91RBGi+4OSDTkQRCU6teM4aPs
	oAsYXn/ZBz0cq11FE2y58QouB/1j2kIKThED/E0ImkjTxdnEh8TEWjFoQ7ErawtHzHe0g0w3N8c
	9w0HEgb8/mvFoX4SlYP/FQgDqkixDJzsB/I/MtoO5R1uO21cerUTBuvqnvUOXdoFB6e3YmlcOBI
	XiYdwqh3wqNpaBDUa3Cbl9SC/NrM6GVVuL/z7GX8UrdxST/EBE=
X-Received: by 2002:a05:600c:b85:b0:498:2b1f:e0c6 with SMTP id 5b1f17b1804b1-4997c12caffmr92430045e9.18.1786552202335;
        Wed, 12 Aug 2026 09:30:02 -0700 (PDT)
Received: from localhost (p200300f65f017104d14d09407ec2ee4e.dip0.t-ipconnect.de. [2003:f6:5f01:7104:d14d:940:7ec2:ee4e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49981aba3e3sm4063945e9.0.2026.08.12.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:30:01 -0700 (PDT)
Date: Wed, 12 Aug 2026 18:30:00 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "M, Krishnamoorthi" <krishnamoorthi.m@amd.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	broonie@kernel.org, linux-spi@vger.kernel.org, akshata.mukundshetty@amd.com, 
	bleung@chromium.org, groeck@chromium.org, chrome-platform@lists.linux.dev, 
	corbet@lwn.net, linux-doc@vger.kernel.org, skhan@linuxfoundation.org, 
	andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/4] espi: add core bus framework
Message-ID: <anye28kId4k8pxBv@monoceros>
References: <20260804115259.4065638-1-krishnamoorthi.m@amd.com>
 <20260804115259.4065638-2-krishnamoorthi.m@amd.com>
 <anSGjRK8spayFnKw@monoceros>
 <0f7469b8-8275-4061-b336-97cbce41ff82@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2paxlrpjxbcfpa7x"
Content-Disposition: inline
In-Reply-To: <0f7469b8-8275-4061-b336-97cbce41ff82@amd.com>


--2paxlrpjxbcfpa7x
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 1/4] espi: add core bus framework
MIME-Version: 1.0

Hello,

On Wed, Aug 12, 2026 at 06:20:29PM +0530, M, Krishnamoorthi wrote:
> On 8/6/2026 7:01 PM, Uwe Kleine-K=F6nig wrote:
> > On Tue, Aug 04, 2026 at 05:22:56PM +0530, Krishnamoorthi M wrote:
> > > [...]
> > > +const struct bus_type espi_bus_type =3D {
> > > +	.name	=3D "espi",
> > > +	.match	=3D espi_bus_match,
> > > +	.uevent	=3D espi_bus_uevent,
> > > +	.probe	=3D espi_bus_probe,
> > > +	.remove	=3D espi_bus_remove,
> > > +};
> > > +EXPORT_SYMBOL_GPL(espi_bus_type);
> >=20
> > Do you really need this exported?
>=20
> Yes, it is required. Controller and slave drivers built as modules refere=
nce
> espi_bus_type directly when registering devices. Without the export they
> fail to link.

I would have expected that

	drv->driver.bus =3D &espi_bus_type;

in __espi_register_driver() is enough for drivers to not have to use
that symbol directly?

Best regards
Uwe

--2paxlrpjxbcfpa7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp8n4YACgkQj4D7WH0S
/k4Ymwf+OtbJNAPe3Ou/27KwbxJa7KENRUomWmPpgocqBVTa4ITzi7yNWHl4gAqS
n5Xc9dI8tHJ49x6eepGWEp56WN4iknHSvv4VfsYY1q3IiP0BA7wHPGNtXoWIHOAa
4o7paa8rCqvUEEnsWHx6t7NgF4d9H3ByZLukSoHjbEaMGXR8k4sAoIZl6OP1zHLL
sDcIp43PhG5JIYLJA+zNDa/GcsWt7GAOI61w0iEk642G+3Sp4LU4Aeml8sLnCZwv
z5mEpWndwlZQ5q6u+eQBlADmahJtNTb4U9cwNydL7sdyQFKIWhpQEIlpaBbpzcKH
rwtLLuNJ9v2D8mdQKMK2Yod5Qp7vCg==
=HyN7
-----END PGP SIGNATURE-----

--2paxlrpjxbcfpa7x--
