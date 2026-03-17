Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5137FF43;
	Tue, 17 Mar 2026 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753593; cv=none; b=j1FHkzJBPZ8NMShfCaXcyd0KrFEW87gvavqS31T33kyM9rKW4tNlEkHbMm44Mg/9hteoNqiPIqR8w5O3YxHpVjMBuCk/+5kZrLVOIMc6ZhqRwVbneC3+3j3lEILlZCIq9l4DsGOJ9TIlmsL58sFM0cBPtzT4pMNzGEY8BO4fOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753593; c=relaxed/simple;
	bh=17QQxtRUtaf7KEtmNuQbCZyqj8LsLetQhwKYrcsm9Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ldm80Fjpzm4Qm3/iH+YQFSg746VZMMl5+V/bcrJUQMumRq9GJ+Y8f6mxhVjdfwRZ/Jg6Vue6WfcamhNEXGfAxrxnbs7x739INsELK+b6SFK56G4rO9IqtK+hfy8ihw2ZeyBqkPQvl4J9Q7Ju3E32emrc769T2tF2UVmWvEYBGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryqgogP1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryqgogP1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61E9C4CEF7;
	Tue, 17 Mar 2026 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773753593;
	bh=17QQxtRUtaf7KEtmNuQbCZyqj8LsLetQhwKYrcsm9Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryqgogP1Js25YVHvobHnOKBl5MYdxOSD2aOiI1tf6rJQER5WihsK9Uq3jfo6Qlf2b
	 BtONs2A6D54IA4DNEv1Sy0CY6z9gO4p20SThPPkHcwNdCWn5jr22BFpMDOYrAoLSbq
	 sgZTC8u9xZQu4B/IWVM/GrLwf4dd+exti7RlPqEl4f4czsv51D3od0djhhjvtRmmTC
	 WYdwB8SCN+QNUbefFUPZOXTmnR7msjPL2f9KXr88ikHvO9/N48Zi3PI1IevuuXxGuW
	 Jg7rPyI7R0lNjmB0khjEhzaAAgXytb9Tc7RPeU0j3kdsOWVHghNIyu8gn0Kf3R8YE6
	 65mGvnUDWFheQ==
Date: Tue, 17 Mar 2026 13:19:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 01/17] spi: axiado: Use helper function
 devm_clk_get_enabled()
Message-ID: <00540689-fbc5-49cf-b185-5af372f7ef0d@sirena.org.uk>
References: <cover.1773733017.git.xiaopei01@kylinos.cn>
 <a78f25f1b15b90121e9723ecb5bd606bbb1868d4.1773733017.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8+YRHFs8YF4SBCDe"
Content-Disposition: inline
In-Reply-To: <a78f25f1b15b90121e9723ecb5bd606bbb1868d4.1773733017.git.xiaopei01@kylinos.cn>
X-Cookie: Must be over 18.


--8+YRHFs8YF4SBCDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2026 at 03:41:43PM +0800, Pei Xiao wrote:
> devm_clk_get() and clk_prepare_enable() can now be replaced by
> devm_clk_get_enabled() when driver enables the clocks. Moreover, it is no
> longer necessary to unprepare and disable the clocks explicitly.
> Simplify code.

This doens't apply against current code, please check and resend.

--8+YRHFs8YF4SBCDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmm5VPQACgkQJNaLcl1U
h9BDXgf9F2bMcNxWFiGlImGG2lAZ6+rhIz0gb1xd8L/zXFcj49GbT66gTFF+vs6Z
nJhYnwuUnf46hnhc583pZ39MeS/psE2kjIaTNiGva4NLDwWkiYkn79oJk9zepDF0
9HRb3mjyaDDPQtfCgnrkTb2VZObD/41CWBtZ8x5JxjFwHkIG776RlhYJUU2y2myN
oAvCWPJddLcAOZapamPyu/LZvMwFfhWgP4mAr81G/th9dO45ELAiKqMj33zN4VzV
yJ4r0AY9ZSXuW+NmdztaukKEKWwKGDeT5I3vRWqSJ2EvkvODgAw209d76768VQ+G
JJtidlXADpZe7vD4DCReLGZERU0QQw==
=AabK
-----END PGP SIGNATURE-----

--8+YRHFs8YF4SBCDe--
