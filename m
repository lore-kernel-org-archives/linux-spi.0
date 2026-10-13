Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88110415B8D;
	Tue, 13 Oct 2026 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791929414; cv=none; b=NzKs5IAKll3y+YxgvlGhi/0ij5DA0qhqCUBbewb5HhRpCiSLoeiKftI3BPOqor/Atxz00K4q3PAuhuYrjlWrfcthCn6nFt2PO/epRsBpCAq2qlBSkxUeIlhDkdR2bYPNLLbmYd2Nvhvfcd6Fen5ckoz1Ff4ruW4LCDNvIJcIcRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791929414; c=relaxed/simple;
	bh=RWkMtynZxJyaD0r8fxVdAZVpWqTNJMgs9eWfNAjx01g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkg1WAT4qQjDS0U1ehzLj7Vcn2B3BFtUElPFl5/n78kJYoIfsvwf1PfESu7lCeJzsfWGhoiZQ3Ty2nj4WyOfJJFlRFqE4OM4FuHag62hVGW+3EQit7qK2wzrm5k+nxwoBRNtRae4fCxidhixtWUeTGVNmO63owE/hOK7/IC/IaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+Eshj8V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+Eshj8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2021F000FF;
	Tue, 13 Oct 2026 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791929413;
	bh=X/RsM2Ek4zZ53axGZAyenVk3blcnKjokWtjpwX3I6+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g+Eshj8VmAVzH92w4Bde1RZficE6gJJiXdbIjKKHVQBMbvb6AhSkuF99HJqelj7Jj
	 ysZsDmS6VEpxBbMOdpIzmX/9s1d1wMzAx8/cXbN6NJ//1BYi0im1JEzFQC3MaARO0y
	 brefhnDDFg9axFJxKAxO79ToTq8/5YDxD/1fqLz4CWCtfuajDANkytXUD4lO+krD8I
	 EP0TCDYZmXd7R6m9TFCI4aDhzuqdUJx5qgeBVZt+ysPkRHIi28n7U4/k86KlqUFXA5
	 KEJNM6Jval3shB0Nqx9FWmVhgQITxGkZZ5Tm+hX0uLlUdBzLHSWYK7x6zT+gBizj1y
	 haIxi3dKB1c/g==
Date: Tue, 13 Oct 2026 23:10:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dw: Fix missing smp_mb() in dw_spi_exec_mem_op
Message-ID: <f4fe920a-7b2b-4c6d-bf41-a7935e6e5574@sirena.org.uk>
References: <20261010151529.30590-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y+zpgi+VOfE/ZT/n"
Content-Disposition: inline
In-Reply-To: <20261010151529.30590-1-jszhang@kernel.org>
X-Cookie: Some equipment shown is optional.


--y+zpgi+VOfE/ZT/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 10, 2026 at 11:15:29PM +0800, Jisheng Zhang wrote:

> Similar as commit bfda044533b2 ("spi: dw: use "smp_mb()" to avoid
> sending spi data error"), we also need the smp_mb() in
> dw_spi_exec_mem_op() after setting up the members in "dws" to ensure
> the data change is visible for all CPUs.

Which other CPUs are we worried about here?  Unlike the regular SPI path
which can use DMA and interrupts for the exec_op() stuff we only do PIO
and have interrupts masked during the actual transfer.  If the task
migrates I'd expect that to have all the required barriers, but
otherwise it all looks single threaded.

--y+zpgi+VOfE/ZT/n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrOrEEACgkQJNaLcl1U
h9ByHwf+JseUXHmXgzdaK2j+8Yl/r0QRuDG55IsoNcnWoOO0hv53nvA63UrGvLHX
OIWcvyFlW6uIfCEwJd88ssBqoT38X/ARabke1EFjjVOFf9zefKPibMf3yGHKruWW
45HrEU+NTaTDObYNIxGZ6ec0hRew98YjmZHrkg8LzExEi5U8qxSvV7cS1q03maY7
Aj9Hp+pIhTpTY8RO1rsjlK/ljCKF6T0qIwBqDCkdoeOU5DfKs+BFEuHFhy5jyVSp
be3RMfWPxk0CD9X9KCDSFB/EXli9K0qThwuidcT6uZC/k+hwZv/2LVxd4ij8eyOy
cELOQ5KIAIf9JvrT4Cn0kTsrGcpg2Q==
=aGTZ
-----END PGP SIGNATURE-----

--y+zpgi+VOfE/ZT/n--
