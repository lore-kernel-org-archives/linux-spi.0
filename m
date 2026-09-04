Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE951E45B;
	Fri,  4 Sep 2026 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788545679; cv=none; b=FYWdNnmOnkmlNgshavH1RUFLUwKNo+GbuzZfiepolLHBegDvQS5Urq9B6WlG9fPdPp19dh/hzIu7Yf9zpe4e5+hlKWsEaTi2ImYpGBb5/n9J/YTWekYKpT6be79HLlF9wf57EwC/7dpfeFMk2obYdznN0+Urtk2/Qn4/uUhxQyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788545679; c=relaxed/simple;
	bh=y+bmBfxgdZRu8/WaJZlGjGMCYtltdMuFHG8Dk+wiLyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/1Mo0BF8TQB1OPoj+FHtkXpK6KAFlmkRle9YVNZ1iAtzukzrBSuSVafxoMkASm9mEZgtm0sW6CB6JP30FhUV2Z1aw3O7WBMPI1Y5PPFu12yryWeLt4SiY7K89/QVW21mMzl1TAYByL+sBwOZS1doPtbg/LVcAQrbtSwsUv3xvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi/Lo+Cq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi/Lo+Cq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5226E1F00A3D;
	Fri,  4 Sep 2026 18:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788545677;
	bh=PmQzA/sVHLKqaojPdDB1mXMUb5EHle9cFpeog9QN+gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mi/Lo+Cq90i5cP0QgPI7iikCfwZfaVNeVSsUgOQ/nA3+xM4ZeyhAyP+ePSrNIy/+/
	 zE8Tg4j7TVbUFiro20luaggZcaQbxbHV7Y+tG7aVuykEGVXOnDAQgCj2etpIkdO1XL
	 2XM29PprBDgYg/5i08509yndfikxrA7OF9dacYBFwxnBuLN7hzUxz21RWfbAG4h61G
	 QOPC3gaudl+dQ/CnhBGU4j+1ghDonGjsVDGs2k+0SXOImrEMXxuKVElGJ0D3dpcaHX
	 cQYXFHExIf1sJyk7ISWEO/YvfBbGzfFg0Ke+lAq2v0qHQmDhZv/PDmHOZONkxPiyWn
	 I2Z9lK6O+lK2w==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id C754A1AC52F1; Fri, 04 Sep 2026 19:14:33 +0100 (BST)
Date: Fri, 4 Sep 2026 19:14:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: md.alam@oss.qualcomm.com, Johan Alvarado <contact@c127.dev>,
	konradybcio@kernel.org, pengpeng@iscas.ac.cn, j4g8y7@gmail.com,
	quic_varada@quicinc.com, quic_srichara@quicinc.com,
	linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: spi-qpic-snand: publish the ECC context to
 snandc->qspi
Message-ID: <apsKiRC-bn7oPS2P@sirena.co.uk>
References: <20260825013848.1056946-1-contact@c127.dev>
 <178854349408.1467647.16557341714581809344.b4-ty@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b283S8Tm5n9MmedD"
Content-Disposition: inline
In-Reply-To: <178854349408.1467647.16557341714581809344.b4-ty@bootlin.com>
X-Cookie: My vaseline is RUNNING...


--b283S8Tm5n9MmedD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2026 at 07:38:14PM +0200, Miquel Raynal wrote:
> On Mon, 24 Aug 2026 20:38:48 -0500, Johan Alvarado wrote:
> > qcom_spi_ooblayout_ecc() and qcom_spi_ooblayout_free() read the ECC
> > configuration through snandc->qspi->ecc. qcom_spi_probe() points it at a

> [1/1] spi: spi-qpic-snand: publish the ECC context to snandc->qspi
>       commit: 93bc7c4d2f4198586a6dbd7797c3bbf1ca845761

Oh?

--b283S8Tm5n9MmedD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqbCokACgkQJNaLcl1U
h9ATgQf/dI7Qk3Q5n9dlJsVPpF710sRJlyIVEwDCz5R7Vs8ciOj8eHvUTXXOEbYK
yNNzYEaKEEfgwI9ryihBPeSdMQNR0qHsOqFiMFi5aP6wBe918CPtYkyCu+sIrj5y
G4qRjRJkfznrSwqvFED//KX2IOFXpI9FzjLoKcNKcpFZvVW1H/gKEU6jvR7KYYBE
QYpQs7FIsSIbv7g270pm+kqb+K4Lt8IYXtWa+jyDSBiPMdPvYLbO9FMAqKnyS5zi
aN5HP4Q7WWNdG0ohl/itKF8Fq7HxqFO9Cs1gZiNY3ypjfNxLpJXanUowS0VNPdeb
jF01Bt7GyFGZ2+Q0x4xm5ZVp5t3o6g==
=I5SC
-----END PGP SIGNATURE-----

--b283S8Tm5n9MmedD--
