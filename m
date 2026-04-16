Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE59128816;
	Thu, 16 Apr 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776343879; cv=none; b=Mb+sowLw+gczjXa5ZFODLJIGH4uUaUuvzst0rMY19spEsl2v9MJAI9zfTv0A6nANpZkoA+Ar4YPhudBPoKj4t96ZkIUDEK5sc9gxRZHUrpok0NaLeUwHIPJpjgnFMrx/qsTRPEOcaVzxm0jZSkbUnGCqK9DGLiTldGkCeIaDpXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776343879; c=relaxed/simple;
	bh=+PQXemKirOGMa0lPYrpvKX5hMnVKp06lE1LcH+8MnsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY7ujoKkLc9MU3tHUVk57hMJT5P53VqWRIPiOvA9/3VGT5FEmvViERjpN/9c1NofOmIRWEzyO05FAHYLiySa7Yhn8u1k3V/RDzpKr6otVB6JeJVGVgB5JDsPZr6QcW0Ni3yVXIAkrxOMpPNwMNHhm+ry6WY3qV2EAED52p6h4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUlFIcVM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUlFIcVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A110AC2BCAF;
	Thu, 16 Apr 2026 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776343879;
	bh=+PQXemKirOGMa0lPYrpvKX5hMnVKp06lE1LcH+8MnsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUlFIcVMBEcPip1jBLtVpq5MNgsLObBFw0L2PBZpDgex0XFmQniRbeaQOXsV6QXBf
	 DqOCIt5eiGA3W7UEjkQdwEYGnx0w0fipRM/EAbpDjaBNFtWBSnGpK4wT91++s+GV+S
	 H2l3MNCqyc3O2DtgH9A4SRTXQT+KT2AWI41aZMWttFyksxsP68piO5gqO2e6NUA6rp
	 q1pbmD0O7FbVd66F2UlN0nveUpm+KrFhcT/oRUaaYROn/xqU3A/3yAx1ajVEgao63W
	 k3tVBsXyrEkSIYSJ8fb+8xpHsqrV3X69fSOTbbR5EuCHtB/Xp+ZmcFjMphwT0wIPeH
	 +CwUUhVfikFaA==
Date: Thu, 16 Apr 2026 13:51:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] spi: mtk-snfi: fix memory leak in probe
Message-ID: <8e90522a-dc3e-4c1c-8e99-a5ded42f41c3@sirena.org.uk>
References: <20260416-mtk-snfi-v1-1-fafccfd288f9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oHlHqheTW9sO6E7d"
Content-Disposition: inline
In-Reply-To: <20260416-mtk-snfi-v1-1-fafccfd288f9@gmail.com>
X-Cookie: Process promptly.


--oHlHqheTW9sO6E7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 07:46:20PM +0800, Felix Gu wrote:

> ms->buf is allocated in mtk_snand_setup_pagefmt() but was not freed on
> the following error paths.

>  	ret =3D nand_ecc_register_on_host_hw_engine(&ms->ecc_eng);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register ecc engine.\n");
> -		goto release_ecc;
> +		goto free_buf;
>  	}
> =20
>  	ret =3D devm_add_action_or_reset(&pdev->dev, mtk_unregister_ecc_engine,
>  				       &ms->ecc_eng);
>  	if (ret) {
>  		dev_err_probe(&pdev->dev, ret, "failed to add ECC unregister action\n"=
);
> -		goto release_ecc;
> +		goto free_buf;
>  	}
> =20
>  	ctlr->num_chipselect =3D 1;

What about spi_register_controller() failures?

--oHlHqheTW9sO6E7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmng20IACgkQJNaLcl1U
h9DdSQf+MAq3yQ4oGs1FxoZSdE9aTKp9LHy2khH1lJV5TmNUGQ6K4/0ntXhV5tZS
dGbToS0cKNPPoxbeN+jqzjtWBlGq8Mau/InEjvmUaxS58GP2AwOqYJNY/WKVQ5m3
qDRcyjJm83Q9wjrs08i0JCAjiJ+eYe9K8gqPadTSjzlxlRILTpRegRKE/KnRz6n+
UVQ/sbw4YY56U+4Wtmh2sO2k66kJYagYckuuCdqJiZJSIwlA2/gcCdxQNfZpQWsS
N2h+EYSi8hmz6k8xP7S7R1kQoRqqRxMNslce2AsMJjT35PrO2y0PnrygKQSQRLoy
al1tHb4c3K/diJMDhCP5V/VsYneMMA==
=dxcD
-----END PGP SIGNATURE-----

--oHlHqheTW9sO6E7d--
