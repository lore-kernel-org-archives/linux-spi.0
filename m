Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02B387357;
	Mon, 23 Mar 2026 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289449; cv=none; b=X4CmF3ZpsYxazQUvPfB5vOimMcgWDmcxGhTTfjw3UNHJPHMoEsj7cPmWxfrerV9O5k8Njc8KwEtLUw4p5WrktAsEMypqsncGg/p5tHaGBAVecu4uxTjl+SaAyc4Bwnia4ic0PMqZr3qXkb3Yx00KAZD2U3Q4Xl3kgkWp25iQzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289449; c=relaxed/simple;
	bh=iVvTcdKll6gMBptqBQmi6VsqODBKiqmmTsTaVZJIq/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGUnO0s3l1DZDhBJPfeOG+HthneBOSBjPAvcZE+kr8sC3tI7JTWwA3mJAvlTGSGiiXqHOHL/bK+F57gDOSPJ14E91CnMxipUcvr/TdTBXSe1SubZz34VI2mTeCm82Pgzmb8ZSbazzcyMwM30gq+OMDBTo32vYV5pGSgQP19zlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw6D/G+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw6D/G+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B69DC4CEF7;
	Mon, 23 Mar 2026 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774289448;
	bh=iVvTcdKll6gMBptqBQmi6VsqODBKiqmmTsTaVZJIq/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uw6D/G+gitcATb6T5R2/KenbIfxV3Aj+UM3cql2sI3weUahY2d2pIeS6N83j+I2ji
	 zSJXp8Eovcfwe4k4zdUhK1foE2qFa7Y3VvYpa0lZdAIBnOzgQIfnaHIlN/aQKS4iSV
	 Y5pyxyzT2tLw906EBvx4d4kvEwRy1EzivQfBX77tXyLxIeHWZCyHx/55CcvUL+fBMq
	 HmtLajqr8dni9WQei7UM5bALLx/5QohGHu+sT/pUmDPIq6AZzRpYiq+FDS6+9d5MB1
	 XntvHcDWxSQLlvyxa7d1GLw2HK3IYe4PmTSDrKrCIQx5Bm5E1jNvryB9k2WHghI2/d
	 eGdd/ZrAz4YaQ==
Date: Mon, 23 Mar 2026 18:10:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: linusw@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: Re: [PATCH] spi: pl022: update outdated references to
 pump_transfers()
Message-ID: <ef33990e-fb6c-4bb2-b8d0-4ca5b31c8722@sirena.org.uk>
References: <20260321105940.8143-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4wW3C1gq+wpyJQ64"
Content-Disposition: inline
In-Reply-To: <20260321105940.8143-1-kexinsun@smail.nju.edu.cn>
X-Cookie: Money is its own reward.


--4wW3C1gq+wpyJQ64
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 06:59:40PM +0800, Kexin Sun wrote:
> The pump_transfers tasklet was removed when the driver
> switched to the SPI core message processing loop in commit
> 9b2ef250b31d ("spi: spl022: switch to use default
> spi_transfer_one_message()").  The kdoc of
> pl022_interrupt_handler() still describes the old flow: scheduling
> the pump_transfers tasklet, calling giveback(), and flagging
> STATE_ERROR =E2=80=94 none of which exist in the current code.  Rewrite

Separate issue but STATE_ still do exist in the code, just unreferenced.

--4wW3C1gq+wpyJQ64
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBgiMACgkQJNaLcl1U
h9AdOAf/Z3F5/GiYsrPnhwQny9JtH1UJbMnqe7bgTXcfR7pIi7sO8i3pGbj7l2Mw
kCMqgq+4G1iSp/1PrOE1uZLjP3cLD/FneQHgKQ6tQkCNMn39HkgkEmAKuRg0T3/d
DkoVrt/sCEpFV2JoTjUAnWRx/S+ALxQSV5BU+5bA9W3T144f23rAfjgiV882cN55
pIdVv8r4JgyRMJUIaSNWRwnlmRAZ8aLfjXzLJbh2IoSX89VSz5xSW3Y8i0ZOPZ1S
i6NUUjvzbkHnwzUqMDBeWBCzLXu8hzhuj6POZ1dttCN71KfgwiFatk9pW2bVyVSh
VaGgQ/2vS5ijHkmXpuWFF+B/8B6cQQ==
=mECC
-----END PGP SIGNATURE-----

--4wW3C1gq+wpyJQ64--
