Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973443BDCB;
	Thu, 30 Jul 2026 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785422270; cv=none; b=UXS/XsM0h3MfDo5ilXmt35liZ0E6lA6VCGuGQfd8X8XqQyAsH+9uil/7SYptwRjGm1B9SJQ4RyYCGEiPWVd4Lt4RugDdj+u6lwZbIDLxm/vQP49BC/Ze9i3XiyImCAFc/UIhpceJw15cLeyuGA8cNjQx0+I52C0I1pLQV0/v86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785422270; c=relaxed/simple;
	bh=0jjN8oDmo4zbwa5dN36JkVZ5zd7O2p7rJIOWPtT+FVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k03geAJGdp0UfigiqRiExUnXdJB5wDploKyJJ9c7IkIhMRVxx1hChKNDftNg7KNMtrt8ghd3lx1T9MtJESkCPep82uoecXowHmNIs/w5W838eZQ0un4eq4kyYW1eN6E+fVGrTkfJw1nBuTycyDTAKgf36KDziyACUXUET429Yr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjHa02Lr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjHa02Lr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC481F00A3A;
	Thu, 30 Jul 2026 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785422269;
	bh=0jjN8oDmo4zbwa5dN36JkVZ5zd7O2p7rJIOWPtT+FVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jjHa02LreQ7ZfcJ6aUnoYL6fyIQ3JULuAb3U15dPyJq96lxu7p90NtojdQOvuVJ8J
	 q8xWJrY0uo91ERrsbQSMK4zp+QABLyy2NUEApT7jKbBegHa8vfJuwqdHEUzaQEgtRS
	 dZZByzuneHT3uocDz4uWHbOSYQCRNv0F7V/zrDXoUhgtbznifhtRbAzPHccZ7gsuEJ
	 TQTtET78mAUrKyQ51YndKq570tLzNzD480JVHOPmRl0d2z7xci5i5KcEQIbKywuO1O
	 idx5SxgpZ0if9hU617b9WlWPUd3ornF3wtEVO8LKWksQvfZse66nYi7dc4WbKKHgVC
	 9PTFb3y7n5iBA==
Date: Thu, 30 Jul 2026 15:37:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiawen Liu <1298662399@qq.com>
Cc: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] spi: nxp-fspi: fix runtime PM error handling
Message-ID: <1a74a1f2-e6b2-4faa-b11d-2a1ba6cdf1c5@sirena.org.uk>
References: <tencent_B3AF7EA2C812124397C0691BD0F0B7B87205@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k0ooVb+TC2kucGfX"
Content-Disposition: inline
In-Reply-To: <tencent_B3AF7EA2C812124397C0691BD0F0B7B87205@qq.com>
X-Cookie: In specially marked packages only.


--k0ooVb+TC2kucGfX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:04:40PM +0400, Jiawen Liu wrote:
> Hi,
>=20
> This series reworks the previous probe-failure fix for nxp-fspi to use
> the newer runtime PM helpers, following the pattern used by spi-nxp-xspi.

This doesn't apply against current code, please check and resend.

--k0ooVb+TC2kucGfX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmprYbgACgkQJNaLcl1U
h9AnUwf+NzMLZpNo11e6i6Xrnk8jB2TrN8AMF9lgDCFgsq0aa+scd/+9PwsflSgA
kfmqVRFIMAb1ijqBjn04f/URbF8vZqVfcpUOBg7fymr41mQ+PakarwoWBVMGB1Xz
WKd8GMydRl2uJgtr3zZRdCeFYbUXsoW4/tFdlz6rl2VpBvRrFpelj6GXN85PM2Ds
nvbkKMBgq0sUh99REsLy+rkL84YVqre+tg+28WnPkWSG7NSzS8mxuot4vcc0un1j
GmrKDVMrt6Px0V9xozfCozNZ1g0q30qtRxfr2F/wprNJmHHBjcqSAfKB9CO5tSs9
LMt8sQetGN+E1SyMslKMW/BC7t653w==
=y/uU
-----END PGP SIGNATURE-----

--k0ooVb+TC2kucGfX--
