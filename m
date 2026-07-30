Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25414302F6;
	Thu, 30 Jul 2026 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424296; cv=none; b=Omvh9qrn+FJlK/5FVFUpyXdH/UbFwWhTlEup1fVZyQw/xMe64e6txp1+8p3g0D89Pv/HCtOEZb25DLvliTj9JzOzVrqH2C2LREpk/2ToOy5GRzujjWHhChvQPcECRGmEZXlrFgyjL3prWU24wNlal5AaSSnwNNgy4K5II0NyNb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424296; c=relaxed/simple;
	bh=F4e4CGdw0hDgS64v42eI+Z7C3vutOaHV8u5ZVMA/5Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYTD07t4ThEOcVeq84ESpifF4ahAusn997xXFfc/l6dId7LyuAV+RRGsjhrDQLizsCELiAqxi70sEGXSJ9elsDbvwhhWb8OXaCxeOFYjS/yHb7fD1KbV1vtPmp8ygN9GSMxXlYxbuakylqYruYkrnBFkfvehog587rrLhdsLRRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpLs/qWP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpLs/qWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944F91F00A3A;
	Thu, 30 Jul 2026 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785424295;
	bh=CHxdDcbjOGlOJGutMP1HQ34hkj4cQTaM3qxD/Kj1olE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TpLs/qWP2a+i8/Inzm92fLUyaAuPx6kegJnbSh+d4sxNsAZYorZuW7X0QYbEwtHHe
	 CO5wJcrvAYCs9bW0BXAldV9X+7kEl9er12f6vdeDZbR+2Gvk6sxm446d4IVWiqm/Bk
	 /7s4kvO9X/3TXfZawASXJKF0+Bpy3zlHZQz5sfhf6HndwgjCBaRNNgcviRMMjG7kGc
	 ckk8azMfr0hrTLyA0t/1m5Orw5zpyWaC6FtRq5+lUB9Zc49nGpZGiGzIZgiLUDOF7R
	 PmZV4zvN9JWDZxD74Eynexcp0RGqXG0xmsvXUTGDbLNvX+AMNQsX9+zwJ6oQJpG/Iu
	 eAUxKDHoO/Qyg==
Date: Thu, 30 Jul 2026 16:11:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: Re: [PATCH v4 2/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI
 controller support
Message-ID: <f698ec65-1677-45fa-bb05-34aa8e092100@sirena.org.uk>
References: <20260727091833.750051-1-cwweng.linux@gmail.com>
 <20260727091833.750051-3-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vI34kSNS08hda07L"
Content-Disposition: inline
In-Reply-To: <20260727091833.750051-3-cwweng.linux@gmail.com>
X-Cookie: In specially marked packages only.


--vI34kSNS08hda07L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 27, 2026 at 05:18:33PM +0800, Chi-Wen Weng wrote:

> Add SPI controller driver support for the Quad SPI controller found in
> Nuvoton MA35D1 SoCs.

> +static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
> +				    const struct spi_mem_op *op)
> +{

> +	if (op->dummy.nbytes) {
> +		nuvoton_qspi_set_bus_width(qspi, op->dummy.buswidth,
> +					   SPI_MEM_DATA_IN);
> +		ret = nuvoton_qspi_txrx(qspi, NULL, NULL, op->dummy.nbytes);
> +		if (ret)
> +			goto out_deassert_cs;
> +	}

I would expect dummy data to be an output rather than an input, we don't
want the lines left floating?  There's a similar thing below when
setting up the dummy xfer.

--vI34kSNS08hda07L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpraaIACgkQJNaLcl1U
h9BY2gf/YLphrDV4vjup9IzsDwXOsd0044IbIv7XUtgTxbr+xyZCitNdL6irO/GA
4H6dME9dkwBCIB0HY1hI4uCH4esj2Kwg7pCfB3HRcgOxRv710hhTWM4oYJHtsZqD
OJx/ajLbhFtToRXoHbFR2UbtOHs37jdmtIVMnM8pSYbxhUEjc2j5f1sdwpSktZBA
7pdwMdHMDVhFxeO172mNdMCDZBQWgSXvoeK0wChkYPGKZycVccNFpSk0h3AJckXs
lqsPXhQw5QVm329UDNe3mxGoyy3jLfN8qJukqGrjtmzE8+JbOPhmW5C2a5EtOUlZ
nvPqU2/12B4CMFv2/xXHDH3SIjWZ/Q==
=2MuL
-----END PGP SIGNATURE-----

--vI34kSNS08hda07L--
