Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723166;
	b=NrJVA4pmSLNzDPv04t3R+E3HXvpBz1LMquK2ib5CRxnh+PJvIvj9q1UpSlVx8mEnixKF
	 okhcsVK6d8DZDHnc/+nhWY8iz0oSjGGG8Ug/IMnuxfxC6BGO+2TI9/aREuWJu1zYryNL+
	 QYd7xPcvKEDgOgyIHwmuUjLqCgyALFq+NsPlzVNyN0+JG99DTm30XBhtXe03JP5TpB4tB
	 OjFrKnLHLrIJfuReHBKbg05dtsykTr37YxBDldWyc/BxSrYqOMnh706XK/e/WoGXiUJgS
	 sbDL72w++ujaxovULh1XbzA66QGUjOqlldCeO/KA3mzpCA+CYNvmBfjW5uv8rOCRlHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723166;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=g7MSQ3YQKbEWyNo+t2pC7DSANAK7/eErvsEIaJ7+yZg=;
	b=spT/dhsg8cPPXim/kMqaRmFiaabcT4FNChLQtbKnIBYr+MDb1UqWzANCtatYy0JRUnws
	 Ch0wpZSGloTA00NLdWObA2gyrxQwpNGFrs2e9FvHqK6rl0j093oIXm7TyIPGDzVyxucis
	 fbYT4MB6X5P8j1LHbMoSwhol8QTaRWqKRYb+xYaFqQgOcWVp/Bl6gdnBC2j2c+e7jJn4+
	 gh2S+jU+2wzMLQOs6E2puYwajKvm3I6vptA23chuvFNZAj+vB44lXX6N38GyPtU999KY2
	 +4tm5WYWEbk5Pf+BE1+HowvGS3GhaJ3VVcTBqnGaUKaV8yYYy7R2xcVdXA8wHHdK9GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJq+ydBA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB17D606A31C;
	Thu, 26 Nov 2026 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJq+ydBA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0818D1F000C0;
	Thu, 26 Nov 2026 19:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795723166;
	bh=g7MSQ3YQKbEWyNo+t2pC7DSANAK7/eErvsEIaJ7+yZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kJq+ydBA6aCKTwUrlnP50MKiHfXYMFpUiJ4qIpmNhzNO/hm9UlXfTLbn5MaZabr+H
	 En0XB6vqy4Oyjf3PJDff2IkFVDD+6tbYBuA6YtiAzpFO4YA6781zaRiJJ4dvl5r3Ie
	 JUM3q+OZ/dzMSJ6HcXPg2k3IMYjXWj1NHxo4nTYVVrHmPKlHiCdWTHC6/JKS3vOl8U
	 LYoNjJFmKuv0A+7ODmtnrkxd16/aQB3ZGhnPVA5NShmtN1aWGkgr8IGS8GTyCYzMm4
	 ZEqPevMUldA4GSM3AffpxUhdeTDJOYUAxvHoblkD4pH6QnUzXatkqzlJKLew0R9xKO
	 2gDzqBQejCwXw==
Date: Thu, 26 Nov 2026 19:59:22 +0000
From: Mark Brown <broonie@kernel.org>
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH 0/2] spi: panic atomic transfers and fsl_lpspi support
Message-ID: <4d07263e-348b-49df-9bda-f026b343b8ea@sirena.org.uk>
References: <20261116094916.4039108-1-chunyuzhiqiang@yinhe.ht>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LeEWDUlyL5ewRgyB"
Content-Disposition: inline
In-Reply-To: <20261116094916.4039108-1-chunyuzhiqiang@yinhe.ht>
X-Cookie: Sank heaven for leetle curls.


--LeEWDUlyL5ewRgyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2026 at 05:49:13PM +0800, ChunYuZhiQiang wrote:
> This is a follow-up to Heiko Stuebner's "spi: Implement a atomic transfer
> as a last resort" series.  These patches are based on that series; they
> are not standalone.

This doesn't apply against current code (which has the above), please
check and resend.

--LeEWDUlyL5ewRgyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsIj5kACgkQJNaLcl1U
h9CdzAf/cpv63PbfRocwOuxOnrKVr2PyKFKsv70Or0QWMmHVm0Tsm/pSNos2pSE4
MO0WWLaRKuVF1rZwwkGv2mPZ33KBAk/mpmcW2OXak9tEJjQLX+5o7WhyUuOTjOT4
J9IQDMRiKmlup1b3ggJVpvnTBzbXACqCrvFXCmbzfjtLoVkrsHzfJtEP8xoNDgpW
u/8sjyDMdDjESOkygZKCE0SxhgFI9+JNpg0xmkEkPOLj4L4S5O9vA6DZFZtr7B2n
OZ9T+2T6+PeG7yWSEZt2TWjamZqQq9WP1AkEMoniBZPYiMhg1Z/tcoouaWc4vIw2
ChxZkbyCtDYyeWAqvRHydprg5ZXOFA==
=FsxV
-----END PGP SIGNATURE-----

--LeEWDUlyL5ewRgyB--
