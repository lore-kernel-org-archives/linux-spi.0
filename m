Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20D32F83B7;
	Mon, 23 Mar 2026 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295018; cv=none; b=Ft1JmQJrR7Px/tkZHgXkzXoWvxOxZD0wUJcc8GAWBuzNKSQMVmrLjEMuWF3wMwKT76Kwd/PVVZh/ewPbTcOmRASvdx57LxEX6I5rUudrDCD0IewW8TmdsvlRvl20SZtawTZNBP6NAJp+NuOk7bG0RWVXlLbANS5YRwf//z0nZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295018; c=relaxed/simple;
	bh=v5WODaG9Gq7F9JZNXjpS+WX7LEMWIQj7OgYxY6O8wm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZFWF6j1xwbqDqz+Wo2fjTTKcNfCRl4GraUeWOoIGPPpILeNq0vOxHE40F2LIyrqgwOfUZWy53kEdgllM/RXk6MCs/f1kzfcrzeZ+NIjNwrcoLGY6xMccaCTh4Bv7hezx1N00QlZgivya5ihzOekVmdzmiIvyGhAEOGTqU4yzOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwxvSdbY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwxvSdbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CC5C4CEF7;
	Mon, 23 Mar 2026 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774295017;
	bh=v5WODaG9Gq7F9JZNXjpS+WX7LEMWIQj7OgYxY6O8wm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwxvSdbYYgbtTaGBexrLs+CBdI6CQ35Ad/j92i3+aRR27slb6tT7mjmS18WnawZKS
	 qjPE5+FMQ7SmONBT3pbXlxEnWBTjIfNKVpfb/l301sTXf8mwulN4p+us/dq6jpk5i9
	 zmFUX6viu3udkvBFk/DaAGrGZMfx4FdD1FTlGFI4EV5VGNXViAD9gJKwkJagHO/n7n
	 bH5xw/iUaQ212ONZ8kV3zMeok1EQaGArnSybU57FB0e9IjaWExq9bg37mVyFciJqad
	 lAe3YrFq/pvXpgB4v/Zo3VE8zAVgc4zbd/kAbUmX5YFWXCvU1Ml/2o0MMhVnax+MnN
	 nUU9y+OpLYjbw==
Date: Mon, 23 Mar 2026 19:43:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Subject: Re: [PATCH v5 08/17] spi: rockchip-sfc: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <a4972031-e0e0-4c0d-90cf-c283010980b4@sirena.org.uk>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <863ab1ddc4f3b9a25c0bf79e1581b65359cef6c3.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T+H6iatU6AC0B8Qc"
Content-Disposition: inline
In-Reply-To: <863ab1ddc4f3b9a25c0bf79e1581b65359cef6c3.1773885292.git.xiaopei01@kylinos.cn>
X-Cookie: The only perfect science is hind-sight.


--T+H6iatU6AC0B8Qc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2026 at 10:04:04AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for both the interface clock "clk_sfc" and the
> AHB clock "hclk_sfc". This reduces boilerplate code and error handling,
> as the managed API automatically disables the clocks when the device is
> removed or if probe fails.

More runtime PM clocks.

--T+H6iatU6AC0B8Qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBl+QACgkQJNaLcl1U
h9D4ZQf/acnRu0a4w6FJL3v12O42Uq6Atol8X/9TvvfEv8vy8qQx4u7LQH0wAamf
h5RLhWnd6nnJ0UEgty8mI544lxzYw4RRV37oEWa1YlNgWMLJk+5DOgR6Ez20DfdU
vVcwkiwN1T30Yx8oaZOvLVLtuKv3X31uzjSJLs4xVCFbvAJSqjhhnXrhBd+NqGgD
oLCC0q7KFUnaYaKyIBrZNm01jtXo6NntwK8dLHecJOuXmSAXpCnAM17uiYSQCuL9
d8SJVRLy9Dbwoz+RSHJJh97TvT0aW9by4xQABRV37vXmaj48N2TXJXgJj5xx+teB
Qqk5+3b+2LydR9XyiqHGRXrhmHGHQA==
=dt67
-----END PGP SIGNATURE-----

--T+H6iatU6AC0B8Qc--
