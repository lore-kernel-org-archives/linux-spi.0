Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F64457B7;
	Thu, 24 Sep 2026 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289675; cv=none; b=EFSIvPXaQAubVXWi9UoTBeOTkAKqhHRHwYwsM+rLRaoIrK+tufsU+I8L2HibAjG6e0iq6d/HZf1204rNexOYn6HtDgekrfhZWvWaQA705Df4xtFvYo5EONkqTdPn1/r1qBRqAw+fnOSQHWQvceO4k8OO2EBU/FMps0BlX4hjC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289675; c=relaxed/simple;
	bh=P27PemtnaUNP51WF75LTe499h/9TTPZg6TB1QTmdpOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEKS4g3O8sFScn1K/Gqy/JXHLK9RVsew/neI6/a83+jGaU7SUuhabBmXQ0L5+erlR85+rOKxbcwMe/Myem62leg8bvYPczblrv1cqnKUSx+mmi4LYOlwyUBOVBuE9jyDr+Zq84em15FYp6+ugr+VUIzze8mU8Wzd7+xA0H6+wsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDWvIBL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDWvIBL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DFE1F000FF;
	Thu, 24 Sep 2026 22:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289674;
	bh=+2I9a5Fv3NHZeQFI/SnuqWvZ/9mnxflxd2ac6GfRRA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dDWvIBL0TJcnCoFPM6fdiLpHDuoS4zO7i860vHTrD5fmS8zInsD2uxydmawGIDBSm
	 yiD1aj0s02kUqhStUVGiRpjrhIcv1Ri1xcYV7DRJcxoA5H/UFP+HzhsGB/Zj2fejBB
	 TZag+ZEAAgUHJfY5DV5VHftUynmB+FIeuG0oiTu6kQpfuinXpPQuwLMx2+DQkAaYbr
	 YSwmPuzGgZqucyOJnMcG2h+Wfmsztd4V4iBCpHL3aKFpBpCXq7ElFE0mvqHTLhbGUv
	 5NMQZirOFns17sui6DkW6ZcNWMO76yRscFU14Pt6Cj0fEG2/10/bTziXRASYGv+sFY
	 KKLrmY19WOsmQ==
Date: Thu, 24 Sep 2026 23:41:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	chandana.chiluveru@oss.qualcomm.com,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
Message-ID: <95c6a43b-37b7-48eb-be88-79f1883212d6@sirena.org.uk>
References: <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-0-fde2ebf043db@oss.qualcomm.com>
 <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-2-fde2ebf043db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FHzQCwZbvrFA0LJT"
Content-Disposition: inline
In-Reply-To: <20260824-use_gpio_to_notify_master_of_spi_target_activity-v4-2-fde2ebf043db@oss.qualcomm.com>
X-Cookie: Oh, so there you are!


--FHzQCwZbvrFA0LJT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2026 at 07:56:00PM +0530, Praveen Talari wrote:

> When operating in SPI target mode, the GENI controller relies on an
> external GPIO to notify the SPI master about the target's active state.

> +	if (spi->target) {
>  		spi->target_abort = spi_geni_target_abort;
> +		mas->ready_gpio = devm_gpiod_get_optional(dev, "ready",
> +							  GPIOD_OUT_LOW);
> +		if (IS_ERR(mas->ready_gpio)) {
> +			dev_err(dev, "Failed to request GPIO: %ld\n",
> +				PTR_ERR(mas->ready_gpio));
> +			mas->ready_gpio = NULL;

I'll apply this since it probably doesn't actually matter but this is
broken for probe deferral, and might cause issues if the system really
does have a GPIO but it fails for some reason.  It's better to just
handle all errors as errors, _optional() already returns NULL if the
GPIO is genuintely missing.

--FHzQCwZbvrFA0LJT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq1pwQACgkQJNaLcl1U
h9DVlwf9GxWw9fp2B9LPLYH2bnjK5ee1JNL81VxFFyRTngiyySgfiGUI4JnlGDZF
/2SqNv2xaaFfDbnQwm43d9jIacySvrH3B+q7w+/GbcsuVtVnBeW/9ki0FYeW/03l
JtWsNVvVQtHB3ORZWG3GHSj/Dif7BXHnXHHWUr6x9tW5VZVf8ew81qeWtGFxjpTx
+H/bu4tay+eAmG3lsLafE828B0OT5tHSjh1z2ulZb0Dy1iw2cuN053FZzkQFu0hL
fGT8qawPVLuuKHi/7GgpOReeGIPSlW9NLiGnOrvh2GpXJ/AauurOEHpSL0rtdeIP
0+ZWoklRC450W4WK8l8KI5S1dAv4iQ==
=XcsA
-----END PGP SIGNATURE-----

--FHzQCwZbvrFA0LJT--
