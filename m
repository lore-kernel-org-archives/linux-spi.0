Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3068334C39;
	Mon, 20 Apr 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702576; cv=none; b=TRYe/p7sf6YF6FeiXSX1DzH2WwjzWMJ4LOlLof4RM97Slmo0u1omP0ihEOJD3ew3fHQNUzc1wyZmyX3y6J9iuMln+ergvZirEO3mw4TxxgZiIi5x04za16/wS8RAD3atc3f93lBeKS5J5PAy5Qz76x+9B+1oQfEIllfB/dQB7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702576; c=relaxed/simple;
	bh=YQdW17/AA+lxKC8kcF6WCd+KieSYnqe1M+yeYbAJevQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNxbTITjXGQuPo1GqTo+EQD1W/+PV35K69sTyDoNJPWk56KjKWRvca1AMpBzeUHS+XKaQ69k1m/E0i41aO3V2S+vU2HTRuC5eATKkvZcJeppWJsEsNHWNtelzdm/L55ziatZ+5Ozh/W+w46PpzhXlAnGIY/9UoaNYaaM+iMIP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvXVoNzk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvXVoNzk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4E6C19425;
	Mon, 20 Apr 2026 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702576;
	bh=YQdW17/AA+lxKC8kcF6WCd+KieSYnqe1M+yeYbAJevQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FvXVoNzk69Ys7W/EUulIQI0838gefgkQ9GwC+3lPvOOSCaVoN94T+1EBB0fwM7i50
	 18LGyJW37bJl/QhOSwrqNWp3qHfNtn5NqbeiueuXuYoGF+FkzZlKrxLbl6CdroPKEj
	 sQ/HpdDkhD8kE6FAKt7gcBKtjlW+Q97sKY6+BUZBIJMcwUmVGuBEHluVlHDjl0Ts0Q
	 A26Cabm/xPwX6alUmvAyNMd5CTPa70AUA5TmgaFOAYXmcvZgNjwnpR/K9cVH/8iuD9
	 /FgD9x86LQgUWAxYleONY1p6sqvQEj6JHvy/L19NRIdCfKK51hNb0pzOjHThaE6u8a
	 m0m34d/o+tKzw==
Date: Mon, 20 Apr 2026 17:29:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] spi: qcom-qspi: Fix incomplete error handling in
 runtime PM
Message-ID: <c38284d9-f7a9-4a0f-a4c7-cafdb1a1f720@sirena.org.uk>
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
 <20260420-spi-nor-v3-2-7de325a29010@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YEPl/+bK0ZzKjQuR"
Content-Disposition: inline
In-Reply-To: <20260420-spi-nor-v3-2-7de325a29010@oss.qualcomm.com>
X-Cookie: Sales tax applies.


--YEPl/+bK0ZzKjQuR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2026 at 11:42:49AM +0530, Viken Dadhaniya wrote:
> The runtime PM functions had incomplete error handling that could leave the
> system in an inconsistent state. If any operation failed midway through
> suspend or resume, some resources would be left in the wrong state while
> others were already changed, leading to potential clock/power imbalances.

> +err_select_default_state:
> +	pinctrl_pm_select_default_state(dev);
> +err_enable_icc:
> +	icc_enable(ctrl->icc_path_cpu_to_qspi);
> +err_enable_clk:
> +	clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);

clk_bulk_prepare_enable() is marked __must_check.

--YEPl/+bK0ZzKjQuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnmVGoACgkQJNaLcl1U
h9Ba5gf+OY3mSJsyMuuK/3icHqIuZZc7jH+z0LwxA2Ylmkj87+5SXH0OjYYC7yKU
auSZV8+2y6dBPMt5ilAGf3KOrLo+Lshc8dz1aCXTgJv6KoTLrcGQIO430yLmC7to
B9NgPMmiwUjAxahjPC4LhvHWYFFMFAkBF+ieNWkhNTOgMuW7hpGPPK0McxkaMMqh
vavTM4IqAN1B/Pr/PhKah/YbEV4QiLj7sM8g6gfCiDOFj9qXHD42nanwNIkXKUY3
S5Lsa/5vdPa5gqI9xuA8pLAjs1amw7tZWc/hW72XsSGoV55RdM3ltHaNr7k6kZy+
HJ605If84trsQZjMGjxeRdkfo5E56Q==
=AKIL
-----END PGP SIGNATURE-----

--YEPl/+bK0ZzKjQuR--
