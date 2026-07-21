Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A5148AE20;
	Tue, 21 Jul 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646358; cv=none; b=rUE7bT1eWKG8shflAmWtzxpNuqCu4/9wyOF5SI3TL4Svju2yHg7kxgivTW+xgnbvG+H+UO4Cw0wT2Zw06E/PJ4xWAJAwkX4a4GvTQiDdE22/o56lT3131mS3egphEIoNhXvxMaYBRXKJ41FMZ1tZOiXBCFINwk8e4MiF1stR5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646358; c=relaxed/simple;
	bh=AwFxN7jwsBt7dVzEfnNwgrj1Ql2aMQV9qGCsMPaOOt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOV2EjMYhiHcg9bkIU17j7MQ58CGLxh75QR4k6PXn1aBOrh7KXGk2Dh5SXkruuXZuWjtDOPWVo4W4MuNG6+hmFALjyL/4li5ZmMGzK6hTzxEoPBVDOXFmZ1ozb+UfTwYT9DpuBithjP1YEdi6Jps1gekQov/w//5MbB+njvJ8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BC81F000E9;
	Tue, 21 Jul 2026 15:05:54 +0000 (UTC)
Date: Tue, 21 Jul 2026 16:05:52 +0100
From: Mark Brown <broonie@debian.org>
To: "Shih-Yuan Lee (FourDollars)" <fourdollars@debian.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 5/7] spi: pxa2xx: disable DMA for Apple MacBook8,1
Message-ID: <f7449a69-98e3-41c0-b535-847b8c520e10@sirena.org.uk>
References: <20260720162117.32304-1-fourdollars@debian.org>
 <20260720162117.32304-6-fourdollars@debian.org>
 <al81PmK1UMr2g8p-@wunner.de>
 <CAAT15mPuO71WbbS2ZpWjceCVj3FUTqHLi3wbbeV7B33JHbPRsQ@mail.gmail.com>
 <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s+v5GOHrlcTy1tFO"
Content-Disposition: inline
In-Reply-To: <CAAT15mPrwAqLmFVF730G+iJugzNzaT=HDj_7G5-wXbhBNU7ANg@mail.gmail.com>
X-Cookie: Love America -- or give it back.


--s+v5GOHrlcTy1tFO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 10:34:20PM +0800, Shih-Yuan Lee (FourDollars) wrote:
> On Tue, Jul 21, 2026 at 5:26=E2=80=AFPM Shih-Yuan Lee (FourDollars)
> > On Tue, Jul 21, 2026 at 5:18=E2=80=AFPM Lukas Wunner <lukas@wunner.de> =
wrote:

> > > It would seem better to fix up the incorrect interrupt number in a qu=
irk,
> > > rather than disabling DMA wholesale.

> > I appreciate the comment. Based on the Bugzilla feedback regarding the
> > incorrect interrupt assignment, it seems fixing the IRQ value via a
> > quirk is indeed a better approach than disabling DMA wholesale. While
> > I am not certain this will resolve the issue entirely, it looks very
> > promising. I will investigate the IRQ mis-assignment problem further.

> 1. DMAR/IOMMU Validation Failure (Error -22)
> On modern kernels with Interrupt Remapping (DMAR) enabled, overriding
> pdev->irq to 21 causes the dw_dmac_pci driver probe to fail with
> -EINVAL (-22) during request_irq(). This is because the
> DMAR/IOMMU strictly validates the PCI Requester ID (source ID) against
> the GSI mapping defined in the ACPI _PRT table. Forcing a device
> mapped to GSI 20 (00:15.0) to register on GSI 21 triggers a
> source ID mismatch check, which the kernel rejects.

That really seems like something we ought to be able to do, though I
think the idiom here is to patch the ACPI tables so they are correct
rather than quirk things in C code.  ICBW about the preferred approach
there.

BTW, if you're using a LLM to assist with analysis please don't just
paste the output into mail.  Instead make sure you understand what the
LLM is saying and write up the salient bits.

--s+v5GOHrlcTy1tFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpfis8ACgkQJNaLcl1U
h9A/Jwf/eYHpxryTrHCddTrFIUNz7LvUUxhGxZ4knGvwVXrcgJ23YkKhjWGu7jdo
0NHBbeiGzMapATOMDU9uDCvNaaAU1ZFEv2PMR32qH1spfW8JfAvFlp2OD8hMV/pT
4gJBi7rQKlF6e4P06WVbhK2eT4A5s50JrXHGsgb0bvA/mGlDSZasW5MGsP4jeuye
Kd4obEoDBzyJGSa9mIujWriMgzx7eQtVf3eQf+iPBme4Ob43Sq9d7L1U9hMyXnAj
mOk9WGotauzsGtOwg8VF5CJ3Wa+9CE8zKb2MAjAFcY1SSaC7sU+AU/C79FbtuM3t
n0Ya1PeYfqC+UtjmKH+9hZYQ8cFO6A==
=xz7r
-----END PGP SIGNATURE-----

--s+v5GOHrlcTy1tFO--
