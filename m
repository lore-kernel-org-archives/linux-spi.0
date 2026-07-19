Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD92035F16B;
	Sun, 19 Jul 2026 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784501514; cv=none; b=M0s06KTR7P41iSCJBuJIZQuebl/4+xckexMV0xK4icuqy+Hr7OsCUU5VH2iySXOknT0SEUgJUp3EAjtK/KopFxIBnO/6/NIyeecQTeFyAGTUW673rJszrLUNOuETb2Qsy3uNrDGAFWy9wmmaiRZwxcmp+u/IJkLJhjqDnl96Tjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784501514; c=relaxed/simple;
	bh=PUQNF6+FTf0N1yi6MUmZ4eqktlUO82LhydpE70KjwUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd53wnqKY3wSP+eUd3GzHDdxwo/91jNl/YeU5+Z0fEniHruuZgBS+L4kjeCv15Mtpk5OBYj22ups9i7VUTnt4S4HEoTQtb5a9Yj/rV0UcKs3r3Bss5iRWzSx+gZvJZnkw2C1AU6vg8+dDgn2GVZ1yTSWqcxbTnP2khcB1NrX2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+BOhQTz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+BOhQTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878BC1F000E9;
	Sun, 19 Jul 2026 22:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784501513;
	bh=SYAxs/uEvNMipBIzz25KB7SrG+nl6kV7qdmvDJg3K7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U+BOhQTzLY4QXYYuFauUbCup67gfH8BdGSHDIqWDlP8jv0n5d0spE6mYBKN+5DwER
	 Loxtl45CusfNHRRgqc69yYfe5TI+YvhKvuUH1bbC96qrS4V8WBqzyyY0jWs1OnutGv
	 dEPFQj8JtOU1Q/8U+xdbQTZ+nOUazhKQa8zm4xIZ7iEYDzcvCfMpamk4YlriSAn8Fz
	 ZePi/nYJBoJCW2qWLwkaYuFThjPFL7CjHzBagygaOIjBXTc3B5oUYej3GsffzL6Xf8
	 8C2Y406ypK88xDopPJlB1I7zbrzaMyZ0heb3xik0L58/7PmeQM/coszU8sUiVC8fUw
	 ZosWgEgDjmLyA==
Date: Sun, 19 Jul 2026 23:51:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudip Mukherjee <sudip.mukherjee@sifive.com>,
	Serge Semin <fancer.lancer@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 02/11] spi: dw: update NDF while using enhanced spi
 mode
Message-ID: <ffb4b4ad-b928-4aa3-92ad-ce58ec0523d8@sirena.org.uk>
References: <20260709055204.138168-1-changhuang.liang@starfivetech.com>
 <20260709055204.138168-3-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M392BCOgnUspzv1Q"
Content-Disposition: inline
In-Reply-To: <20260709055204.138168-3-changhuang.liang@starfivetech.com>
X-Cookie: Courage is grace under pressure.


--M392BCOgnUspzv1Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:51:55PM -0700, Changhuang Liang wrote:

> +	else if (cfg->tmode =3D=3D DW_SPI_CTRLR0_TMOD_TO &&
> +		 dws->caps & DW_SPI_CAP_EMODE)
> +		dw_writel(dws, DW_SPI_CTRLR1, cfg->ndf);

This breaks the build:

/build/stage/linux/drivers/spi/spi-dw-core.c: In function =E2=80=98dw_spi_u=
pdate_config=E2=80=99:
/build/stage/linux/drivers/spi/spi-dw-core.c:352:30: error: =E2=80=98DW_SPI=
_CAP_EMODE=E2=80=99 undeclared (first use in this function); did you mean =
=E2=80=98DW_SPI_CAP_DFS32=E2=80=99?
  352 |                  dws->caps & DW_SPI_CAP_EMODE)
      |                              ^~~~~~~~~~~~~~~~
      |                              DW_SPI_CAP_DFS32

--M392BCOgnUspzv1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpdVQQACgkQJNaLcl1U
h9CnZAgAgxKBK5kYrbDDIM7pVd32wlfYK91V9B2zkN790Nxrf2vFf1QBnrGJFNhK
zIkAW/mJyLh4RxhTxVyhKv1u42BDsWXp89igGLyS2WMEt0GFmLiyspXfgHf+8ioo
182SbQdlgUveATfikH9eIAurUWs0u0QJaNia9M/w0x+28ja9n97sh+EcygaBFEWX
JQ3EPlq8I5lvKwKlgF3ByGi/DB5Nc7edevk2pzKzV4lVzNO5Of/Qk/RXWoL//30V
Q5pwcWlvilfPbHtz+PFcMsqo2CzCt/0UjSIihXIDnJQlsvVIdWo4HLbBdSv78SAI
ebjuhlwrxPguOeFRlknAWPKhrYp+CQ==
=hDEh
-----END PGP SIGNATURE-----

--M392BCOgnUspzv1Q--
