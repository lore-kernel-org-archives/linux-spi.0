Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3E18D636;
	Fri, 27 Mar 2026 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629868; cv=none; b=csiIIbPOeQe+YZDax/L3pguEApuMevbJmc2EhYCPMeTZPivi+a0aDroef8F+mBappEAqsd3kwvaw4MuPxCd+iHz35RcgmoeveEyTbFFoIzqr3RGOwW/lFRwPih7UmFplbH2+JtlQ2Qeu6YNZ+WdqBxmGlaM7ilCY/5+Zl2J0P0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629868; c=relaxed/simple;
	bh=SE1WhOqQPUMFE9Thv1jjp1Bu+KDf4pBHRInpLkIaOJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seWjkKvS3FV4vveiz1gzTopwNtuCKVCLN1nOr+R1B1i9CvLkvcPi6EtAmETk8tCDUhwnLQScxkkclbbn4XuEZ/E1bJzUl8n514GT6G6J/flRyH2aKkjYi4sYY0TlO4zWsS9qAT1HZwKVp1i+aKo8XYD5m7Vjz0i3J7KNr8uVutQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpmE6PZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpmE6PZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E07C19423;
	Fri, 27 Mar 2026 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774629867;
	bh=SE1WhOqQPUMFE9Thv1jjp1Bu+KDf4pBHRInpLkIaOJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpmE6PZaehyOWJ3puS8y1OQDnKePm+ZFPGFHoMlXwLsdGcjqIYvs7ZF8Gpn2OGcPL
	 JbWlW73o+tSVoq93TKg6EpmS5TgyXoN3oVFEVhywGRYZSLk4WjbtbkrRgFXk0v/zF7
	 HE2ZwEVpmLFrihgwxs3fcBjbg2x5Ary1LSXvf/CLJ+tLgkh4Os/VfVROtHGBCBEJIe
	 P+tYU4BqfAYTDy6ZWQH3QNZF7u456SaL2uo2E/En3gIMMcqpFW/3OQfj4v84wBMpo5
	 oZHwdrUhkkL8SpymtmrXb4uC5fTlWhBjnRGDRZDp/73KzKvMuZ2vCLDVlqdKa4m/gQ
	 HFnRaPGxeHp8g==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 34DE81AC5731; Fri, 27 Mar 2026 16:44:24 +0000 (GMT)
Date: Fri, 27 Mar 2026 16:44:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Johan Hovold <johan@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH] spi: fix use-after-free on managed registration failure
Message-ID: <acaz6J6-5Cstxu8h@sirena.co.uk>
References: <20260325145319.1132072-1-johan@kernel.org>
 <acT9-MoL5zfss8Hp@ashevche-desk.local>
 <acWGuheUdu4Bdb8S@ashevche-desk.local>
 <e8588793-02ad-4339-bca7-fe55db697e89@sirena.org.uk>
 <acYvqDTmQljmzXcg@ashevche-desk.local>
 <acZED01B-WdJbr2D@hovoldconsulting.com>
 <acZFnCmcA1UK0xRw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cTedQMO9bRMoQAar"
Content-Disposition: inline
In-Reply-To: <acZFnCmcA1UK0xRw@ashevche-desk.local>
X-Cookie: Identify your visitor.


--cTedQMO9bRMoQAar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 27, 2026 at 10:53:48AM +0200, Andy Shevchenko wrote:
> On Fri, Mar 27, 2026 at 09:47:11AM +0100, Johan Hovold wrote:
> > On Fri, Mar 27, 2026 at 09:20:08AM +0200, Andy Shevchenko wrote:
> > > On Thu, Mar 26, 2026 at 07:25:14PM +0000, Mark Brown wrote:

> > > > Not intentionally?

> > > I don't know, but it allows to start from fixing the users to avoid regressions.
> > > I'm fine with the current state of affairs.

> > The offending commit is already in mainline and hasn't been reverted in
> > Mark's tree. This fix has been merged there though so nothing more is
> > needed for now.

> Ah, I only looked into Linux Next (without looking into the base, which is
> v7.0-rc5 as of today). Thanks for clarification.

Oh, that's a relief!  I thought I'd managed to throw some commits away
by mistake.

--cTedQMO9bRMoQAar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnGs+cACgkQJNaLcl1U
h9CeXQf8C/8M3D3IHRqmsVVVh3iiuWzlHf4LpxH25aLf87V/P/hahkNqtf1vsJ3q
Nl7yMmC9bSNbTw3tGffMSGEFFGOZ3RoNdrSa9p7kPbCyTgITORCt1QUeodc1eRDQ
biRrZ136+LACpmP1K5WI78EUD6N6jmGB1/PazJphg+0SJusO0mNADz3AeDh5yRRG
z0nNYS3ou56JU42xO4g2VasTxlnqEB7EVyd0+RNNjpoSUxvlVA7EzGQUQx6BQn6V
FJC/ZPyNLj+enhGZ7s9EfxjkKAwGrMPICa3DS3742nBqoBVjZGxLQ8eLY0uELJ/N
10ZHcWZCUJwNO9xh/eSSDLqZPJHSdg==
=zZtw
-----END PGP SIGNATURE-----

--cTedQMO9bRMoQAar--
