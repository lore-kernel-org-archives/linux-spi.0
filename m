Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB712556E;
	Sat, 16 May 2026 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778914094; cv=none; b=YItrsySJDfQmPk0cNpT+XqL2Yinp0f61jYMaDw6l9Iew1YiphpakBHa7yoYyGEJVB+KXXRrM5OSghT6CMjzeIVsvGyT8fxMLdD8mqOQ8+Q9JJk9vYDhofHgpTmsA+1aak8efinp57UC/5WqFpUcS4rfnoVM3nG9/CCmjjTmtURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778914094; c=relaxed/simple;
	bh=GedgFNpZxDjyfxm7p+3SPnpivi01eNWKEeMW2Z+cvjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKeeGLCx6voshlHwkXwao5WIA930zhhkvi5YyI3Jt1bZFzGNYQ6LrBQy6zAspbZI6HEv9/unJ5jDhpZ9kjjs3DTLcjkl4ApAZK++zxNJLpk9lPFbv700biaZCUYm3Hf/9llvt8VHkdf1VujuVO0lzvj4t3Y9LO55y+UmHH9YUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxlHmS2z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxlHmS2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4688C19425;
	Sat, 16 May 2026 06:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778914094;
	bh=GedgFNpZxDjyfxm7p+3SPnpivi01eNWKEeMW2Z+cvjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxlHmS2zZS1foJ2s/EjCdsoWOtbeJmUTIL1yjz+ciVOXXaZvoKINPTA1eQ8ue4J62
	 0nsp8LoRoxj1E2FyMMR0opDtx7QAip1dm1acWbczl37xiylAeo1E3vlKrYUewWcBk+
	 rvzNpKrQmSN6faib/l7LRYJ/2uL0Yg7Xuw7FT5336pUuBb7WFFdgFReZj5mfxq0aTS
	 obgnaU7PhtfyKpgmIJ1Px+bUU5VmCqk6R2WrOsyQjS9imfLOMXf3IVZmVPRCVv671S
	 jwl417N+fsrQvuYxlXdTsQ+sFp5ccKlSLyhGk5FNYhCFHdmcRSsIMc+zYUGqP5B1Z7
	 kO1nUJL2WY6lg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 5F1591AC5A48; Sat, 16 May 2026 07:48:10 +0100 (BST)
Date: Sat, 16 May 2026 07:48:10 +0100
From: Mark Brown <broonie@kernel.org>
To: ChaoHuang <958028483@qq.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chao Huang <huangchao@kylinos.cn>
Subject: Re: [PATCH] spi: Add spi_for_each_controller() helper
Message-ID: <aggTKly_pVAYLVRt@sirena.co.uk>
References: <tencent_4C5A0FCF387BDB37C5512E5D709FD557F106@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MVFD/jB+uulWrAl6"
Content-Disposition: inline
In-Reply-To: <tencent_4C5A0FCF387BDB37C5512E5D709FD557F106@qq.com>
X-Cookie: Truckers welcome.


--MVFD/jB+uulWrAl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 04:45:44PM +0800, ChaoHuang wrote:
> From: Chao Huang <huangchao@kylinos.cn>
>=20
> Add a new helper function to iterate over all SPI controllers.
> This provides a convenient way for SPI core code and drivers
> to perform operations on all registered controllers.

> This helper is useful for scenarios like statistics gathering,
> configuration updates, or debugging operations that need to
> process all SPI controllers in the system.

Do you have an actual user for this or is this just purely theoretical
at this point?  It'd make a lot more sense to add this along with a
user.

> +int spi_for_each_controller(int (*fn)(struct spi_controller *, void *), =
void *data)
> +{
> +	struct spi_controller *ctlr;
> +	int ret =3D 0;
> +
> +	mutex_lock(&board_lock);
> +	list_for_each_entry(ctlr, &spi_controller_list, list) {
> +		ret =3D fn(ctlr, data);

When unregistering controllers we do start the teardown process before
we pull the device off the controller list, and drop the lock while
doing so.  That's probably fine for a lot of uses.

There's also some obvious potential for things to go wrong here with
something in the callback deadlocking, though that's a bit of a "don't
do that kind of thing".

> +		if (ret)
> +			break;
> +	}
> +	mutex_unlock(&board_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(spi_for_each_controller);
> +
>  static int __init spi_init(void)
>  {
>  	int	status;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 79513f5941cc..8fcf3faf9739 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -934,6 +934,8 @@ static inline int acpi_spi_count_resources(struct acp=
i_device *adev)
>  }
>  #endif
> =20
> +int spi_for_each_controller(int (*fn)(struct spi_controller *, void *), =
void *data);
> +
>  /*
>   * SPI resource management while processing a SPI message
>   */
> --=20
> 2.25.1
>=20

--MVFD/jB+uulWrAl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoIEykACgkQJNaLcl1U
h9DBswf+NXtwwHmUqp285/+Ad7jl8WhZETQsAiY97UCMHOLv6kr74gULoyEi4C+l
mWLfZseGV5JpGYT9MwPrypprn46Bcht+97+pEmxPzUavQ3DhTTt5FLhjdvB/RUyE
IuHs+2nXXTw3CSAKuErGVfK5XXdYLBhj34sdUoJYLoFLhVusbU8NI/KANKVvCAC1
/OGuLMXAcMf+cixXbZWj9lDOXOflydC7DDNgb/QXmvCHN6BaqwlyLHCD8d/os6dE
xnOuDUykfqIv6p+HUH17TXeIkcnDQei8F7CwRwvUY+3MJLaX129lbKApAAa12BQ7
NVAaZ1Q7x9KuD96ReDoy5d37qUWITg==
=IM8R
-----END PGP SIGNATURE-----

--MVFD/jB+uulWrAl6--
