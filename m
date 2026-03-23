Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33C3D5670;
	Mon, 23 Mar 2026 19:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295197; cv=none; b=nNWdIe5MKpK/1MyReKg6QO80iranpnYNAk1AbUkFoRu6est84Efwh8LiRrzfqweijUXqsnPupYqREhYZpkB6yk0kkop0S9v6fd5jgt74WcE/Iwr0d8ZLsLG6Jclk8akQ5vmz9A3Za8vL5ljFeQP2n3uefDdt64GKK8p2bBB7few=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295197; c=relaxed/simple;
	bh=/dmtorY8LlAopvLU37QPmGzNGM+3mvzFRJJMdAu2qDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/+j72qSJZhpfpe74/Zp0qaVgWoQla2d1Sgpgf1ZqPLiZ1w+P/tK/Z2DUlv35+mE3QZrt36py6+tpTHB6vsx2my1kpx5RW0tSb6Lid+t9+Dicf5SiK3Yex7qDJnmTskBS0PSK549ACSg6fITPYBN74nwCsmab0MoHsFicY4CsZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rShQHzbr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rShQHzbr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D6CC4CEF7;
	Mon, 23 Mar 2026 19:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774295197;
	bh=/dmtorY8LlAopvLU37QPmGzNGM+3mvzFRJJMdAu2qDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rShQHzbr+/e0vr8yznZXZLi0IadcEXyXmTC90VkLLCkDaKMyZV6XVtlDucYuLRq74
	 cw8in6D0nwJYmsWUzDM5DUNt7b7dv5ZP9BgpIbj55v3YyI9+xYELCUmp3kPYHs7x0C
	 00JUcr6l+IiGJ2xPxQM/T0R+R/AxSBcBKqUj20bwgr7zgL1F4QraMYx7OEzbxPleal
	 UhrfMUKHBGqXIXHQZtqkMmt/ioegcjIoDyE/8AluJ3QflhBk8vVAiE0QoMZKdFT6Y0
	 mUyw1ezBl/MjVbtx5ejQ3Exaog+afTr36miFzTZGTx45Rg10COYbaTuthczwezddX0
	 8h16B0dBoRPdQ==
Date: Mon, 23 Mar 2026 19:46:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Subject: Re: [PATCH v5 17/17] spi: zynqmp-gqspi: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <cc7f3fec-e314-4f46-8c62-75feb919b778@sirena.org.uk>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <611b4c4b67aaa8d86a7aeba9707ada47e6fd5dc3.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yXZTZfMj8/cYjg5u"
Content-Disposition: inline
In-Reply-To: <611b4c4b67aaa8d86a7aeba9707ada47e6fd5dc3.1773885292.git.xiaopei01@kylinos.cn>
X-Cookie: The only perfect science is hind-sight.


--yXZTZfMj8/cYjg5u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2026 at 10:04:13AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for both "pclk" and "ref_clk". This removes
> the need for explicit clock enable and disable calls, as the managed
> API automatically disables the clocks on device removal or probe
> failure.

Another runtime PM.

--yXZTZfMj8/cYjg5u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBmJcACgkQJNaLcl1U
h9Azogf/QlfWQKZIDTkEDnV1hRWkQlKZGgabUOpCAe5hOywhIwsKTsN0RsdWj4pu
gZ5CUwol9/peWzpl3LUtT438fl+Tj1jWbjNJWSBHy4o6uSnLSIedjHJuFrA5nBb7
Nw2JPIwe1Sxk3ooG6qCf1RLFclZHxcvjbAeTDIUbRmnA2ZeOMuDQ030AbISPi50p
TwkulHE1Mfd6zQ/Dtfv6azyFxBMfirgdLPblRWmXkYp9zgnDKfOxgy29A30V/0zb
NBeZSB5HZVYUCjuCMpe3hbq8MYLGL+d/khvAy8r/tnghN49BcXv9/LG798apXkXC
FKZxce5d98Cm2HnL8Suce3/z9c3sKA==
=quxv
-----END PGP SIGNATURE-----

--yXZTZfMj8/cYjg5u--
