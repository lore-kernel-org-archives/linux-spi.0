Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5B395DB5;
	Mon, 23 Mar 2026 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294877; cv=none; b=ZDkRQAcUs48olAOICZf0jzfMslLKm7X9sKrPbq038T+LNwZBnsxC+YWfuoIKLZoST+qU5kWejHuEHmZ8ijTAN7Vgn9Ln/jPUZWXFAqfmFgNFlBB8LbI7EgyWzgsrH4vZtGWoWdfF9Bf4/8irBZhtzLzZKnUUN9r7d3RtHOGX7hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294877; c=relaxed/simple;
	bh=zr8+lYtKw72pHAPt5RM+e4aIZvvehLBMSQxMXfk5GvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lz/Zg0q6jZAOd0/yconrhLDTlUyWiZTuj++7+MIlgPDky7jVcR/XP4ZoOH90FiP7v/ArdtRi4kon3kPKtIuiySUXDTxHWU3lZhlm4c5IzTRPkHfftDFXITghTyGmUcuvLGhjtPAC3KFuzVK1aS//CYWDK3gEuetnZHaZx2spLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq+oxJt2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq+oxJt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06B0C4CEF7;
	Mon, 23 Mar 2026 19:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774294877;
	bh=zr8+lYtKw72pHAPt5RM+e4aIZvvehLBMSQxMXfk5GvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tq+oxJt2YMht2bBZTFfKphF7mn6pccuIjaZ2WdoGqND03PSfnBcBQB1NIgNl3z61/
	 UYjZvaYvOqOLA7E7yYH/HWnze2466c1O7qr8kwURq3Awqez0yJLns68n/QUpifX44i
	 NGciV5iFQONI6v29a9Le0gLcVfC1bx1VYglGZLg2GWEDvGnLbMY3SkICaK5hKK5XkD
	 avgro6JAqTPWd/CiQqwSpmCTGS3nwGJk6qZqYH1oieE5MsIqFiCjJFlwAJAuUrVFLV
	 CmAIhZkRT5QaFJoHBEaM4h8+RF8SJRC4ha1+uWRl2AUhuZrju5id589FaWrhR+9y4I
	 k2MF7ywBcuyyg==
Date: Mon, 23 Mar 2026 19:41:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	openbmc@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, Frank.Li@nxp.com,
	amelie.delaunay@foss.st.com
Subject: Re: [PATCH v5 05/17] spi: imx: Simplify clock handling with
 devm_clk_get_enabled()
Message-ID: <3fcb0dd7-ff17-4d09-b8ad-15f0f1211f42@sirena.org.uk>
References: <cover.1773885292.git.xiaopei01@kylinos.cn>
 <9d0fa929a4158e7f4e9adec21dd351e6cdd2984d.1773885292.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/sLNV2LkpKlEA+Pv"
Content-Disposition: inline
In-Reply-To: <9d0fa929a4158e7f4e9adec21dd351e6cdd2984d.1773885292.git.xiaopei01@kylinos.cn>
X-Cookie: The only perfect science is hind-sight.


--/sLNV2LkpKlEA+Pv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2026 at 10:04:01AM +0800, Pei Xiao wrote:
> Replace devm_clk_get() followed by clk_prepare_enable() with
> devm_clk_get_enabled() for both "ipg" and "per" clocks. This reduces
> boilerplate code and error handling, as the managed API automatically
> disables the clocks when the device is removed or if probe fails.

This one also uses runtime PM.

--/sLNV2LkpKlEA+Pv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBl1YACgkQJNaLcl1U
h9ALkQf+MCWziHjA3VCeQ6Z0O3ebkwfUwmCcxHPAsV+PSLGPTi2YbR/I9ctOMekg
tXlv5rI17nBcZCGCxil1OEOnjgOC7jRGuVmWaApY5nSEx2X4GZRS3GDna8dUsAJN
xQVd9DSQEfJv1mEe/jXE+eCG6eoVIPoltsgeEEIhZVAtQ1tkszyzlURiBKoteOLU
O4khFyG2m6n7gfyTKD6aRl3n8L8fhLz8Kd+75V58qWN711xIsaoqhyXSfJbucEgX
/CR+2K4QdEZFmVfW5zRzRMlbi6QniSd9lc/ROJWYjvQovVpyckuvH31KgwID8IHx
qLpvFYg7YLU7kgQy/nI7ksShV4LZsg==
=Gpc2
-----END PGP SIGNATURE-----

--/sLNV2LkpKlEA+Pv--
