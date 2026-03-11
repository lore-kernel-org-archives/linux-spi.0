Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A023D8911;
	Wed, 11 Mar 2026 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773227772; cv=none; b=ifIQ9ie3fsiXm0VtUDHdtjR3sG1Nk07/l6PkStiu8mXc7PMrEuP4YYKVGYF7m8ZItYGIKFQka9js0O0JeaHf0QcTOPX3PqZgCDL1ofkWvMsuERXSjfzlJXyQj0RhbHuMCkusfmkf2zHtiJTF3o04x9RfwhVVP/X8e944hIINb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773227772; c=relaxed/simple;
	bh=LcdH+f32Lg5w/PsCorEgrvYmJBQc97XGVk1z9DoVgH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUZEQbV58gYL5JBGe/camJNpMgRLkuAjBheaPHhJefjrg9feDNAXrsemKFdXlvXEFXL7n71dCQC8Azlji4gOtzps4E5VI8K4R/LZ+8axmJeEVZecViJ8HNDFRCC3cOh7MKLtLdxa7CL/3qvZu6Ni+oAn7OvxWYk/PQMzoMuf28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCoLPKCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCoLPKCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1854BC4CEF7;
	Wed, 11 Mar 2026 11:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773227771;
	bh=LcdH+f32Lg5w/PsCorEgrvYmJBQc97XGVk1z9DoVgH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCoLPKCoa775A4h3uohj5ZnHFMSKG6vUdmpgONxGJotN+98dB30usgPtjRJwFAQ2P
	 ZvQSzYq1kXslknTq6EN+ZPOVuDZ7Es2O+Olr5ErQsnWiNHGczQ30vrUlmuaUdMsBcx
	 03cg7/OCtlzoT9yXEWmNJfft0Ym1L+pg3cpkcePOK1vuI5JocPK+jH/7dViGAbPk2G
	 BXfnrzWsUqT3VvpgSSmk8DIhaii71Tyd4aq6TvTvrpo8Yu461j1ZvyvGyQ+dIRI5pg
	 kuGHlgxPMf0P4wfh+yrvXHTIua9uaNyK2dgOHMZ3YuF08dfeagR6hHEwBItAE8YiYS
	 9z1jLg8DuVvnw==
Date: Wed, 11 Mar 2026 11:16:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, Max Krummenacher <max.oss.09@gmail.com>
Subject: Re: SPI loopback tests
Message-ID: <8ba0f016-85ed-4c65-8020-04e39c222ea8@sirena.org.uk>
References: <20260310133254.GA51497@francesco-nb>
 <09f06ce4-0405-442b-bf3d-5722a6977a4d@sirena.org.uk>
 <20260310-marlin-untoasted-ecca1e3e80e8@spud>
 <f35c50cc-741c-407d-97e5-81c62fcc15e7@sirena.org.uk>
 <20260311-passably-pampered-314ea21b9f1f@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ksP5OcGlZ2eA4fES"
Content-Disposition: inline
In-Reply-To: <20260311-passably-pampered-314ea21b9f1f@spud>
X-Cookie: When all else fails, EAT!!!


--ksP5OcGlZ2eA4fES
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 11, 2026 at 10:10:56AM +0000, Conor Dooley wrote:
> On Tue, Mar 10, 2026 at 06:26:45PM +0000, Mark Brown wrote:
> > On Tue, Mar 10, 2026 at 06:12:38PM +0000, Conor Dooley wrote:

> > > Not sure that there should be a "linux," vendor prefix though, there's
> > > nothing linux-specific about doing loopback. Probably should be
> > > vendor-less?

> > I think at this point it's old enough that it's just ABI and adding the
> > option of having it vendorless would just cause people to ask why.

> I'm not sure what you mean by "it's old enough", as this proposed loopback
> compatible is new, right? Don't think this is any different to i2c-mux
> or regulator-fixed etc etc. Unless you thought that I was saying that
> "spidev" should be a compatible? Definitely was not suggesting that!

It sounded like you were suggesting using spidev, yes.

--ksP5OcGlZ2eA4fES
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmxTvYACgkQJNaLcl1U
h9B7Qwf/b5ntqmlBNpiFjIfTpGtnKJOqqNsjnJW3rfmpXVDL/nb8JT9LBs+7q6XS
BOV1oxsM/DvjZk7NeIpVQSjs/JCcJxTdYXE/8AVOZMsEYfvW1yPD+OhcgOwx7ylf
z8jlp+1yg8iy43QfqLXfhRavzhT1oJdpJ386hBDLcj1ZPA0sblvIgubSNcHG7UH2
SOCS27I+b5mdyWhdbgCNDK4NEVZZGDdnRS+R/4iPMsPKrlnoHMMRpK3mKUg2qT+Z
7FQI+LQKA3v6dcJUMPYagbiGHK62nhhimGIqyM86hgLyj9KNiLF7iYN9ztm02g3w
vFeKe+lDNUDgAuC7HF0qclyPs4g9vw==
=z3PB
-----END PGP SIGNATURE-----

--ksP5OcGlZ2eA4fES--
