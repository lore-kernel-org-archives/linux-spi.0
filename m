Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30D3C5527;
	Thu, 12 Mar 2026 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773320546; cv=none; b=oHNw1fDImWr1HXpYjFPpoZ79cQyyNHvQjlYP+jl0g+4bLimaJRVkWUDEKb2m6qeSXizs6jq74t5nZHHKzO4lsx6fiI8DsYSVUi+d5z/R2daWO9QAT4T+uUMHa3ZBw5UqRAIHiBn1XBlU7qgTXAzIRiLn0cXWyGYRoJOgMfh5fVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773320546; c=relaxed/simple;
	bh=6JGSpqVxm5Xk2m9ccSi9/f5mq6saFDm1oVr7MCpFyr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjfzWGF4ycE2MP7q2Yr+5IOzVjqpM7f6FX7RPDx9bTGdqnMdR+9b44Q2lUzAHIuZ1dy0rdAjyF9ka/RgI8Mu2u9+R1p+qZHIF5TBcBEaH7adyVh+I3PhgMzDKoZlzAJB2S3ogO9q6QdgD1XFx8gjhjegK33DSI617LOiyIiczTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijzuRMZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijzuRMZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75297C19424;
	Thu, 12 Mar 2026 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773320545;
	bh=6JGSpqVxm5Xk2m9ccSi9/f5mq6saFDm1oVr7MCpFyr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijzuRMZaAG0cxBMl7gDHrSzew3fvUz+nBqTiXPU+NIp69zqt1wfJfesyFC/fVZS3+
	 fpJQfT7RAlMy6CdCes95jyDBXqJ9b0oy2+/mIhMf1FRNGI13AM1NqmAm86j3/A/552
	 5kQ9+UXYzpoZsbEKqCumRSSwg+UQG2vj14Bds3PbgErv5h43Bs/xRG8wi00G2nRngr
	 EIIwDGkg6bJW4vTpgIQrRiJEabuw4Tb1FNbFO22KU/UjrislDHxxzWqcPdnp2DTFq5
	 sey6Gzv43mUHHEgvpwlNQvy8QnAR90ilRc2oUbTs2Xh0giY+jhiCjSVqkQ2SFWQMPl
	 im56x+2su4L1w==
Date: Thu, 12 Mar 2026 13:02:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 13/17] spi: stm32: Use helper function
 devm_clk_get_enabled()
Message-ID: <8fe16029-2830-44c3-bf32-5aea31f72c62@sirena.org.uk>
References: <cover.1773306858.git.xiaopei01@kylinos.cn>
 <d239cda51bb3dcc84da4a7194a30f3be82422f70.1773306858.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9knHiRnV8mpI+WJ7"
Content-Disposition: inline
In-Reply-To: <d239cda51bb3dcc84da4a7194a30f3be82422f70.1773306858.git.xiaopei01@kylinos.cn>
X-Cookie: I feel better about world problems now!


--9knHiRnV8mpI+WJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2026 at 05:29:05PM +0800, Pei Xiao wrote:

> +	if (!cfg->has_device_mode && device_mode)
> +		return dev_err_probe(&pdev->dev, -EPERM, "spi-slave not
> +				     supported\n");

Similar thing in this driver here.

--9knHiRnV8mpI+WJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmyuVsACgkQJNaLcl1U
h9CkwggAg24YBsU71i5Djghu/lHhxeErxA+7HBjAV3TstCzfospFBacxZTrIypgS
mWtgo+SwmXbDn6WiyjDlwpIMTI6PFDzzMn6x6sxwj5/OD1osR2cJ2SYzYSbwFxbQ
uoJphNgSht3FEaDioOtHfdrgiLIkMm+/TYlf1u7+ZzrgI4ueyhtCfs0dN8EfdB+q
pAJUva6gft4S6N3uS4kagfQP8e+IwxXr5fekxL3p7Y9XYpa30rHE56Oc7sbGWGma
+WP0OfGjImbuvKtGxAPKoGBte/kLIrsSHoAFhTLSytjUxs4uuftK3Y5g3d7zq1fh
+TRESnlE15ixsifgA+1umZAfcpBjfA==
=ouCy
-----END PGP SIGNATURE-----

--9knHiRnV8mpI+WJ7--
