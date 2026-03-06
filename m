Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F7494A0B;
	Fri,  6 Mar 2026 21:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832947; cv=none; b=iWe71HRIx7Xq8CxJ8K/nlqZF6j0gZEpQBXic2nQkuaq5iEPND3Kn/XZmg6yC+NK8QlmTgr4uukcQ+EaCRqZ+8OiuyNGBh0X5UFv+eAmv+5k8eqkb4VOeHrWUcbnIp2xsfR+DvAY6mgnp8j+/HuSal5lz+lWGaIXhyw2Fpu4kr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832947; c=relaxed/simple;
	bh=Kj9A14JETDGXUphRBbH0+IOCbGXuf1CKLG8VFDrkH2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQJlYd9zP5bduf+jh4jRLqG6MhQdevY7OG11fjalB1tC8Hlp/1tPQWfYhwAsoiCE1bUVd8b+aHF0Iy0JaEUKCf8eJs0bHM74lAtNVW10vv8rSkxnL37xiBvMd2E3iGbZZRq5WMAG2PAeOx9TxrxvXOymBwiFbAZ7dDRHB7LCSWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT9/E7a5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT9/E7a5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA15C4CEF7;
	Fri,  6 Mar 2026 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772832946;
	bh=Kj9A14JETDGXUphRBbH0+IOCbGXuf1CKLG8VFDrkH2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YT9/E7a55JCAN3lSB7GaCPLtpG3C9vrtU1OEjtcUeWw3s9jn8dmJKL8FYhDU0u+ad
	 dDM0xpgXJaO3LtTzkJCHtfHRk9WpoNb7d8NEQ4epCSyz7hM4yq9A8/TQuGkLEDsWhZ
	 WzdSlu82X3kM/iVH5fiG2Q9ZP7PwTe8GdnwA4sqe1Sg551Jopz69b+1Gf4K+v5DSi8
	 UAH/WyHtvUS3JmOW01CMmM6UYimWYhZJBNBtPR+n1K5oL8nwKtY0M1xA5/7s9POhh0
	 eh4n+FY+kcPOQH2Wif2LTADQwJpaqKtuQYPpk+PYCXlCUk5hnf0rYgvXeZJUEcf1PC
	 el3ppyJyDugrg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id EA17D1AC6926; Fri, 06 Mar 2026 21:35:41 +0000 (GMT)
Date: Fri, 6 Mar 2026 21:35:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Ron Economos <re@w6rz.net>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	wsa+renesas@sang-engineering.com
Subject: Re: spi: Regression with v7.0-rc1 on VisionFive 2
Message-ID: <aatIrfp7fIznkgsq@sirena.co.uk>
References: <a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net>
 <aaL2WVO_7bl6vNp5@sirena.co.uk>
 <20260228-ragweed-theater-b02967937353@spud>
 <20260228-defuse-extenuate-cf2a90ae66ea@spud>
 <87tsuvh6iw.fsf@bootlin.com>
 <96e93ca0-ea10-4071-99ca-98f7219833d7@w6rz.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GYBZzF7sZnOogeTB"
Content-Disposition: inline
In-Reply-To: <96e93ca0-ea10-4071-99ca-98f7219833d7@w6rz.net>
X-Cookie: Identify your visitor.


--GYBZzF7sZnOogeTB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 01:52:08PM -0800, Ron Economos wrote:
> On 3/4/26 09:02, Miquel Raynal wrote:

> > The other change that could be "it" is the change of order between reset
> > handling and clock. That would be quite messy if that was the error but
> > I cannot find another explanation. Ron, can you please try to revert
> > this patch locally and then move the clk_prepare_enable() of the APB and
> > AHB clocks earlier, right after the ref clock is also enabled? If the
> > platform fails to boot, there is maybe a weird internal relationship
> > with the resets.

> > Otherwise can you compare the clk_get_rate() on all three clocks in both
> > cases?

> I'm happy to help you debug this, but you have to send me a patch to
> the reverted file. I have no idea where the ref clock is enabled.

I think Miquel means

commit c9117602a87c441c4f05a2cc4d9be45c96140146
Author: Mark Brown <broonie@kernel.org>
Date:   Fri Mar 6 20:16:33 2026 +0000

    test

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index 2d287950d44c..d74446f6db5a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1932,6 +1932,12 @@ static int cqspi_probe(struct platform_device *pdev)
 	reset_control_assert(rstc_ocp);
 	reset_control_deassert(rstc_ocp);
=20
+	if (ddata->jh7110_clk_init) {
+		ret =3D cqspi_jh7110_clk_init(pdev, cqspi);
+		if (ret)
+			goto disable_clk;
+	}
+
 	cqspi->master_ref_clk_hz =3D clk_get_rate(cqspi->clk);
 	host->max_speed_hz =3D cqspi->master_ref_clk_hz;
=20
@@ -1959,11 +1965,6 @@ static int cqspi_probe(struct platform_device *pdev)
 		if (ddata->quirks & CQSPI_NEEDS_APB_AHB_HAZARD_WAR)
 			cqspi->apb_ahb_hazard =3D true;
=20
-		if (ddata->jh7110_clk_init) {
-			ret =3D cqspi_jh7110_clk_init(pdev, cqspi);
-			if (ret)
-				goto disable_clk;
-		}
 		if (ddata->quirks & CQSPI_DISABLE_STIG_MODE)
 			cqspi->disable_stig_mode =3D true;
=20
which does the right thing:

   https://lava.sirena.org.uk/scheduler/job/2535610

but I'm fairly sure it's not an ordering thing.  The patch includes:

-       static struct clk_bulk_data qspiclk[] =3D {
-               { .id =3D "apb" },
-               { .id =3D "ahb" },
-       };

but never adds those names back, this means that while we do ask for
three clocks none of them have IDs specified so we just end up
requesting the same clock three times which might be what's needed on
most integrations but not here.  The below seems to do the trick for me,
I'll write a commit log and post - testing appreciated:

  https://lava.sirena.org.uk/scheduler/job/2535662

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-qu=
adspi.c
index 649ff55333f0..7a7f92e9c7a3 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -76,6 +76,11 @@ struct cqspi_flash_pdata {
 	u8		cs;
 };
=20
+static struct clk_bulk_data cqspi_clks[CLK_QSPI_NUM] =3D {
+	[CLK_QSPI_APB] =3D { .id =3D "apb" },
+	[CLK_QSPI_AHB] =3D { .id =3D "ahb" },
+};
+
 struct cqspi_st {
 	struct platform_device	*pdev;
 	struct spi_controller	*host;
@@ -1823,6 +1828,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
=20
 	/* Obtain QSPI clocks. */
+	memcpy(&cqspi->clks, &cqspi_clks, sizeof(cqspi->clks));
 	ret =3D devm_clk_bulk_get_optional(dev, CLK_QSPI_NUM, cqspi->clks);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get clocks\n");

--GYBZzF7sZnOogeTB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmrSK0ACgkQJNaLcl1U
h9CRSwf8Cpx/pOVTfnvXzykKu1cfA2PN0YYTJQ80TYEdgH4JH46NoYv/iJ6U5MrF
JiV5l15xeM1Jw13sLVY/2NefHVohCTgBsXi0dplZcH5zoy6x/0AHNS+ECuDrd6n1
waU7lgNe3grdqMKpfvww8UpvWcpUAUJaSLY/FRK+8vptctB7MBpRyPeGPEOfpUSi
1aaiEy0aGZ3+GNEAz0BqSd1P/Zm7Uz28KHnvrBc4P5tMZ2KSMB4NjLeIez+f3Em2
cdQ7HWBL03Oos27f2lUgxkrFsptp8Dv+CJjOrsjUm/JMHK9EvJeDEGVkQD4q4F09
7F0m+uB7RrQIrk28DEBTa6Tg+V04Tw==
=ovKE
-----END PGP SIGNATURE-----

--GYBZzF7sZnOogeTB--
