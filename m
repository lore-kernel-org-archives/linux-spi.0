Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193960;
	b=1wTKz9WJzqQU/2OlulAqVvHE4BsML8oSkYz3hJBV3Mt4pK+f3CAB8JuKs74HtuPYnQXI
	 qSkZHejtMkii8tuzjSzDQRwiZcS3nobub7rn3rjBLO89m1yhnKlx6cKMh0utH4l2YMNMp
	 8TT8AaWjKg9K2pZy4EsEAmMqUE4oy+fB1tzeH9Vg2dcTpVtWr2BoAP4hpNct9yvCFii7c
	 FpjDoNzB+WyfHNYURO5+GSgtSwcr04KKiDXB0Q5gGyVWMauBYswcn0LknelLV0214UGYA
	 vYPqkoNjycDV/V1HFL9pioUyQoSapHp8oRjCrNoRpoaxPPqLpbulLcnDWHjYzhgL19Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193960;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=07idZJgHA8uGkBFoT2EY4Wk6RmCDQXk80GkxlixdxRE=;
	b=ENqsmQZ+Mb+6+rxuK/1kqqgjkMVYnZJek4ehQ/9ELEu1fXUF/jrcuPTcFweGO4IjAsU1
	 2lA1qS8wCMhgh8rg9VkhO0tnHkgcS5O1ijDzpEY8JEQLQkBeNN9WA/i6JbXa5VXOHH8Mn
	 4xYHsEYytQOEgEq+FKuML1+E0jET3P03P6XIUtK8VoIApykxWov6drH5NAE7GK5noaImw
	 IxDrHzwMh94Vehy+waZF6DzsVRmk/rfrafqdBKlcXzK18755rhPfNBmhiYWTnlqx0eeGA
	 8sbI5B3PoQIrhPTEDpxTSHfpy6E+qU7jbn30//eoWI/AIWjp4CiBIUcDTAu7X2Vf8tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nppO/gcd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54457606A31C;
	Wed, 28 Oct 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nppO/gcd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD401F01828;
	Wed, 28 Oct 2026 13:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793193959;
	bh=07idZJgHA8uGkBFoT2EY4Wk6RmCDQXk80GkxlixdxRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nppO/gcd6xWYQXFDxz8DEnJhSOFHakV0ohSMCaHKPQhwUktD8EkRfAoe0/xCMQL2r
	 g+m3CgndCd0A+VHCwwAZojXot+MOxkUwQxtr854YUZWOv5rUmxw0PiDJzK4xQUuFpS
	 rqXwkbhE2wmULWjH32d3+s2mGCgONUzQ8d3Foq5Ikxb+Jb4BHejHjSfZCUmz8Dr0j+
	 kmHFP+jwQ7LBgpdcfRrlwccJKw4smcpRmyjYDrLr3fCPZrYEdEjjAl9hUouH01HM/x
	 TF+Bp+DkTY7q2IJ/th5UW0OjH++g5Ifl+IUIMS6/efUnYbcJ/9oBE6dgRslSQbC9We
	 UwPlcddN9cylA==
Date: Wed, 28 Oct 2026 13:25:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Tanmay Jagdale <tanmay@marvell.com>
Subject: Re: [PATCH v4 0/7] spi: Add support for panic mem writes
Message-ID: <8c8cf14d-954f-4b33-a0e7-8524b1596845@sirena.org.uk>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
 <fdc79c99e3045635841f68c89fec3b9d9e2f7233.camel@bootlin.com>
 <8979e4ad-5209-4fb0-bd3e-95919849d2fa@sirena.org.uk>
 <cf96edf1cba37b775817d4df5f759b10e71c73da.camel@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="qTajYpijgV2rIxUN"
Content-Disposition: inline
In-Reply-To: <cf96edf1cba37b775817d4df5f759b10e71c73da.camel@bootlin.com>
X-Cookie: Pushing 30 is exercise enough.


--qTajYpijgV2rIxUN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 02:15:00PM +0100, Paul Cercueil wrote:
> Le mercredi 28 octobre 2026 =E0 12:59 +0000, Mark Brown a =E9crit=A0:
> > On Wed, Oct 28, 2026 at 11:42:33AM +0100, Paul Cercueil wrote:

> > > @Mark, do you want me to wait for -rc1 to send it to you?

> > Please resend any new feature work after -rc1.=A0 Please also do not
> > misspell my name.

> Your name is not Mark? Or where did I misspell it?

You added a random @ to it.

--qTajYpijgV2rIxUN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrh9+EACgkQJNaLcl1U
h9Ah9Af8DU/4M1KJdCrU+Dz5CzHQbXvivhJykrHffBFOH1qgQqVMX/A5/d2PDLN1
4P+w1qmsAqME5pCxkWqjBn6YTUK35AnxidI2AfBX8eb8jXiN+iM21yg3I+CziV3+
bidjhZIXoKFGv4WcvTI0PnFevebRVg5nOj5fTEYDP9lYrPCl8Qp6IsqzRV+6Gj08
bmrwdS8+EnPtI1Izw0M1yzkAAbJOAkbugQTyiFvH3Bany84B/8HTT8h4i3bKNhCK
oZnu11AZJbQY0a7gr4YwrjuFWsCslmmqLmIdKvrTetBy5wZOUeBlNjPnHJ22FAQC
8BG6qRtmuqZMKX0/bj9nbyJ/P1rtFA==
=Kn4k
-----END PGP SIGNATURE-----

--qTajYpijgV2rIxUN--
