Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532F378D8D;
	Thu,  6 Aug 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037729; cv=none; b=kgmqSeSRKF57pAzOXAMnZZYtj4x6vWBEHuIjS+tisVywyV62QkPr+FswtNP1DfVctQ//Whs/hHrvo5czc0PlZlIE+7Ae0MdaYvJwzluiP6gl79SuKZjdj/8WEmVyGCwU3Jzwh7bXR5mX7/HJvxIMHNg7rO7tFDVZ7XIMAjoLhpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037729; c=relaxed/simple;
	bh=bjyWqP082uW2zjdVhQPed5q9qptP9hubeufn7A91vM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToL7dvFe7Q9Y2gC52Wr8znbK9cjR40YQElz89EVx9nDhG38qag6QYvCdrsEAXeWRP60Wrui6Vz9+C21XLfxYu8CwJApHbHL0i7yCZx1ihwEQyz3ikMghnbIRh99GBC5YIRXHcmFz77onnCocPn7AzjFzvtVPzFuW2JCCuzclwzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7mhEBv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7mhEBv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C81D1F000E9;
	Thu,  6 Aug 2026 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786037728;
	bh=bjyWqP082uW2zjdVhQPed5q9qptP9hubeufn7A91vM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R7mhEBv4GlnqUARFRcYztxAiknGqrEnXl6/umXd43AIWFqfQD33op7z3THTMYYu0R
	 EWoR+s1jAzpfsaNrxZVjHA1hjPDnwf5jWdvkYjDIT9eYYofFCbeaJScR26Ht9u3rgD
	 zZ/rH2WW+MuwFT67mqyAiFDgEY71V1hrC07cBEogUSgngVkiod6kROgsE82JqG7uKl
	 npjwWX++GYdXJEx+LPeGKt/JK0j7pasIZw3SUmiZ5IuWZZLlOBL97aWT1sQ2ze7uWN
	 yTJpKEU2DrzNLnGYYrAcK61hVWZt2qq6AnzlWKUWOVo1oyys7Z9hehcIMAjtosonfg
	 KqCW9E17pS9VQ==
Date: Thu, 6 Aug 2026 18:35:22 +0100
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
Message-ID: <57719877-b8d8-4df0-acce-2c4faf5a5899@sirena.org.uk>
References: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
 <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D3Ywr3u5KIx2uVgC"
Content-Disposition: inline
In-Reply-To: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
X-Cookie: Colors may fade in time.


--D3Ywr3u5KIx2uVgC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2026 at 03:43:44PM +0530, Praveen Talari wrote:
> When operating in SPI target (slave) mode, the GENI SPI controller can
> use an external GPIO to notify the SPI master about the target's
> active state.

> Document the optional device-gpios property for the qcom,spi-geni-qcom
> and qcom,sa8255p-geni-spi bindings, restricted to spi-slave nodes.

This seems a lot like the ready-gpios property we have for some other
drivers?

--D3Ywr3u5KIx2uVgC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp0xdoACgkQJNaLcl1U
h9AmjAf8DFobBtyJkc4myDuBlSsbDbDMNgPu6Amo/ZmriQp82FZxsRWnqey4lajp
n5YGYkNLlEXmKqlRwJTc7px1MLaBGo7+fP7+KTsxkk6jcvY6R9a/xziePBM0RwDG
01oxXuWWKOihZjQEaP13CynG2q8loP4YiSIKPld2R7N8JBWDFJxq6iDYcPOJpRYi
9/e+vwt2hl1lwZvRtTCjneWcBKcPEGyKscVnp4kHntSxV05g3W4coohdFXUx9IAy
9RwyFT3T1+pzuUP7KUYn+lgOUi/N4HKnpTCslUfu4TOY7yxWEkFwdZN1DWWs8bQy
+iKlw9GXsfXz4t/PTeyGZ2ZJ+pUSrg==
=Zubi
-----END PGP SIGNATURE-----

--D3Ywr3u5KIx2uVgC--
