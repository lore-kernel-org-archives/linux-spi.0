Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036EC405ACD;
	Fri, 27 Mar 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636156; cv=none; b=Azf3zWCGY0Nqn7BwP7IWYtSLAGnGq8rvI7QkaU7cT/g+E1rYdX3t7rx1G1gBpGbjiIoaysZk+lDgoN6LNR6mhmENo15RPe5PgDag5X+lDS1vrTFOAShWvZPTOjfOpm7hymr5BaICSsxluNfncsrAeUBQIFUNl00nRjmG2+qLT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636156; c=relaxed/simple;
	bh=NDz+90Jdc/SZ/butywbtcmFIT/1o0ws3FQ4pUfMYGYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAKXH77oxlxm0wj+SPPkoDb5bvimZNNfy+LiWeDuY/OXref6sFPI48DKpRUcvEG0Mc30m+ESxz1+ln5WLGu6ecHmrQfcM6EjaAZnAqetkCouo1BEUXd/uCCAfOGOt5eHbMFUyR+1YjcmA8j5CGuLTCsAwXeuHAEw46s9OLbNmrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHPyT+kj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHPyT+kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D08FC19423;
	Fri, 27 Mar 2026 18:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774636155;
	bh=NDz+90Jdc/SZ/butywbtcmFIT/1o0ws3FQ4pUfMYGYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BHPyT+kjT/MoUDsn1H/nBS8PzFXknynlJX4BJwAmL05eH+UehIMtE8XgSnxGF1aye
	 lzohE8oOGax4aKimmY9+Aa3Y36+0f/gH9mqXFC9yYtKZrMh3SjcGCqwAHiYSKXfFD+
	 scuIUxxlxuV8vLaWyjUFrE/7pkDEVrfJ84yAqk7pfEdCknPERVj12FfxAcgZxeC0Wh
	 7q29qqoB+uQrK4t+OO/n3xJPIqr43CkrmVQxcMN9kAz1rplYrFmWaTtvsJsFexZvNr
	 2+lCBxfXzDGXLxcJXW2J5kO8bQ2awmBTGm407Zfd4Xsqa73D9gT3jlmJvs1h12ADYa
	 6TUq3pAZFtM6g==
Date: Fri, 27 Mar 2026 18:29:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: broonie@kernel.org, kdasu.kdev@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: spi-mem: fallback to using transfers when CS
 gpios are used
Message-ID: <20260327-renewal-poking-7ae0f0345cb9@spud>
References: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
 <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ukxw8MLqOlid/7Pv"
Content-Disposition: inline
In-Reply-To: <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>


--Ukxw8MLqOlid/7Pv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2019 at 05:42:35PM +1300, Chris Packham wrote:
> Devices with chip selects driven via GPIO are not compatible with the
> spi-mem operations. Fallback to using standard spi transfers when the
> device is connected with a gpio CS.

Bitta necromancy, but why are they not compatible?
Couldn't you have just done an if/else in your driver to call
gpiod_set_value(spi_get_csgpiod())?

For some context, I've been trying to resolve some issues with using
the standard transfers code when used with flash devices in the
microchip-core-qspi driver, but if I delete this !mem->spi->cs_gpiod
check, and add the aforementioned if/else in my driver, the mem ops
work fine.

What am I missing that makes them incompatible?

Cheers,
Conor.

>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  drivers/spi/spi-mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index 9f0fa9f3116d..e5a46f0eb93b 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -286,7 +286,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct=
 spi_mem_op *op)
>  	if (!spi_mem_internal_supports_op(mem, op))
>  		return -ENOTSUPP;
> =20
> -	if (ctlr->mem_ops) {
> +	if (ctlr->mem_ops && !mem->spi->cs_gpiod) {
>  		ret =3D spi_mem_access_start(mem);
>  		if (ret)
>  			return ret;
> --=20
> 2.24.0
>=20

--Ukxw8MLqOlid/7Pv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacbMdwAKCRB4tDGHoIJi
0onEAQDei/TwO/HDQuUwMrnmMLgYKMLaeS9UaXuK3oVt1Y+/rgEAwJm7175oq4+g
hvN0W+nDpiXQRDO5vYRrdUDHVvEJvAo=
=to0R
-----END PGP SIGNATURE-----

--Ukxw8MLqOlid/7Pv--
