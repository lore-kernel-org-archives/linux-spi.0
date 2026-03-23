Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB93DA5D8;
	Mon, 23 Mar 2026 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295080; cv=none; b=D3/tOTnyox3gOyvc2BltmwD9voAqIPQWd44f8n3YLWI8gBYM6lSEXw14XlvwSJtQNySj9DVG6sIEG5nAp1FYzdp0rc2eSCbKSnpwNQt9/R+nSwBEUXbAZsymfMpnwImVd87KjxvUs3RyWEHJsnZ+2tcfFMopvY4/O39giv6zTNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295080; c=relaxed/simple;
	bh=EoWahn+aCaO4RgFt5H3ba598sk0yyiLlddVHssRrP6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njlkW9dMVFWc/0LhnazqeKmUKiqxS5pAE0qgn8NZ1MC269J44iBBQOAOUi77Yb8ETQTbQDpNYexZ/9QIxJyCzaFjTowPbun/J4cEoT36AX3l56z+7w6sREjj4HhWoRp1twxJTxGzDflM4sK4uHFPbxNH43O/7ak4MTRnuyVKl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJ462hZ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJ462hZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ECBC4CEF7;
	Mon, 23 Mar 2026 19:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774295080;
	bh=EoWahn+aCaO4RgFt5H3ba598sk0yyiLlddVHssRrP6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJ462hZ/iAigMKTQaYu+CB8zaJMOH/HxYZY6tSMKEOAD0CCRZV7NuPFohwAiDzZV4
	 s+vmj+k1xRLbPyum0J2ICSL8Hd2vR7PMUwgkDJM8AbFo0eHypKBNtUlkCRRyvlWMVu
	 p1UDx+HPa17fcaQDH8vwLNRGZEybH9dTod7CGrUHOWl3UVlEuGzE5H+NvQUYcQu2cn
	 YRfx4iQm+qIJNXMX2EKBEuJqASEbWeadUAdI6GgNSH9t9gJaEl9ePpUCpmRvVKTwhN
	 /3lHI0T6oz2KT0VuPzkGojHnQymA4qvCIJIwePvzBgOjw5TUvFASATfXaaDZAw2f++
	 cMEWIodaZK5CQ==
Date: Mon, 23 Mar 2026 19:44:35 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Subject: Re: [PATCH v5 12/17] spi: stm32-qspi: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <834e2939-93a4-4088-b6d2-6b15ab00ab04@sirena.org.uk>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <333b09950ee5c2fc0e560536281afb33f92288d1.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4FaSwlMKbUzxP7VW"
Content-Disposition: inline
In-Reply-To: <333b09950ee5c2fc0e560536281afb33f92288d1.1773885292.git.xiaopei01@kylinos.cn>
X-Cookie: The only perfect science is hind-sight.


--4FaSwlMKbUzxP7VW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2026 at 10:04:08AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for the clock. This removes the need for
> explicit clock enable and disable calls, as the managed API automatically
> handles clock disabling on device removal or probe failure.

More runtime PM.

--4FaSwlMKbUzxP7VW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBmCIACgkQJNaLcl1U
h9BlVAf/SqX2lKFh0WlwoopEAQeKZhC6ZHRqtyKh2/RgbK5AFMr9p/zvDbHhnb4m
QUJdF7K+dWgmYwaqer9oU4T2iOQ7nwvkHcaqYCX4qbMnUAtUWcSkiRuntlcB3npQ
Lc9CtCDNgixwYNjeY3tb2+kRpOSJMW6UGRCk7vdoobQgqT2nBYLx48DyjBgLUpCf
DzWTPa0ECdN9GU+lHoSR86OTRgSVe+DwuA0gOg104a0cJxs0gz8WiLnIXpmVvxj5
56XU5Dsc4MkWeuovuBtlEj/UXalFuNl0QK96f2BOn1EjIdBN8dFAt4Z6vxr6vdJk
sEKFbLoc9OFb65c2iz6ILeZ87zPRtw==
=SHbm
-----END PGP SIGNATURE-----

--4FaSwlMKbUzxP7VW--
