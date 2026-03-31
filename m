Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D211A6814;
	Tue, 31 Mar 2026 02:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923667; cv=none; b=CIaPPK74KKcdceodt8SKfImmyHvPhLBl0EHvsak76+J/kcr0CpxU5T8FCU2eNLm5RYRMhfG1oIZLu4fgu4MZUaamRQeEzMOUiaZsfu9cgqWGjVap9YI7dCv4boQact0t/c0/yyqxj2gxq+9+TQanzRLNSj4Q9sQ4eEMFRcDT5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923667; c=relaxed/simple;
	bh=OPIdoeyuBanT/A41VDNqUhvBeIlwFVeZom5vR1rbSAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgX1nDLOPAJEho0xpmEmi5BrbmF9hn5R8DXNgrv8DECLmOT4THlyXtB5TvUupwhXgUn/d48icTPBX6t2TsOdPels9TxLh0zcC0uLOEfLzj9qFqpXyJFiz6raJntlEVjs/tykPdauL6Ey5ckySiiVcN9zq9b29zKbGglJHrmvFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/D4G1Pe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/D4G1Pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E26AC4CEF7;
	Tue, 31 Mar 2026 02:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774923667;
	bh=OPIdoeyuBanT/A41VDNqUhvBeIlwFVeZom5vR1rbSAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/D4G1PeftBw0sRE1ZbHf+5tIgvJjRSSkBHh4AYQZfYdpmqupRDVHgvbqkVFYsN02
	 Z5+kRif1tAe06Hzso8gN0ixkwmyZUS3vQ6vVxOSeNV87cNgvIznzersdrhhSG4YeJe
	 iDAuqkj5dgTqdoFuYiK3Z4Y0mrpxDxzsCytHV5P1SbnpwwCqC3fvk2bLvSGHi0gtw/
	 T7sapriPAcA2qT3X/NM4nj1FP5NeVMvRp0TESjP47LVxL1ZYZ/c9Cnc/5h0hAuGmvf
	 aXYGaWK7lE8EQdksutqnQRlY+6fJFCq0/OrfNrEJx67t8kCUlbyKF9CNNDnGr4KFX2
	 W6PzS0pgUjzBA==
Date: Tue, 31 Mar 2026 03:21:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"kdasu.kdev@gmail.com" <kdasu.kdev@gmail.com>,
	"bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: spi-mem: fallback to using transfers when CS
 gpios are used
Message-ID: <20260330-maturing-clamor-0dca2a6a400d@spud>
References: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
 <20191107044235.4864-3-chris.packham@alliedtelesis.co.nz>
 <20260327-renewal-poking-7ae0f0345cb9@spud>
 <1bc86691-dc6b-43ea-958b-6bd7db94777c@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Bw2yCtIAFFUtGFM"
Content-Disposition: inline
In-Reply-To: <1bc86691-dc6b-43ea-958b-6bd7db94777c@alliedtelesis.co.nz>


--1Bw2yCtIAFFUtGFM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 08:18:22PM +0000, Chris Packham wrote:
> Hi Connor,
>=20
> On 28/03/2026 07:29, Conor Dooley wrote:
> > On Thu, Nov 07, 2019 at 05:42:35PM +1300, Chris Packham wrote:
> >> Devices with chip selects driven via GPIO are not compatible with the
> >> spi-mem operations. Fallback to using standard spi transfers when the
> >> device is connected with a gpio CS.
> > Bitta necromancy, but why are they not compatible?
> > Couldn't you have just done an if/else in your driver to call
> > gpiod_set_value(spi_get_csgpiod())?
> >
> > For some context, I've been trying to resolve some issues with using
> > the standard transfers code when used with flash devices in the
> > microchip-core-qspi driver, but if I delete this !mem->spi->cs_gpiod
> > check, and add the aforementioned if/else in my driver, the mem ops
> > work fine.

Turns out, I goofed and it doesn't magically solve my problem. I blame
working too late on a Friday evening. But it should work on my platform,
once I get to the bottom of what's breaking it for both cases.

> > What am I missing that makes them incompatible?
>=20
> The cover letter from this series[1] adds a little context. Basically=20
> the hardware design I was dealing with is a bit odd. It doesn't wire up=
=20
> GPIOs as chip selects directly it uses a GPIO and some extra logic to=20
> steer the native CS. On the BCM58525 the CS appears to be driven=20
> automatically (other SoCs that use the bcm-qspi driver appear to be able=
=20
> to explicitly control the chip select). This combined with the ability=20
> to offload the various spi-mem operations means we need the spi core to=
=20
> drive the GPIO=A0CS and use the standard spi operations.
>=20
> I think that check could probably be replaced with some flag that=20
> amounts to disabling the spi-mem ops when we don't have full control=20
> over the native CS.

I dunno, that seems likely to cause regressions, no? Devices that didn't
add handing of gpio chip selects in their mem ops code, cos it wasn't
ever called in that case, would regress. Guess could go through and
modify anything with the gpio_descriptors (or w/e it is called) flag,
but opt-in might be safer. I'll think about it when my stuff works...

>=20
> [1] -=20
> https://lore.kernel.org/all/20191107044235.4864-1-chris.packham@alliedtel=
esis.co.nz/
>=20
> >
> > Cheers,
> > Conor.
> >
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >> ---
> >>   drivers/spi/spi-mem.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> >> index 9f0fa9f3116d..e5a46f0eb93b 100644
> >> --- a/drivers/spi/spi-mem.c
> >> +++ b/drivers/spi/spi-mem.c
> >> @@ -286,7 +286,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const str=
uct spi_mem_op *op)
> >>   	if (!spi_mem_internal_supports_op(mem, op))
> >>   		return -ENOTSUPP;
> >>  =20
> >> -	if (ctlr->mem_ops) {
> >> +	if (ctlr->mem_ops && !mem->spi->cs_gpiod) {
> >>   		ret =3D spi_mem_access_start(mem);
> >>   		if (ret)
> >>   			return ret;
> >> --=20
> >> 2.24.0
> >>

--1Bw2yCtIAFFUtGFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCacsvjwAKCRB4tDGHoIJi
0kuVAQDQP6hVCB+MwjYq4J9KXLlf8vXe/M4cv6Q7yIKDFY2JFQEA98dqDbm4W8+Z
zFCbbceiTyffDmhe7Gl5ppaDq1n51w0=
=jGch
-----END PGP SIGNATURE-----

--1Bw2yCtIAFFUtGFM--
