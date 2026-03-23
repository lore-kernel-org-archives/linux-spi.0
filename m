Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA93CEB96;
	Mon, 23 Mar 2026 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294955; cv=none; b=pRnlaK27xfIZDQ1aYQ9Mi69Ln12UCTGa94y7J4SIjXg7OwgsgdlesHPL7PfWDOPvlo3l71i4L6O5ayfVVBsfCuhcx5j/lk+hwEFQN0m+YB9Z0hUUWVzmmkgPyzNnmuASMUNHkSe81RM1jnzChF6IH55UKaRIfK6tz5V3lZjN8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294955; c=relaxed/simple;
	bh=11j9z/1fJKiQVdJE20P4e+j+9ToUEls87BE6rvgPEnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uslRsHwRRQVg3nn0gInZESelo4Uoa/GkWO54zDNEcJV4FThDiI+uiJEKVvWZCVDyiSdeB9gLSPbw8iAODTN7RR3A6RL+7NKL91ARPsZ6W/myeI/cx2jgn0Hgk7neZuYSqEDvSjuGbniEDmF+1f47OPw5TZInzFD/I4u75o+mn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgPX3A5w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgPX3A5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167B4C4CEF7;
	Mon, 23 Mar 2026 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294955;
	bh=11j9z/1fJKiQVdJE20P4e+j+9ToUEls87BE6rvgPEnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgPX3A5wg1iUr/7tQS9xp5e6w0B25P8zSkCFksilaSdtWF0zDITP+MM+ylpxRhqqN
	 z1RrpGJ0rkK+G2tQr65a2/Xwv7EiFqD6PuLMWp6NIgNgWPZTiDGxPpc7mIWDXI+lVj
	 WazCdp1gkd01GY8XHb75ph0A9LOKxkfuKGbvWtCEABYmHzURaMEXJmTzb8e3FF9HZm
	 Yd94MYFdCPEkY0FJN62BvsxE7q/dbpPH7fE+CcgiWdhHVGeKHch8avzFVVHAHBzTai
	 26KyXPjH454gkbq++sACIjU4amKyHo63ZwM2pIugLnvvDU+/lf1hAcY1Y2JEWVzJnR
	 x0lY5DPsSmnIQ==
Date: Mon, 23 Mar 2026 19:42:30 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Subject: Re: [PATCH v5 07/17] spi: orion: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <7e9fc388-cdc3-4810-9136-9a1f33fed7f7@sirena.org.uk>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <387f2fa1b3e1a356c524bb36eab07e1b431b6382.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ETAL/F05848nVpj1"
Content-Disposition: inline
In-Reply-To: <387f2fa1b3e1a356c524bb36eab07e1b431b6382.1773885292.git.xiaopei01@kylinos.cn>
X-Cookie: The only perfect science is hind-sight.


--ETAL/F05848nVpj1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2026 at 10:04:03AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for the "axi" clock. This reduces
> boilerplate code and error handling, as the managed API automatically
> disables the clock when the device is removed or if probe fails.

Another runtime PM clock managment one.

--ETAL/F05848nVpj1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBl6UACgkQJNaLcl1U
h9BT8Qf/dtJjSArsGgU+y0yVED55+m8067SuMbN7WPDUHaKFWCm0BD0AB2I7w1wo
Q2eV7b7mCT9le7uw8d9NPBabofnVmISnVSpguFgRIG7YVtcz6uVBHSV78j6gcMvk
kruWd2xH7oETY56WXrEH08IbyT7W1URHbuWrZ8rHqszSMdKsqCx7ASMx8O92IOx4
JX2u0m/PftCpz/ebstkEkS86e37+yNik2jfo4cb+HhAkYYkgYUzeocNaWEixMslH
FcajN7OlPOnfeey4e2Fj7/C/S62tLwDD1HckZI9Ja3rE252BzECQ9E0U/4Ocf7ZD
kMKNWTPNhkr71ULS8mV6P4nVuyLAgA==
=fMon
-----END PGP SIGNATURE-----

--ETAL/F05848nVpj1--
