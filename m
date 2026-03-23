Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B98A36D9EB;
	Mon, 23 Mar 2026 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774302575; cv=none; b=VoG9N2XahgA0mzAOk9YrI5RRDjMM6WXUR/1ImnBdoA8ZdLEafDgpFZioDiBWhnkQPM+/G5eeBt3jjtK37wLfcEsPhltTyyjr9FUVvo0UIcR8K/iLpxqJ+HhwsM3M1SHE7TvJG1jiPGjzc1UGWJaiBluP4YrX3CbL/NF4pWZ91yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774302575; c=relaxed/simple;
	bh=e2ZhSCx0wJsAx1emJeyO4FU08Tb6VMlBPPL5XXi0V+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPthi5v86+KEcLstoPVZBcpU4mdvOvQ87xWiYXUlRNdsremJ5KxImm6mO1muW+U8I8omUDO2GltWxUANxvRUN/tdSlNlekCrGEg1o/BanQ7UppxoVw2sTyvqbLTpl8DqeMOSwWn2/R788eQ/PBhvTE8a5Yp4SOrRLXnGExS6P5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXR3s6Ii; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXR3s6Ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E23DC4CEF7;
	Mon, 23 Mar 2026 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774302574;
	bh=e2ZhSCx0wJsAx1emJeyO4FU08Tb6VMlBPPL5XXi0V+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXR3s6Iie7Hp0vfWKYIxZqEwcifDLvFfeZtG7iRbEA0DhAy6OrFcIRNASgmDu1wES
	 zn4IB9ubKrtOy0wXus4wPsc0eBevTbJva1lSU9ESfklLjSd5pBNB1nV24Q36di4wYW
	 0lXP0/FiXiQNTgJjuefwj+TrVnsIet/iqOzKs3Iq+mE+Od+sUt35pv7eHj4n55e+gz
	 13fLIGiGQyk69OH0znKnUMNM0rDD9dbru0bdVoDvY3E2gfDe4vCze6n6yxC9kUGOMb
	 kSLEBVcMkyjMZKjC+Q98InaQDpdQcVNO4WZCXfb7pbVZYBqGq7rQw4g31sEWJnyczt
	 1LJaq/W2VhUWw==
Date: Mon, 23 Mar 2026 21:49:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Subject: Re: [PATCH v5 15/17] spi: uniphier: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <2f623083-5846-48d4-8c36-e55d663047c0@sirena.org.uk>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <bcfc4a5191976b2ada9cd4094b61ac67a0ea9da7.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y/Y2tr05pHZcxD/m"
Content-Disposition: inline
In-Reply-To: <bcfc4a5191976b2ada9cd4094b61ac67a0ea9da7.1773885292.git.xiaopei01@kylinos.cn>
X-Cookie: Advancement in position.


--Y/Y2tr05pHZcxD/m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 10:04:11AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for the clock. This removes the need for
> explicit clock enable and disable calls, as the managed API automatically
> handles clock disabling on device removal or probe failure.

This breaks an allmodconfig build:

/build/stage/linux/drivers/spi/spi-uniphier.c: In function =E2=80=98uniphie=
r_spi_remove=E2=80=99
:
/build/stage/linux/drivers/spi/spi-uniphier.c:773:35: error: unused variabl=
e =E2=80=98pr
iv=E2=80=99 [-Werror=3Dunused-variable]
  773 |         struct uniphier_spi_priv *priv =3D spi_controller_get_devda=
ta(host
);
      |                                   ^~~~

--Y/Y2tr05pHZcxD/m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBtWkACgkQJNaLcl1U
h9BGOQf+P4qqM5W2u6LtXeZ+RqwAf5bIlruWN7Zu6y+s0RsmbnL8SLo7ezN1P5XA
CaagW1s3A1znQ+f+UOmPpt7CUIM1lfu4JMWMQEq/cZthfywlxT0GzJCFxfwmIfXc
CIg28KtEajxKDNgRhc5AUvY+uPwX0bN3q2rUJ/kMcSeopHH61rIVinefkvqchzj3
FcC4NVtnG1cKpbV/hwswiKs7/f4NPM3PJs/PUgGtrqtvcaylsOcjEkL/tUQN5bHY
TupvhVwEX8LSCuTL2A0ihBwbZj1FWzwTqmb2nkc+zwDd0wOWosktdz/D4qYx04Ox
knJf2rx/baCD+1NxJPUJXi0GgY9dkg==
=IvRp
-----END PGP SIGNATURE-----

--Y/Y2tr05pHZcxD/m--
