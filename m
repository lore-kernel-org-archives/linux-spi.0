Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358193;
	b=wz96PExh78nisTpRzKD2WpO/TJcFIkQ3ib/WgIpkfBX4h11Og6U3JUt5ZPWIumsnjzU6
	 gNTsRmYN7btXv1keXAo40oJj0OvPQi2OGHE44sUePNJ8jW4NVseHLZ0RwtoKfTeaW7VvI
	 VaMskBeiPvcHqz2VMuc31M+bnaDkMUM/WbzKOWB6QowILByFRA7eSPaNfVtylP+PkvNKC
	 4Ta29R64+8s2OjaIAys2JU44TQGuPOcu5+Eb9Axv7/756ck1xlAtUCAo7Bo1f1hJGF8YX
	 ZzoLVoHflq9o5MkypDx6DYKiLm7kV4BaSyB2GWSudwL0SKvSjOO2qDf+QaQxQcr7sQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358193;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=wDQuzTNsYUZzEpQWnQWinTtqM7hksZLWKmLoPE6GgXA=;
	b=YngRQJxKQvEGqLWgJjxxw6KMGyo/3bJvAtWn5srVHSiIVMLMWbs74V+PJMeOWRKO27iZ
	 EOD8i7D4INwjoZEoa1194owQAvvvQCbJB3Gx9Txk3ktJoJqt1aZ7nEbs4cxM9yCXK6ztQ
	 1WN/Y97wFHzTM8t66Fd2SLp5erjocbHfDBYCMNv4A/6Is804dwfoPh597D5PoACGLTJZS
	 2DXivkHmsP2RRuZYqCqMTADzGOkBbwWtks6BCAOwoIOmiKiBwlBZ9NvcZ2zAIWB+wRyTB
	 2T9Ffo8gtXhv/i7ek6ohsIebM1IXwbGUTS9pildlkdsa0aapfIvXn9EILqp+0VQRN2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZWR9GNs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1C606A322;
	Fri, 30 Oct 2026 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZWR9GNs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7416C1F000C1;
	Fri, 30 Oct 2026 11:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793358192;
	bh=wDQuzTNsYUZzEpQWnQWinTtqM7hksZLWKmLoPE6GgXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QZWR9GNsgdpcLneWTs9OlHSLEsz/DrJR4GkZgwkEVbttaH7DOI84lYRIu8ys7Ta54
	 R7nchdqGyelgdGCT0BWSqCDG82bnW4e9rbWssIrdfTd+GaTLsoUhhiq0l82wTfw6t+
	 oylKGRpeSy44cRpikn+ycR5xZtgnEvD3faBcYH70YRAWLA3iX8pz+GoBocD2tHaPVZ
	 WTMGUBnJexw5Tdsjge8DkgFlT4BwJ2Iinqtt3Rjdx1GYgspmz14w1a9aN5HT4KnNc3
	 S/wZ+rQ0gRe5YzLxs0nQoL9xunbKoJysmpDFB5ifkjYKYbjV96CNWMvKMrpj/jSUmr
	 vQkpvC1kJHJqQ==
Date: Fri, 30 Oct 2026 11:03:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Parshuram Thombare <pthombar@cadence.com>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 3/3] spi: cadence-xspi: add ACMD mode support
Message-ID: <e9d40994-ef33-4f0c-9319-4efaef3d8711@sirena.org.uk>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
 <20261029-xspi-cadence-add-acmd-v1-3-53cd44690e04@analog.com>
 <179329269255.62540.11497211982924609522.b4-review@b4>
 <auRqTXctbxuuEfLL@nsa>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S42XyFcaP7pE33Vp"
Content-Disposition: inline
In-Reply-To: <auRqTXctbxuuEfLL@nsa>
X-Cookie: Orders subject to approval.


--S42XyFcaP7pE33Vp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 10:16:00AM +0000, Nuno S=E1 wrote:
> On Thu, Oct 29, 2026 at 04:51:32PM +0000, Mark Brown wrote:

> > We need some suspend/resume handling to invalidate the configuration
> > when the IP power goes so we set everything up again.  I'm not seeing
> > anything here.

> Yeah, I did saw sashiko complain (and my local LLM also raised it
> actually) but I do wonder how can that happen? So we need to assume that
> in suspend we might lose power (maybe because it's regulator powers down)
> and need to do redo all the important initialization bits?

Yes, might not even be regulators - some SoCs have good internal power
domains and can gate parts of themselves very effectively.

> > > +	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
> > > +		return 0;

> > That function has a minimum size but not a maximum size...

> > > +
> > >  	op->data.nbytes =3D clamp_val(op->data.nbytes, 0, cdns_xspi->sdmasi=
ze);

> > ...which we have here?

> For ACMD, in theory we can just configure UINT32_MAX on the register so
> not sure if it makes sense to clamp to that?

No, if that really is the limit it's fine.

> Conor is pushing against the new bindings and that it should be inferred
> from the compatible. I tested this on [1] which is not an upstream
> platform so I wonder if it's ok to add support for the complete
> integration even if the SoC is not upstream?

So long as it's an actual SoC that exists rather than some random FPGA
configuration or whatever upstreaming just the SPI driver is totally
fine, that's one less piece that needs doing whenever the rest of it is
handled.

--S42XyFcaP7pE33Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrkeWsACgkQJNaLcl1U
h9Czfgf+Li/xY8VjuiiB8Dx7ZneRguXNxB/JDppfe45MNl7hx6ypdj6W+jfgiKpq
JsvwB5jBD0X656FnXNVge11UzQsAjdHsLFepyUsJcyee9BZUl0dnXwFSw6glk8xr
oh/XT4PXEwiSgF+KHzHKBXVQ++VC5ldTE1XmlI08QZ7toH44VE8ZmZQvWMKk8P5t
N5T93zaff6s3mHyoa5moDkpwMw9tNHanWsAPqi26mzBeeq0WdnMUOZW2HjdNwSkk
V76U4E0250upi/o56kNt7xnQ3tpEpwpf/ZOqhN4+7SNmbhnSuLuQb7PFxyhAFRbk
58sP+EQKrF+LEjd3lveVrlW5pI+/ig==
=J29Y
-----END PGP SIGNATURE-----

--S42XyFcaP7pE33Vp--
