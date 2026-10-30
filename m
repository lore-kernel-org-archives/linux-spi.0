Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385634;
	b=yvcEnKu+ud/4YArHGF0gVE9ny+hcK1lkvw+XqS4t58g6STchgIGF8eb6+wKv/mV1l8G9
	 SsdBpFpc8K1Po2ktlp5FxH/2NMZCRavMr+wmpyeKoreLvE1iWhedPNNJZkeIOMxlxGryM
	 mdgxabCK0W/XgSVgRu7dXL+tvYasYb54YdPDO03ooyoe05a3vTHG7PzLduw6hvhNjnaLM
	 WvZGiE6vviwkvyu29JrcR13iP2hjds74R+jbvgP/InPpy3GzVT5hDDHPreKIORKS5IFuD
	 2703/Y9eZsiKNXgrW/77gcgssXwXzEmh/sbXL/F9SEkaumOfrotAqJ30PJdbkw/7wHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385634;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ONEeQ2vVVqIFiv9OWZJtBKE+yPwMBA+oc/DtB3fqHGs=;
	b=00YTZmlwog5cef71sqDGEctZI2qjlEB6hgk1XtFTv45ROnibediBx0BIn6UBpHzHpBw5
	 zA7y3K1ynqDmtc5EQq0APxWpp68yJ4RvzOP9FPLwLs0VoBHFXZwkX8qAsG4o3e1d7pSht
	 080XWZ/I98qVzOgkyANpTemiwHkk6kb8AX5RzMKRaz+CDcgKfnftd12SryL1Yx1TpiCL9
	 vePr26HEeMloaoH5FjcoUSHeHvP4v0FgoM11G3HrH2h3QxQiZkSs4b9oZmMDR+TjL59+G
	 5AtIml3sAY7mvpdNM9px9r8z7Xr5DL2wREfNPWNSiiL1i/9PJmt+WOThtk7Uw8yRpEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4GYmdGR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D365606A31A;
	Fri, 30 Oct 2026 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g4GYmdGR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621061F000C1;
	Fri, 30 Oct 2026 18:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793385633;
	bh=ONEeQ2vVVqIFiv9OWZJtBKE+yPwMBA+oc/DtB3fqHGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g4GYmdGRkrRa9rr1VZVy16lj8F7kgfSQFGNgoaP0NQc8yP5kbP70jPZxywO4Bg/c3
	 0bp9S6utH3XwVCus1FmdKTDHHkT7M2J+p1gz4z9VIYq0FySAg5uOA7blfLpVnroHsw
	 dMTSwwZ8t4TvmoCdyVFjPqRZzQFTImfBNZxdJlaAQPI92QNCJTSlsw9ej0jH1UrcK4
	 7WiWF3KyoSbtauBy+YUR6qKEssQewAcKArXpsE1aVOwltBrk02tK+XmfGiXBXMOHGa
	 jduXrrKsBNmKTPIZda8Q4l0FzrR/p2plS32rzVHPIcO3eTQ14qLS0q9S3ylYC74gig
	 +aNhTk9rZ129w==
Date: Fri, 30 Oct 2026 18:40:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Parshuram Thombare <pthombar@cadence.com>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 3/3] spi: cadence-xspi: add ACMD mode support
Message-ID: <20261030-register-coauthor-4de5eb324954@spud>
References: <20261029-xspi-cadence-add-acmd-v1-0-53cd44690e04@analog.com>
 <20261029-xspi-cadence-add-acmd-v1-3-53cd44690e04@analog.com>
 <179329269255.62540.11497211982924609522.b4-review@b4>
 <auRqTXctbxuuEfLL@nsa>
 <e9d40994-ef33-4f0c-9319-4efaef3d8711@sirena.org.uk>
 <auS-tFYUCIvMg-hH@nsa>
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
	protocol="application/pgp-signature"; boundary="A49ffsBr1vgzFZ1u"
Content-Disposition: inline
In-Reply-To: <auS-tFYUCIvMg-hH@nsa>

--A49ffsBr1vgzFZ1u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 04:00:46PM +0000, Nuno S=E1 wrote:
> On Fri, Oct 30, 2026 at 11:03:07AM +0000, Mark Brown wrote:
> > On Fri, Oct 30, 2026 at 10:16:00AM +0000, Nuno S=E1 wrote:
> > > On Thu, Oct 29, 2026 at 04:51:32PM +0000, Mark Brown wrote:
> >=20
> > > > We need some suspend/resume handling to invalidate the configuration
> > > > when the IP power goes so we set everything up again.  I'm not seei=
ng
> > > > anything here.
> >=20
> > > Yeah, I did saw sashiko complain (and my local LLM also raised it
> > > actually) but I do wonder how can that happen? So we need to assume t=
hat
> > > in suspend we might lose power (maybe because it's regulator powers d=
own)
> > > and need to do redo all the important initialization bits?
> >=20
> > Yes, might not even be regulators - some SoCs have good internal power
> > domains and can gate parts of themselves very effectively.
> >=20
> > > > > +	if (cdns_xspi_acmd_can_read(cdns_xspi, op))
> > > > > +		return 0;
> >=20
> > > > That function has a minimum size but not a maximum size...
> >=20
> > > > > +
> > > > >  	op->data.nbytes =3D clamp_val(op->data.nbytes, 0, cdns_xspi->sd=
masize);
> >=20
> > > > ...which we have here?
> >=20
> > > For ACMD, in theory we can just configure UINT32_MAX on the register =
so
> > > not sure if it makes sense to clamp to that?
> >=20
> > No, if that really is the limit it's fine.
> >=20
> > > Conor is pushing against the new bindings and that it should be infer=
red
> > > from the compatible. I tested this on [1] which is not an upstream
> > > platform so I wonder if it's ok to add support for the complete
> > > integration even if the SoC is not upstream?
> >=20
> > So long as it's an actual SoC that exists rather than some random FPGA
> > configuration or whatever upstreaming just the SPI driver is totally
> > fine, that's one less piece that needs doing whenever the rest of it is
> > handled.
>=20
> Nice! Then v2 will bring the work for the SoC integration! Yes, real
> SoC with two A55 cores and a shark DSP.

You gotta start somewhere, often that is clock drivers and that kind of
thing because that's what's needed for bare minimum bootable systems,
but if it's spi, that's fine too.

--A49ffsBr1vgzFZ1u
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauTknAAKCRB4tDGHoIJi
0pw6AQCXjgEUAx75vhUjxljYkfoZmeHx7ucvvi9fDXli4WmXBQD9F9udcW65GFzs
u1P926tHP3gmBS1JkpdeA9aHs6GqEwg=
=vU1b
-----END PGP SIGNATURE-----

--A49ffsBr1vgzFZ1u--
