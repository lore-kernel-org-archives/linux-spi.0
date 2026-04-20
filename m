Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991493A1E6A;
	Mon, 20 Apr 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694997; cv=none; b=L+gD6LO1nhgBguh9vj2B5CHQM5l2D8AdM6XFTkjVAz6W4AzoTE+UpLwffVMnfIuPAANtplYeVF4rI5hW+VAusuK+3vj5T+yTRdeRXL83p1M4dtyuImbY29jyCAyuoEEdCZFLC0Emv5y8Nk65+VaciV+XYR0wdB19PfJie5d9UeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694997; c=relaxed/simple;
	bh=laq8Cmx1Sii26P+XD4G+uU1EMsWSp4l59wWDf0Dw9jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xm47qsQf3LWOUjc5Bhn00yiL27JiW+cQPJYKf+JUnI2XcMPD8In2LsiEuaTK243IKICvv+LkW08xLihTdcnboX2Oak4I++J4v0crTz1wyCqbSHsWcrnaK9buLbfwg/R9Gjht6zzJhSJbHEXk6LHeSMOA2DylsqzlaoyQ2mSJdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amsgAkQZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amsgAkQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E537C19425;
	Mon, 20 Apr 2026 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776694997;
	bh=laq8Cmx1Sii26P+XD4G+uU1EMsWSp4l59wWDf0Dw9jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amsgAkQZH2iGEbEQJuGa9fIjKtZAnWq8hbXlcnlwPr7kuRk49UxkgVaOQYpPBRwnG
	 75YWmL8nn4vK+5mK1FKQLdHWPNQ765DqZD/gd+pShCyZRgS+kW0xlq05Sh5hwLgqo4
	 e1isevZH+nqzqYzkuzXG0jwt0UnH2/wtmEzKU02jwifWTt13/sHpvalwcG0bDIRHZF
	 vdJIGKJsVp+wQVqzkHydO7/Y6Nuw5aaEe01YhZQRK3u2qmllw/ZfMzvdSqu3w/Xg+i
	 Q21sN4fNZeb+6uQyIov2s6SCkITZ1+VbQSS7UhvPGlN96UXcJJhQ0RALykVTCubZMF
	 eDEtMY3nxwcIQ==
Date: Mon, 20 Apr 2026 15:23:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] dt-bindings: spi: qcom,spi-qcom-qspi: Add
 qcom,qcs615-qspi compatible
Message-ID: <c385ada5-f7cb-45d7-b7d7-43fd0cb389c4@sirena.org.uk>
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
 <20260420-spi-nor-v3-1-7de325a29010@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqQrFbeBzNreMCoJ"
Content-Disposition: inline
In-Reply-To: <20260420-spi-nor-v3-1-7de325a29010@oss.qualcomm.com>
X-Cookie: Sales tax applies.


--aqQrFbeBzNreMCoJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 11:42:48AM +0530, Viken Dadhaniya wrote:
> Add support for the QSPI controller on QCS615 SoC.
>=20
> Move allOf section after required properties and add if:then constraint
> to require minimum 2 interconnects for qcs615 variant.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--aqQrFbeBzNreMCoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnmNs8ACgkQJNaLcl1U
h9CNSwf9GtiYu2P+6Qdp8Fi/pH4pqkbqsaeuesXEZy6XQYvHK7OqTfyRSU0f3eRv
MoLadxKpG0jQMVjIN/bDkKCtKXzbY885gVDw0ZhX5Vds8Wyow7kRpmiqFfdHVG3F
4dHhk8fhmqQVed7IU2FWnnS3Rk3Myg938e/cqfuCBSs/ZKqEhFV+jjbzBmCbSFeT
44rd/LWlIkCe0Boqrntmx0EBUk3yJi7hr/ka0qkE5e65I8/mtHee8fLVo2CuciVo
4MXxuaB9X2/UWhvOvVwwMaFDhXRSa0bIsT2qHc67v1JHS6nyDjeRnC4KJVX6dHrE
5SSe2ZEduonK7Z58L0X4YEAum5l6Bw==
=0k4M
-----END PGP SIGNATURE-----

--aqQrFbeBzNreMCoJ--
