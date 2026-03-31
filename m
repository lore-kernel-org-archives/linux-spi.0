Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58908377EA1;
	Tue, 31 Mar 2026 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981257; cv=none; b=Ld1VBeH+9MxwaRz/HebwhEEZkizyhCzs3ve0MW1biSbLuES8UGfYhEyXc0BYIDlrFD44HZReJY3MN5KxTzr0R8ZU0Pslad4EIJk1A5FmYxhcTgj60U+2Xpnqns06GYVcp+8RpXQgQ77gl0s8FHMWY30lraYDHsqPMdtgf0xO2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981257; c=relaxed/simple;
	bh=CBgARRlVWed3kCKDRoyC8jPqo4/RyFJxFCWwBT5dEwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql7WVKba9tnnITVIrnnz/KNxs26GDTQDqYIOmImyZV7q4oUCBDgHZHKbPqUYsI7v6SxBlK2AhwGwiX+Ml5dFnaQh4AXTRXThtUtDegS6DZFo7r2ave0mT/ZpL18v68DGbHFiwu7lm8sifVDhQYU4VEsjGWCWAmzzBSksF3nHN6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYDtD0tE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYDtD0tE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CCBC19423;
	Tue, 31 Mar 2026 18:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774981257;
	bh=CBgARRlVWed3kCKDRoyC8jPqo4/RyFJxFCWwBT5dEwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYDtD0tESu+d3r8edy+MqAy86myDyr2EF6gnBXcTwBqE621YlXRUck25opQwx0gUI
	 cTxCGxrKXooe5Pr1dnBxATt2K0L1DXjPFxAPpZhPXQC5io1KecJMuDW/53NFBqjCZq
	 msblwZ1+pJ9UXyU4Oitv48DX9aelrnypCKy/iae3BQl8L+6AISAtP64anipzWCWaxN
	 2mznUIdmTCzDa66+RARdwTYyDBSYur5CWePBYqIVciV+BrT2OgET3xEo8JVkQ91blg
	 ftI1+/Vddt3z1AdB9syRPs8KHuYbbVpPZvNESB78MOgooPONm8Mj/3Wj6qOSNxxhYN
	 kGbKmU1caqJ1g==
Date: Tue, 31 Mar 2026 19:20:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Frieder Schrempf <frieder@fris.de>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Han Xu <han.xu@nxp.com>,
	Eberhard Stoll <eberhard.stoll@kontron.de>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	imx@lists.linux.dev, Santhosh Kumar K <s-k6@ti.com>
Subject: Re: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point()
 for each op
Message-ID: <e1c26f7f-4b42-472a-9277-4137bab3a068@sirena.org.uk>
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de>
 <20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de>
 <87wlzlnioh.fsf@bootlin.com>
 <a1a711c4-d9df-4bba-8831-2ec787f84cc4@kontron.de>
 <87ecl09wtv.fsf@bootlin.com>
 <633fee13-a397-410f-a595-db95e04b8110@kontron.de>
 <87ldf881gr.fsf@bootlin.com>
 <fed5fba7-0536-4f92-8372-f4b47c89b1c2@kontron.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LGSmH2tZI7RnT4J+"
Content-Disposition: inline
In-Reply-To: <fed5fba7-0536-4f92-8372-f4b47c89b1c2@kontron.de>
X-Cookie: I just had a NOSE JOB!!


--LGSmH2tZI7RnT4J+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2026 at 07:57:21PM +0200, Frieder Schrempf wrote:
> On 31.03.26 17:26, Miquel Raynal wrote:

> > I am sorry this is not going to work out. There is no such harmonized
> > speed, differences can be an order (or two) of magnitude different, we
> > do not want to pay the penalty of a very slow identification on all
> > designs. We currently do the read several times with different
> > parameters. What if we were trying one more time by cutting the speed by
> > 2 (completely random proposal)?

> If we try with reduced clock as a fallback after the other attempts,
> there would be a slight chance of one of the earlier attempts with
> normal clock rate returning some invalid data that matches an existing
> chip ID, no? Isn't this a bit flaky?

I'd worry about single bit errors causing confusion between related
parts from a single manufacturer...

--LGSmH2tZI7RnT4J+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnMEIIACgkQJNaLcl1U
h9ArkQf/f6yrd48WurJb0BOBvOmHaKF6dQhorCA8m0joU28cLq5oHLG/FGMH9ArA
7AWglFhekbHcJcwdhWOyF0YfVYeMMCACUgzwonnX9H3FID1wiugRQwHafRgThazL
Svu/ffYJsu2/wPyXBdL1YKdBOw1izqqr9viYJYcJX87eUnbr9yhw4lTFctAdG0GQ
oaVAilcutmC56yl3+I3m9CedvcIeY3lwSx7TO/C51MQ0t3WFJAhlpjCBOMvqSEfS
080e6pduhnuivP1ZiOVF9GEuDbBYvRBBX2WdHbUqQ9Mo1KxR9UKwiodIDSWPpSr5
BlDYbNEm5xuDQB8Q15fbZfu0uIgVUw==
=xbfN
-----END PGP SIGNATURE-----

--LGSmH2tZI7RnT4J+--
