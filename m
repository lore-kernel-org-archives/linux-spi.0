Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326650;
	b=ePfQ1JIu7WP1BMPymK7vzJbLnWbDtPS5nQnq2MYLteKy5SH2JbNPrp3lGYQXWUmpl30B
	 +vpSxVDUFrRgc7L+p3lj1z90YiBgGmX2FV5CIFlOt9XKhxqDVXbR+YTyp5Qvqp8lIIRxf
	 ToztH51orK5etCl4B839lmOiUfhaPbzrClZ/RGi9jIjY7yBFFxTJmxyQXy1tu3TAALyqd
	 HqE8qdusjatLZ8IUi10NsGKVQa6hY3BChtVXpQNoIV7Dr4cmsqASPkHeuH3jgynPBWHPn
	 /BCJDkRwGX037/OynNepBrIllbYfcag6D/tr8WAcWxb3bvfy51j0fKq1YB56jmNMDwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326650;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=xKekDk65ciGsHWTkKV1pMmbrXvFgDyBbXHhz+tAUJ3M=;
	b=m9zcRaEXxrot7xir5LzZNGD/p/xWNDC5fLPvaZhDkutOOTXWekxLSJ97t60Yy+4iiH14
	 d5CVH1/+Gnwaa6fdQyHdV2u9UP/4zRkKHRHDmx/bbANBt6n9PJi8u2qViSOQyff7bBtUw
	 ThCdKGx/lTxt7xUfYZFDyj4vzNRm0A3jJUDA/P/I+iISa/J8ZCzvmPP724073aFi4nMXp
	 1hMMPIZVBdNN+P/Hach0vfCdJe75kDJVdcBm09LV9zkg2wpatErpQcarZMeacZzp2Y0VU
	 ak2xozPLE0RMtAv/fPrrrszR4zwl7EFbvEg7a1CKvpbv8KUS6iqvhmBGCbtpiCL8BCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIA++qQz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54853606A323;
	Tue, 10 Nov 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIA++qQz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA32D1F0089F;
	Tue, 10 Nov 2026 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326650;
	bh=xKekDk65ciGsHWTkKV1pMmbrXvFgDyBbXHhz+tAUJ3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AIA++qQzu27iDtqtghDQXe3eEMEtfW0pUmP1pw87hOPcbha/du/cYArpw3l9qOsQr
	 u6fuI8ol3G/cmTB7H0eq3cIZXkNRoak+psa1ttDOEBXrQ2XqbhBAzb6+Xi+xLPBqJ+
	 vdq62d3xZ808Gpm3yT0qE39ickLYELwfVwHjod2sH/2WuJQj1Wmcb1zuVo5IpVsHpN
	 fzsAA5EiJ77pKhwrDbnizdsWb2eW+bXCHwWYertEV0c1pCWX1KA4ZPVNfgsXCDcNmM
	 YfPXVjPGubGdfRRQWNMfUcJmFhhL2khzvsZ/cpado/dtESG+T+jyf0Hf9KhV/VnCkK
	 AHgdAarCDLtPw==
Date: Tue, 10 Nov 2026 16:04:06 +0000
From: Mark Brown <broonie@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, pjw@kernel.org,
	samuel.holland@sifive.com
Subject: Re: [PATCH v2] spi: sifive: clamp the clock divider to the register
 range
Message-ID: <b3828c22-e7ea-4858-96b3-51ecdfee3a89@sirena.org.uk>
References: <20261110225741763HzyrdGiR7ZOAU1NiFmCCZ@zte.com.cn>
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
	protocol="application/pgp-signature"; boundary="ris94nVe1DPqFLM3"
Content-Disposition: inline
In-Reply-To: <20261110225741763HzyrdGiR7ZOAU1NiFmCCZ@zte.com.cn>
X-Cookie: You can't take damsel here now.


--ris94nVe1DPqFLM3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 10:57:41PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>=20
> sifive_spi_prep_transfer() divides by t->speed_hz, which can remain
> zero when neither the device nor the controller provides a maximum
> speed. For a nonzero but very low speed, masking the divider to 12 bits
> can also wrap it to a small value and program a much faster clock.

This was previously part of a series of five patches, I see you've
resent two of them as independent patches when I was expecting the
standard workflow which would be to revise the series.  This makes
things difficult to track, I'd discarded the old version waiting for the
new one.

--ris94nVe1DPqFLM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrzQHUACgkQJNaLcl1U
h9B8tAf/WW4JG4AfkqK+sYp6AE8ZYaj60LYNZSkeWChcZGOTaQE/osIvlFkxcZ6W
M+czT7towwaX009L5ftrxgXGY7174plvvZn00TiNaiCLFxN3DxehTVLZDR19P2Pm
3imwmP5nt4B7k5HD4P/0DUnitMuFyKz8HxwNN25qieX94aYnfIdphFn0PGsZbtVY
1FWhLrVfWUAZFzIy/AU97OWp+2I3PGQ1za5MJmEY83lsgf/yiFtYqqtReK5TkdU8
JkPDTCDGpWsW8kw4mh6uwFTnimbyPNYXohW/4chQliouicGCnCo90RwS2rAnr5sS
QBYzgJfkucGlInyzQS6qtHeeaWYL6Q==
=aqqg
-----END PGP SIGNATURE-----

--ris94nVe1DPqFLM3--
