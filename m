Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D664014A3;
	Mon,  2 Mar 2026 13:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458346; cv=none; b=oi6Pbwu+npXtZthIQQpJoUq+9vfl9k+ecIxTDkTLM4wYUkeFfAmRzydFrhlejQYEMhl34lk5ewvycvn0bTyQnnMyujkKtIjEdoIQihzyW/2FwnBeugNPMj9t7ynGLzqj8TuX6O00Kzz+lzqfMJ+fqkUv2IDuyxCxIz3QwvFE78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458346; c=relaxed/simple;
	bh=F8Xw8lWDT/yc2wnHXHmLX3Wm4Jj163DI6NFS3w0OUI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cawvR+o5IL4syRtKvzLqUfMb9lvIXmNf8bMeq0/diVBG+z+kldCZNsVfGp6g1wWCchGfZuGTsWEC5viuMfr6vhY+9M4qWmS9q9UCqlUyAgjKPwvz4tNvP7mh5u4ZNXkKx5jzonpgM4v+3l7mRtOYoGOQm+OAoTPMCVcZN2nObRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3hDWFHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3hDWFHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2376C2BCB2;
	Mon,  2 Mar 2026 13:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772458345;
	bh=F8Xw8lWDT/yc2wnHXHmLX3Wm4Jj163DI6NFS3w0OUI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3hDWFHn4CzfYrzHJ93HteExyHF8rvHwNWYj7WEjNiFe5E1zk+4V7uUoj0osGkM5v
	 rs1CRdShOtQYU8blbVCVOlgP2JD63V9vHV83d6vY1HKemOa6rmIUnn+z5qTiF1KwvF
	 yDWUCj+c74npOGpyyAAbHVBmFkvghh3kHqy7rlTRpUFWUXnzpcA2+qYs2pMW3gZPxT
	 a6i5vmUBpwo+f2gcZWqWEDi1TA624ZB/vCQBv2k/8+umTLvwYbag+gd8A6dAkMuZQJ
	 YQB4Lxg9Sp4GcvyqXm0F6O7uhg2itMlQBE7EVTpyjdXjcAMdUHMmMQtEYx12UEP4+t
	 ifh0v//nPcsmA==
Date: Mon, 2 Mar 2026 13:32:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Vladimir Yakovlev <vovchkir@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-dw-dma: fix print error log when wait finish
 transaction
Message-ID: <28070766-b06f-4036-9c70-2e8b80810299@sirena.org.uk>
References: <20260302113233.773414-1-vovchkir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ed4b5Xff5i/fGoWZ"
Content-Disposition: inline
In-Reply-To: <20260302113233.773414-1-vovchkir@gmail.com>
X-Cookie: You love peace.


--Ed4b5Xff5i/fGoWZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 02:32:33PM +0300, Vladimir Yakovlev wrote:
> If an error occurs, the device may not have a current message. In this
> case, the system will crash.
>=20
> In this case, it's better to use dev from the struct host.

Are you sure:

/build/stage/linux/drivers/spi/spi-dw-dma.c: In function =E2=80=98dw_spi_dm=
a_wait=E2=80=99:
/build/stage/linux/drivers/spi/spi-dw-dma.c:274:29: error: =E2=80=98struct =
dw_spi=E2=80=99 has no member named =E2=80=98host=E2=80=99
  274 |                 dev_err(&dws->host->dev,
      |                             ^~
/build/stage/linux/include/linux/dev_printk.h:110:25: note: in definition o=
f macro =E2=80=98dev_printk_index_wrap=E2=80=99
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                         ^~~
/build/stage/linux/drivers/spi/spi-dw-dma.c:274:17: note: in expansion of m=
acro =E2=80=98dev_err=E2=80=99
  274 |                 dev_err(&dws->host->dev,
      |                 ^~~~~~~


--Ed4b5Xff5i/fGoWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmlkWUACgkQJNaLcl1U
h9BHaAf9GGanqq5hHMB9v0IzN1MbU2n/16hFE9jJzUIE14YwHo6AjYsOnjsbDH6R
/2riUGpileS7rFEWgr888MTMn2DEVgXbkPGCXO9QZZXAldZ021T52DygW4WRs1Yn
NjE3VjrrWv4d92rwZiPF0YIv7tIzNHwNZqzNzJw6kDZEgDqrKlomUndP98eCd6x6
dxoVljt7wtUL868Grm3lFY9JvdU2h2MjwTCfwSJU8L20+3m54tWD37TG4CpBBGHV
3CaxjcbAfGqYCavNqj4JJg9u9gAn0DuHkxAYxhIm8ljsO7V8qCmMZCsP9NP/U2bM
mr9WkXCQf1kZQ1U4GmI+M+Shq9SiAw==
=3xZk
-----END PGP SIGNATURE-----

--Ed4b5Xff5i/fGoWZ--
