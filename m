Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D341A781;
	Mon, 17 Aug 2026 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984362; cv=none; b=OR3eqCFOtBN76eOU/6V2lAE8apPQKEKMA36/GHY4R1uokr2zla4/I6quiN0z9YzD//fh23NREMWSEZYYrpmYHYTNNkpbOHPwX2hPqUEW6X9x/83DI2FMcHijizOEV2Of+7o1ZfH/FqU67pA/vsHVEEMRcjWS/2Gh5eZAfbzNQQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984362; c=relaxed/simple;
	bh=/u2cY6Mo5HjnuACB3/cD+dA/lX50pfqOek+SyLCHjSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg3uOqW67gQs3PTYX90o8y8CvnVaefGiHEJeerQsuc0j1wG8LXjjcHPi2enirCkK3k/68HpnLBVQ1QURAE1jZNWgyCYFERuE7uXNiSraSxEjvibW9sx0OPEE6X3gLTO7EjQamMuq1mQ698YuUyqFiiisNCziyDN28X3EIeQpwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcsUnRFv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcsUnRFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963041F000E9;
	Mon, 17 Aug 2026 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786984361;
	bh=/u2cY6Mo5HjnuACB3/cD+dA/lX50pfqOek+SyLCHjSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lcsUnRFvv2HGHOJ3bl1R1cgXh8HpqT6sEKzcLoMBDic07slvmjH4nz+2yufdzAlk1
	 jHoSqpAt/AEZddlIuu+NCQ30bskKJrXa4cfRPR7np8sOI0aXH72p2HMsTgT06q+8Hk
	 GqFYLjv5WCfE4VqdF3Ikbtt9BqebH1LFbaU0j9xENBBQddoGa6p0MXPTTBkag2QQ87
	 VST5FhnZq6tCAUc4Npn6NuXKlQdtA6ZIObOb5nLnmH/S55pxnAVYYu+3hm1DKlvIia
	 IgvF7Aw5KFVPl5dUXMXcmyuK1m/1EiPmd4ubB7O4iShG+nowb9BUWDaNQTcF3gsjgU
	 iVmFaWzZi/5Jg==
Date: Mon, 17 Aug 2026 17:32:35 +0100
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
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: qcom-geni: Document ready-gpios
 property
Message-ID: <5631fd5c-731e-42a8-b9b2-1078dd0878a4@sirena.org.uk>
References: <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-0-94d1eff3175f@oss.qualcomm.com>
 <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-1-94d1eff3175f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="asvrOmYDzxj+tFQm"
Content-Disposition: inline
In-Reply-To: <20260817-use_gpio_to_notify_master_of_spi_target_activity-v2-1-94d1eff3175f@oss.qualcomm.com>
X-Cookie: Obey all traffic laws.


--asvrOmYDzxj+tFQm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2026 at 09:46:52PM +0530, Praveen Talari wrote:
> When operating in SPI target (slave) mode, the GENI SPI controller can
> use an external GPIO to notify the SPI master about the target's
> active state.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--asvrOmYDzxj+tFQm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqDN6MACgkQJNaLcl1U
h9DWjwf/R3SvQ5k3tGY/bS+UU6mYylClSoTYLd8XmP2vo0otIMtBRH/rmXKMxcb9
odM/R4qHfweQYhmsDZ0K+TpRourI/7t7+sy/cd3YC5LyBHir8mgIafSxLchnZXZx
CQi2pcj6sAHejZ03dgZA5CSM1baIas+rGLPYHDJspLNOwRdQ33TRFkOwsuF+O6fx
nZZQnrMgzTvDaaw07ehnQJRL/YuoCpY6W3Mb/VSs7SfBOVFBCSBwkkwVFbWHlCe/
EIE3wRyW+Dg8Miz70updOdIs2wav72vNEOXCEGbpKqmyPZpVHyYO57MMSUvIUddj
MHua1FgctLapzrVn5LjpNeNDqa/Fnw==
=BlvX
-----END PGP SIGNATURE-----

--asvrOmYDzxj+tFQm--
