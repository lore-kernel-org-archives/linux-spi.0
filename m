Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B602D77F7;
	Tue, 18 Aug 2026 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049105; cv=none; b=DqVF7K0/nz55ffxfaOwIJ+0OTG9K2Rr2164hxuH4ruZ6UTP/VxI8BHl8Ji5MYmNZ3lZWhyoYNBSelxFlRPkA0oHMQsaAU88FK3F+xMwm6JdNJksN2E9JEcBIjGLlPPjJTdyNDmk+TlkRo0a/Z3oq0gKw+4q41gP+FKOt4Kjny1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049105; c=relaxed/simple;
	bh=8wVo1vMz+nwNhoH/uuMOTOtPSD6EZ+ZWLU2Z2Uu/c/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEMN6m4crf63LYV8l3x/lgctli/L6WghFemNyJ4HbFz0Tk9uKeANJeklmvspDhfMN7EoD0sC/ySwdgZN633AFsGxhmk+8ERXq9jS7RoVY33/24AlzI5GwY49e9qoICkm+NEw27MLkQBDkUR8RK7tHeEE3DHt01VqUoPmxY6XZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IW+N6zqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW+N6zqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91A41F00AC4;
	Tue, 18 Aug 2026 10:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787049104;
	bh=jFkVtkhfIN2OPkHgRPQWKQH8YUG9gSxbS0ZY6l1Jjxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IW+N6zqalf5ue6MbY/NYFy5rfNOP4ny4WrTlx29LOOroKpepb8INcoAZyP3Q38uUe
	 rtn5OxDscdQn2clNV0KQXDNPKkULH0e30u/zrlme71fT4czlaDFZJWx8vXzxUypAZN
	 2MvslvtAX3bdkL3XyvadtfB1LvASVFihAw7Ss3E3Y/FoF5A1wVsevOSToY0L2nTNP9
	 IvNkcw0H9PhrlpQx9nmhhG0RTnpBrjaEYunS7jZE3bmtevpOpDSC5P5tYyGpUZ18rE
	 ZAGgqiDhxM35f2TlqfVjHlYBVWbSEXXo6x0THZrnuOtU/c0LnM/fZK+e1I11vnCY/0
	 Apn/vSXlV3EEA==
Date: Tue, 18 Aug 2026 12:31:41 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: webgeek1234@gmail.com
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, 
	Mark Brown <broonie@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: tegra: Enable DMA Support on Tegra194 QSPI
Message-ID: <aoQ0gWCmTiaWXbjW@orome>
References: <20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com>
 <20260525-tegra194-qspi-iommu-v2-2-a11c53f804b2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4lsigaiunpjf6ftk"
Content-Disposition: inline
In-Reply-To: <20260525-tegra194-qspi-iommu-v2-2-a11c53f804b2@gmail.com>


--4lsigaiunpjf6ftk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] arm64: tegra: Enable DMA Support on Tegra194 QSPI
MIME-Version: 1.0

On Mon, May 25, 2026 at 01:47:45AM -0500, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> Without dma enabled pio mode is used and flash storage such as the one
> on the p3668 module times out and cannot complete any transfers. In some
> cases, these timeouts cause hangs and cbb faults.
>=20
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

Applied now, thanks.

Thierry

--4lsigaiunpjf6ftk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqENIoACgkQ3SOs138+
s6GLyBAAhq36NYEJpIF+BYwEPBGirYi9UVsxxIjMKPjUMcnKL3utg6pKPVJv7ej4
8mlXE0z14O+W2VuK/g8/45CpPrZgutUo1kkR5TxxsNEVdi06I4oCOuUcP+FfO7bj
iBuzAHgSSZsbBlQ2/Dwz2mmK5cIkzy9/zOLdgxZjdir1uft+0mRkLlxsGwlmnwf8
UDpYGNeTE/agVs594aJNnnIDsh2fvS7oym9EMeMGCFXaR0UWt0Bl/rK6C+ccOqt4
1RYUw+S5YbffBAzJOn0boRkPb8+qIExRTYWExcKK442doQRhECGi+zqV2CgYtdLd
LCQJI/jSsnCT3sx/KsplfBL1vUiB6Bl2zfaVIYgJ6vT9h6u9wFlw0hXl5Rn++iYf
dYDuav/AFVVlLAGp/YBrO21PCUNBqXJwaeFz7ngKOz28Qq4QYK61i/YuS2/u4exI
BQYIyB2yeTOqUhwFzrcigBszsPNzyPd38pZYSiJMJSHgwx+lC+ii0/alVQWkmQe8
wi9hyniJoGYCZNKDdGd8dc6j5NZXXUxo/LfkK24aiYurdGC6QsmzB1Eudv6UaH7j
C7HLIH61E7F7l5xPUVR4mxTOHOl4QFSh4+YYZJudidKV9FVg/6PTUMDo1T2T0w6C
yvHzgRBlE3Rm+yahBtBPNg13buXtNLyX9Y2NCieemreuvMZcBJ0=
=52eR
-----END PGP SIGNATURE-----

--4lsigaiunpjf6ftk--
