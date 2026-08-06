Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D122EEE7C;
	Thu,  6 Aug 2026 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041282; cv=none; b=Lr/luWfHmnVwVb7OWhIOcmDuq/VEgdOf0/wiC7eQ2gQh05yf/VOiuWGiX41apYHTcqbXPfUsrFwBJ97ZuQakrZGyc+qM/SbmFSrZbsdKvvx3lesZnaNfXu8Ae91/stkBF03BMbiMWocBzt65IaAU5UHt4gCl3gTil4Gb+HundpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041282; c=relaxed/simple;
	bh=mDCPSzh6rMRjDZZdVvq+/wEd+AVZYVPO4Jz2cpunOJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcLfG4mvqXXLadERuZtdlGCjCopjyZxKyS6W0xsFFkdh6Sn+OfDDLguLqckG5MD72ZWHXadyf1Cz1qncjjPj26bkdTw+ros7GU0gvJRHVBRdpcxtwl//643nSNdFubFeVM9NBaC0JJeDSE0onopSunKJkau6RiYwOGXIZ6FckZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlYXFqW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlYXFqW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880AC1F000E9;
	Thu,  6 Aug 2026 18:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041281;
	bh=mDCPSzh6rMRjDZZdVvq+/wEd+AVZYVPO4Jz2cpunOJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mlYXFqW/QSTKwZ08+7MMf2SChseEHoSG/ppVw6Lb0jqmLqM2bvf2VWBgRYbJdbMGA
	 Pv//9uUmYYtrDsIEOfPg/uOUJkrTDO3ndEayupNxM0tq6luhc/k+KDlo9smsgBwIL0
	 x5qiaYAFTguR+IDK3zRNBCX4l0lAJ9OH2WYt3Q6LXL7pjxKqetFSktfQtLWF4EYowv
	 T7lbEsjKWoDaR9Otz0WT+x0NBooPWTyr90HJpQ/HltBnG/Tn0crwQSuCcvPN6O+g0W
	 buR9dmgXuuTMVVNUKBPXNxlaYgOmL9GS0COo322oK8thf5HtQaOoNeozEK00NLqPNE
	 A8Y7Jd/G1AVnQ==
Date: Thu, 6 Aug 2026 19:34:35 +0100
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
Subject: Re: [PATCH 1/2] dt-bindings: spi: qcom-geni: Document device-gpios
 property
Message-ID: <65e5ead6-6159-4660-a699-db46fb4caf17@sirena.org.uk>
References: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
 <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
 <57719877-b8d8-4df0-acce-2c4faf5a5899@sirena.org.uk>
 <3594bbdd-e457-4a88-9e37-7acf0f3d87d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SiavI59hKZmQToq+"
Content-Disposition: inline
In-Reply-To: <3594bbdd-e457-4a88-9e37-7acf0f3d87d2@oss.qualcomm.com>
X-Cookie: Brain fried -- Core dumped


--SiavI59hKZmQToq+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2026 at 11:47:46PM +0530, Praveen Talari wrote:
> On 06-08-2026 23:05, Mark Brown wrote:

> > This seems a lot like the ready-gpios property we have for some other
> > drivers?

> Yes, you're right. The intention was the same when I added this property.

> Would you prefer that I use the ready-gpios property instead?

Yes, we should have a consistent name.

--SiavI59hKZmQToq+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp007sACgkQJNaLcl1U
h9BJpAf/ZvGuYNR8ph5K8AGotwW2rlx7waIg8MPC1X1bxqDn/t2eAWWUD64p5int
QWQ0OGGLCytnx5gsxV0pz4jXVS/tlJ7bJ5Ef9UFmbGGBt7bHgo0X2w0bEtJ+WkdM
FWmyqRh85QVGe+Q5rXM8ViIeU5Pwc3cXjq98r9lJB2pFN1zp30I5oaWWq2URYioc
3xPlB9MvB9kZ52+mEYMCAvZuIiv2H3id7JOPXQnRvSF0DWjCuSQsQUkkW/M5B3++
0P1GLnqJFK14yMxsVax7FNMaIM4eSVuCmBGTT7Qzr9uTyG0GPGROppNCrQJu+vq+
l8kg3YrD0VKjYUjSrwbbnI8Ntf9B7w==
=u2l8
-----END PGP SIGNATURE-----

--SiavI59hKZmQToq+--
