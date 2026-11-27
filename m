Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783828;
	b=RYhhZ/jyj7BHCxuBaCcfSLhC5+84GI7+n68f56kmBn9a9d14eE5h/2rbb/qKdcOI3TFZ
	 el0rV/HW59Cw1oOgWCm6hmxm7WEZeFwtfXvSN3aqWX+X5KKmKnFTYVXGWVci+CidBtu+9
	 NCSq7aK/gEk41Dpu7FMWI+5bHc47seAx4A0P2b2pZjbdWICV1FDA1QC85dl/jD4d0RxsD
	 MFeMls7moBzOUOemfrzfUDxBwy7M6yfephjIbnL+GMJufSjsM02BAQ4ysOHngddAqH/Nn
	 fM7N1zGVM7LN6PPEYiTbHde08Yb7RA9cD+LGvIr7volhUIHT7oky2nsN/ETFbeSUgsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783828;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=W33ZWbAqogJ53umhTfYSfZyh9+/3Wp9/3r8GuyQJTHo=;
	b=kxmlOEAoZF/LiNQ7ZBR0Jp82V6FxVC/Oz6Vlf4qSS7nCYnu+Skb37orgPK7kdzggtcpt
	 OS3qQEC+Lfvhka3KrKpnHj4t2l1m6oXscJWhxIrTYbl4/N55d9BIe76gm1QS6oUr8zQBW
	 29wyiC9ImhEgJUezQyK0aIuwAusk+V7JZcVWsms2AMocSnY/ivTOBM3lqhfnldw1qrFkx
	 c9jTMPMOaw56/SMjlwzOnxZ7zvRvU+zLa2xByq5EKucsd4skHp841sGnIaoP1wXiDisOl
	 eHn1Zk+tm8ddZlH7vd31q6m3R9fzzQNaeC8usrQVVzN4X+vxQOivE7RDkptKxEc+KCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AirIuTDj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C862606A324;
	Fri, 27 Nov 2026 12:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AirIuTDj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4891F1F00893;
	Fri, 27 Nov 2026 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795783827;
	bh=W33ZWbAqogJ53umhTfYSfZyh9+/3Wp9/3r8GuyQJTHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AirIuTDjfRmTVGbK9JnkyMy8E7eo/GJzZRq6q9zZ1QriAI5LEXxLatau5rUsP0ZvK
	 fGqi5id/In9k2+a+86QnYvRJ1byLqiG6zKOA3fcUHRvFaHWKcQBYTa1pbeMnBbBcGA
	 ktwgzM22czpKsVCCUWI2XEsguGJ2IFpuhWWiHfMvKtt/3VLZibK/WakTB0LgdvrwdJ
	 we2BZOUKBrWEJ8NKpoPh5V8cOuz6CR/iMpP/o731SHG5Ed/8AfzA6HooEgL1miqWuL
	 znaMPoqy1G4sYY0VqnZbzroe2CE4NqaQKU6U9xaFRM2T7ielA/ZfY5B2oxNg4TCWeV
	 /Iosxnb5pZw7g==
Date: Fri, 27 Nov 2026 12:50:23 +0000
From: Mark Brown <broonie@kernel.org>
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: Frank Li <Frank.Li@nxp.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [RFC PATCH v2 0/1] spi: fsl-lpspi: add atomic transfer support
Message-ID: <2353f854-7cc0-41d7-a1db-37d6f72e4c8b@sirena.org.uk>
References: <20261127073454.351296-1-chunyuzhiqiang@yinhe.ht>
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
	protocol="application/pgp-signature"; boundary="Wp/eDE65bMRInR4B"
Content-Disposition: inline
In-Reply-To: <20261127073454.351296-1-chunyuzhiqiang@yinhe.ht>
X-Cookie: Sank heaven for leetle curls.


--Wp/eDE65bMRInR4B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 03:34:53PM +0800, ChunYuZhiQiang wrote:
> This is a resend of the fsl_lpspi follow-up to Heiko Stuebner's "spi:
> Implement a atomic transfer as a last resort" series.  v1 was based on an
> earlier revision of that series and no longer applied; this version is
> based on current broonie/spi for-next, where Heiko's v4 is applied
> (for-next 63083539d2bf).

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--Wp/eDE65bMRInR4B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmsJfI4ACgkQJNaLcl1U
h9Bq/ggAhaW3p2gDhiNaCetn04LlSdl1cazk/E6ADdSZ8g08WxgJSNxRrrQhOMqI
z5gmc6z0ul/a1ZXPCTq7Kex8PrdmTqxTxc5QF/kiMA5B3JTUcvCuqnUj4Gonp+k6
X5mbgV9RKlxnkX2vCxFH4RlM8wLbq2ypJkHMue7Ax4PbzEf7PCpR4bx8Hg4kOQQ1
+xIx9Noo0+4ZBSqU/+H0Sx/P46WRclVm7PafYucz/8l3h42L0hqxjuKUOBvyCMtJ
xxTXs17dchB9X7anOsXahtDUOOxWwjjcVZDPDZN3OYi8zyciHwL9KPNJ/uUkV4LO
OLqW35ipe9Q8b1sqjQ5FOj5HeaCdDw==
=t356
-----END PGP SIGNATURE-----

--Wp/eDE65bMRInR4B--
