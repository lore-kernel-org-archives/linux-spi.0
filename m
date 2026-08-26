Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5153F3B14B3;
	Wed, 26 Aug 2026 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780625; cv=none; b=hJ2ED4S/YCNm0WQzrwDdkAhzd8YrXRFb3mLLQqXv4Sv/04PFyu9E1QF47OiZraZA5cvlNNgHL1zwbEn6NVHw5GJPV0Z2ZRWunGDmZ6TW8rsopia+cVVZygnm1UpKgIjQVE7u1HcjkA9Is70fPe5wT75QHVBiXw/lu/CasXhEujQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780625; c=relaxed/simple;
	bh=KodbtscHuhyT4e9uaCejK1SwHL6vJcWIU4ma3ia0xtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFKNZlNEnsfYDMQKu6+u1VvN5G4u37RZb5CLffOzEX74P2xlhv86BvgKwtFq6PIbT4Eu1YJQXbv5djfb6mAZG7b1uOKFomDCSoDMZc8P3eUveeLnZhQ/NqxpyJ6ciUQ3+vW6ch95M66Mioii1BZIvVfsdMG1LTmJDcApF2LXTyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChqqMJa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChqqMJa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D011F000E9;
	Wed, 26 Aug 2026 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787780623;
	bh=PSSo4bsAC2cEjTDtAnRZIQ9NfAW3QdjZrYCnvuLAkE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ChqqMJa3vxAiQad8g3dw8iasniT73h2asuuBLUzmnNANnaUP31o+KyDZuOY0hQQnl
	 zLsEAHlr8uMYX3p4oSKLfjQocnhfkDYH/F6ZyJRg8KM05kmGKdEyiaIPPoMPieiB4j
	 L4dXQO7wnmoNHCJCrEoQtICccHRvv0ix+og7ZY+w7eFblO2IZXSzL3poAsP8kEQt+v
	 jHCKPMZMYXhBFNsQyCoUbJCEIAMipli3CTwlvrV50S0JF/9WW1sjl4ahjBEmHHHilX
	 pZE3mp3iCJBd0iYDyqbt6mlLXWULkkl5JsyDsgNpP2076JFQ4gm73DXIbD+p1CdFtd
	 YLUD5MdlyMjnA==
Date: Wed, 26 Aug 2026 22:43:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	pratyush@kernel.org, mwalle@kernel.org,
	takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, praneeth@ti.com,
	sebin.francis@ti.com, u-kumar1@ti.com, a-dutta@ti.com
Subject: Re: [PATCH v9 08/18] spi: cadence-quadspi: add PHY tuning support
Message-ID: <8aac0c42-fad5-4146-a2a3-b60bdab71a20@sirena.org.uk>
References: <20260825171737.776052-1-s-k6@ti.com>
 <20260825171737.776052-9-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nryroxhrKHKI4MVn"
Content-Disposition: inline
In-Reply-To: <20260825171737.776052-9-s-k6@ti.com>
X-Cookie: Obey all traffic laws.


--nryroxhrKHKI4MVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:47:27PM +0530, Santhosh Kumar K wrote:
> The Cadence QSPI controller supports a delay-line PHY for high-speed
> operation. Without calibration the PHY is unused and read capture relies
> on a fixed delay, limiting throughput at frequencies above the base
> operating speed.

> Add an execute_tuning callback that performs delay-line calibration using
> a known data pattern written to a dedicated flash region. The pattern is
> either read from a NOR partition identified by the DT property
> spi-phy-pattern-partition, or written to the NAND page cache before
> each calibration read.

>  struct cqspi_flash_pdata {

> +	bool			use_dqs;
> +	bool			use_tuned_phy;

The AM65x has a fun erratum i2189 which mentions that it requires=20
disabling DQS for writes:

   https://www.ti.com.cn/lit/er/sprz452i/sprz452i.pdf

which suggests we might need separate controls for read and write
operation.

> +static int cqspi_write_pattern_to_cache(struct cqspi_flash_pdata *f_pdat=
a,
> +					struct spi_mem *mem,
> +					const struct spi_mem_op *write_op)
> +{
> +	struct spi_controller *ctlr =3D mem->spi->controller;
> +	struct device *dev =3D &f_pdata->cqspi->pdev->dev;
> +	struct spi_mem_op op =3D *write_op;
> +	int ret;
> +
> +	op.max_freq =3D mem->spi->max_speed_hz;
> +	op.data.nbytes =3D sizeof(phy_tuning_pattern);
> +	op.data.buf.out =3D phy_tuning_pattern;
> +
> +	ret =3D ctlr->mem_ops->exec_op(mem, &op);
> +	if (ret) {
> +		dev_err(dev, "Failed to write PHY pattern to cache: %d\n", ret);
> +		return ret;
> +	}
> +	dev_dbg(dev, "PHY pattern (%zu bytes) written to cache\n",
> +		sizeof(phy_tuning_pattern));
> +
> +	return 0;
> +}

spinand_write_page() has a multi-operation sequence, I've not checked if
any fancy flashes with DQS support actually need that.  _read_page()
looks more straightforward.

--nryroxhrKHKI4MVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqPXgkACgkQJNaLcl1U
h9CVpgf+IEFBtsEfC8voVsHpmOfwjvGr+ozW/f+mGll/kPgYXkUFR5UgVC+QMaF6
3S6zPGMFpJNRm4DAo3iIaiXXgiZ7DMkjr7Q7ougvDy7JVJWv3csUMu/RKZIy++Dx
o2K1Da6/W4AzDrQExhVklMLQpa0wTaMav8FeEv23oOvFqPmwPBIryDzQRUB5Xz4Z
MCPmMvgG8wCXG3bPk/Ueigap6FXN3Xh7dVR9PEFEnYVrxj6DD4ladF9bc6GGd25x
4e/rMV2ra6P84FeUryMHBpbXwAv6/tq2UZS3Tijf6bF17giPvx2EAelgwdpA9OCg
a/Fbtj+DnJpFaO8EnzNiYorzzawsQg==
=f6hj
-----END PGP SIGNATURE-----

--nryroxhrKHKI4MVn--
