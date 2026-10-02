Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85D3B7B71;
	Fri,  2 Oct 2026 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790944841; cv=none; b=nLglGcYgEKJOqYPtMDrG3IqeOxGAm46UPxGGTaYemKao4CRr7anof+lw7O+scuBltCpfIPkwqFFN7q9itniZZf5ARrSniAKF1S4ueER6KOB2fpyciTFCc14oPRPVnwavv17u6zfp9acUcQse67jCiCdRO3zj+Tts821v8ms6AVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790944841; c=relaxed/simple;
	bh=s1gulnzluPiok9Rawn8mnR7pCPg2h0p8JL5VA+zMQMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWDUe+DlypJkg5udqrqf0rTpYR3omPjF7Ge87YVjqtNvmNSBHj7ErO0J2hSX5/AdxcmtxDJyepvYPK4LVgH7S8fW5JgwsPrg/bIn6NVI3P1ZeJxXh2/gWutmI2bRi1wCanEvp14yUM6kL+Yt8EKwq5a99tA50obPJFt8uHBIrgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if6BYcUj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if6BYcUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58D31F000FF;
	Fri,  2 Oct 2026 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790944839;
	bh=9rC2i01GD4+v7xYqc2tk0jeF96d5ZYoQKrqPBrcuOoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=if6BYcUjbp4bCzDvjDUhkfwZCQsOcG3/wP7QqCviiLLGsNhL4D3g9aRAbPJlpDeP+
	 oeDX4w9lpw+noPrPH05jvoTLBr3eCUk3pCnb62V9zbg9P8EHQ398FibotQnSpQUwsf
	 S9qf1O2B2dZcB58va3bZLd1Qaf5hNyexpP7/7mF/7eguyhsK6sW0FwTb6OunyfMkeX
	 PPDlOTXGuVkDzawsSiJIYxSEOjGIUyXOeS4ggowMcGa8MCrY57WijlzN0UJ2EQjH8+
	 E5uVrvl6Fp75W1/27Fg4+XpAOPyfe4ZhwYFFX70ry7iXt162N8W5VRfyXpFggVn0uy
	 O93RSNjp/BgAA==
Date: Fri, 2 Oct 2026 13:40:34 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, james.tai@realtek.com, cy.huang@realtek.com,
	stanley_chang@realtek.com, eleanor.lin@realtek.com,
	jyanchou@realtek.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] spi: spi-mem: Add Realtek SPI NOR flash
 controller driver
Message-ID: <70788248-798e-4c10-8f92-cb3670df4c9d@sirena.org.uk>
References: <20260930065945.88008-1-eleanor.lin@realtek.com>
 <20260930065945.88008-3-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V28eu2viibiXNGua"
Content-Disposition: inline
In-Reply-To: <20260930065945.88008-3-eleanor.lin@realtek.com>
X-Cookie: Expedience is the best teacher.


--V28eu2viibiXNGua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 02, 2026 at 02:12:38PM +0300, Dan Carpenter wrote:
> Commit aca8cbecdd2e ("spi: spi-mem: Add Realtek SPI NOR flash
> controller driver") from Sep 30, 2026 (linux-next), leads to the
> following Smatch static checker warning:

You've not copied me on the rest of the series so I don't know what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--V28eu2viibiXNGua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq/pkEACgkQJNaLcl1U
h9C2jwf+P6Mh/524SZqXhl8JoVycpw7UOrJrmDiUrmgoJNvZWEXwvIWgaE/QfSKK
B227Z7sOnrRoaoa3dg8kWP2Qj6oDdHnnEYINy4H16yA1tnl+dmR/+yfEC6vwKFbm
pCJOJDl7CZIfC5kGWG0TZ2uUYlWc0UqmcDFSLcixg+OqYcH/XaJfA77OWPTxlcRm
JyiF/p8L9uthiHridOuS463RGPvPktmNcPbAWXO3Zq55g7LCJ54hc7WBSwtg13Xm
S/SnYNRtULrvyiRf+lizBE4SAwkCZqnMZcV8p0w9yvAQ0tmqtQY3UPrCHyZZFrbk
4Ja/JfAnnLpPRSmpxXZythZo65okAQ==
=Ml52
-----END PGP SIGNATURE-----

--V28eu2viibiXNGua--
