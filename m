Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E415B403EA7;
	Fri, 12 Jun 2026 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285305; cv=none; b=kB+GFJJ1Zpa3I0C2U3n0jqx/Y5FSImJmqwBRBol4En4ISLNScbWq6LyxmvYYfA2azRlFiIokiGn1QICG1mOFmCI+FX2PaD92p7UGUQkzptxzXQCd8s5fNncgK6OCWZD6PtCRgX09QRpR+7T47Ahq2T+pnJBM+DvuRPKRlDkqiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285305; c=relaxed/simple;
	bh=S2hcOjDhWb/vNa+SbkxT27YZyAwuz0W+DUemsN3nH44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9vePYRB3kcyaB+6VDmWnwmfXd/crCNNAZURXhRpLozIgQdnRXQqOVRIWanMFdSF/Q/8yg44We01K4GVHAX4uNPLAcIpPl8Z8syPKR2SRt1LUgXdrvK29a2URy4q+ZnPi8yeyJKC88Gn/kztkNbjqC0IraDL/LGZHtl6ICeVhQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzE2L7b7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzE2L7b7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791C31F000E9;
	Fri, 12 Jun 2026 17:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781285304;
	bh=+B9Mnhq9Sts0wk5d416JJnSdOR0uI7jorkB4ocDK2yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TzE2L7b7jetsDDcNpwflkzIUKfTVff9fh2efV+q2Ac0YimRjCopqOJlVgQaN/BDZz
	 egxVy7M5qWPyFPB6yN9NWaJiIw6FHQA0dkQbcvutzaiC7siipSaIBGRQMVNUWwrlUH
	 EFNYzInwcXwC/CNOMZYcK8KpQnhoBeWFQze6/sjEOOTq+2CimD+kC0mBD7NOdwx7Cj
	 iFpLY0y9dg93+83kQPpVfaHpw8/9Pii3SzwcXJ0oSTz+sJUdxhqcCDnIF36z2B15jc
	 mjVIzTyACJSwfzh7UlYrDik3AAWhl2drytoSokHLtk7rpXuuntqDfG9aAtzFmyi+/2
	 cuuRfSfcBLpSA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 69D541AC5AC2; Fri, 12 Jun 2026 18:28:22 +0100 (BST)
Date: Fri, 12 Jun 2026 18:28:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	bjorn.andersson@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com,
	aniket.randive@oss.qualcomm.com,
	chandana.chiluveru@oss.qualcomm.com,
	jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
Subject: Re: [PATCH v3 2/4] spi: qcom-geni: Use geni_se_resources_init() for
 resource initialization
Message-ID: <aixBtqPq3MNgYOkk@sirena.co.uk>
References: <20260604-enable-spi-on-sa8255p-v3-0-43984eac4c67@oss.qualcomm.com>
 <20260604-enable-spi-on-sa8255p-v3-2-43984eac4c67@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OnQv7vtGdhH50M6O"
Content-Disposition: inline
In-Reply-To: <20260604-enable-spi-on-sa8255p-v3-2-43984eac4c67@oss.qualcomm.com>
X-Cookie: Nice guys get sick.


--OnQv7vtGdhH50M6O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2026 at 12:20:36PM +0530, Praveen Talari wrote:

> -	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
> +	ret = geni_se_resources_init(&mas->se);
>  	if (ret)
>  		return ret;

Doesn't this still make qup-memory mandatory, breaking existing DTs that
might not supply it?

--OnQv7vtGdhH50M6O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmosQbUACgkQJNaLcl1U
h9D1xQf9GfmrmvD4Q2fAT09tGsO7G/vZ44BeuobltY94lBSq9jG1jgJO3grGo87Y
qir9RAkNV1V7AWacRzNTjJpD5BhFWNtHPgfXjFN03cpFRuh5kFLxEc50tJ/S1Z2I
mBEVyApBDIYJAUOjzbqdB8mdRupbbInQ9y0X+bIXkqg6JweaYgwybEaUL2nvyqrs
bQK1r82AGhcA26v6sB/wAST9Sz4maYv+NQyK1ZnEhkEFw4i0gR/PqXKA4geOC7lg
4yoAnF2S4+klW/8P02uSOUwvPX2/ndenuZyStMzvrKQSs6TYoIH2gqTR7g1Bq/a/
U8AVAPan8bT2tWX7N5TR/fMRHbXdrQ==
=s5Kj
-----END PGP SIGNATURE-----

--OnQv7vtGdhH50M6O--
