Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7722EB10;
	Mon, 27 Apr 2026 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333577; cv=none; b=hzgIRnlF2UI6UxpOjDrsE9rFBLBC+/f8XzAFuMBa+D5W88E1H4TLVwImQzldqr0+yxuytWI09zHO0utUuzktAkk90Nk6E6GlYYhmbJkLK+gsNkwdV3R0RU7f1LGuJJSRDt/Ws4UMwY+gJ9QjgMm6LsX7qGB1WVwiF9WqAzJsjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333577; c=relaxed/simple;
	bh=BgEV4tScGyGHrq38KvfpxGCI/GQPCZMnKeGZFjpJUd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2Kx2WTb7x1tx5mQrOgWKNXmyOKQHAkR+NQnOpZN+Fj8lAsIsNsT8fcnThQky7GAZ9hJuT+h1ufdUCxNm01purfDe8L/66Gdu7/4p6UyCKaCS7GVlpHE3QK16h7qmfVbiPA22HPO5twDg0JHn4PXsXnh2+PVpTYaL4SGYCa00DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgHifR4R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgHifR4R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19068C19425;
	Mon, 27 Apr 2026 23:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777333577;
	bh=BgEV4tScGyGHrq38KvfpxGCI/GQPCZMnKeGZFjpJUd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KgHifR4Rvnjqb9z7IthLInTB89y0CZToWtLA+msb2q5aVkuHPeTOXnSFMYRvMi/EH
	 t9ifFWo5zqWv/uI5PbkdFFR4Pg8ncKlclB//6j4sjcLOU0aCZym6aapU4EWmT9Vbon
	 Pq0Y7v5vUFpA4Hzneu96riKjms9HFOcha4GerbLH4pJUulK2vO25lFFL0f5eNHWN8X
	 utr6DqD4b714STNxJGPVmiXKCzlr0PEDwaO5ZBbX8z0EEYEF31iegkVGILNHUvuJ7l
	 koOyIwHFXWbP1li7lPwjghaxpKhxWOwkM228/dVEK7xQw40sZIkMWMHteQ2HipUl4h
	 YZ2bXdJy6eJZg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 123371AC583E; Tue, 28 Apr 2026 00:46:15 +0100 (BST)
Date: Tue, 28 Apr 2026 08:46:15 +0900
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>
Subject: Re: [PATCH 1/4] spi: spi-mem: Add a no_cs_assertion capability
Message-ID: <ae_1R6LlSnhgGzYl@sirena.co.uk>
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
 <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-1-0d626e1dfb2b@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gapjDoiyjve5Jhwd"
Content-Disposition: inline
In-Reply-To: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-1-0d626e1dfb2b@bootlin.com>
X-Cookie: Victory uber allies!


--gapjDoiyjve5Jhwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 05:47:15PM +0100, Miquel Raynal wrote:
> Some controllers are 'smart', and that's a problem.
>=20
> For instance, the Cadence quadspi controller is capable of deasserting
> the CS automatically whenever a too long period of time without any data
> to transfer elapses.

Reviewed-by: Mark Brown <broonie@kernel.org>

--gapjDoiyjve5Jhwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnv9UYACgkQJNaLcl1U
h9CxEQf+JTupzIZPpOC3vt2CLtwH52cHBtR+Q5PL1C2kVVBeAUK0PmcZm2BHp7xo
c44XrRhx384EXICy7h6poW/3D+NvFqoSreJKnVe+yyXs6U90L7KrjqpA69Oql1dm
6E+XDXd+iix4uE3jV30tYrtF74lDw8is37UxB7t2Vw5jrl4zbE6YYEPSXnikvFlz
B/IhxR4Z/yLBIoup3bDE2Ddr7zvqtpsTxHU56i5huQEiTy2QWq2sZ6HSdRSkkrAV
mNY0l5Gx91m+o3eDaNafPdNZ1UNBvYxVd7v7SbYbDzIpN/AAKHhzuepn3S0QJCc4
axs/msqQpRCbLkrRNOZowGPL0FZxjQ==
=PPcc
-----END PGP SIGNATURE-----

--gapjDoiyjve5Jhwd--
