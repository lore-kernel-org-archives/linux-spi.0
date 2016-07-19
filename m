From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/3] spi: spidev: create spidev device for all spi
 slaves.
Date: Tue, 19 Jul 2016 13:44:09 +0100
Message-ID: <20160719124409.GC30372@sirena.org.uk>
References: <cover.1468880530.git.hramrach@gmail.com>
 <5bfcceff7b6132cf3447f97c24d1646043224164.1468880530.git.hramrach@gmail.com>
 <20160718225952.GW30372@sirena.org.uk>
 <CAOMqctQ7Uq7JEYZovYqzQHLpjgk8HoK8Q2Bei3gEzFboyUxNyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pqZtgxSH0iQu6R78"
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQ7Uq7JEYZovYqzQHLpjgk8HoK8Q2Bei3gEzFboyUxNyg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--pqZtgxSH0iQu6R78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 19, 2016 at 01:17:52PM +0200, Michal Suchanek wrote:
> On 19 July 2016 at 00:59, Mark Brown <broonie@kernel.org> wrote:

> Looking into SPI more this whole point is mostly moot, anyway. Most of the
> time the unused CS lines will not be multiplexed to the SPI controller so
> even if the SPI master tries to use them it does nothing. Also most of the
> time all the CS lines can be exported as GPIO regardless of their use for=
 SPI.
> And set to any possible level using the GPIO userspace API.

Your system is not the entire world, Linux has to run on other systems
too.  There are actual devices out there with inflexible pinmuxing, we
can't just ignore them.

> In order to reduce the amount of objects and management I appended
> the link object at the end of struct spi_device.

> Is there a better way?

That seems mostly fine, the problem is one of code review - because the
patch does many logically distinct things in a single patch it is much
harder to review than if it were split out.  There's a lot of mechanical
refactoring which obscures the several more substantive changes that are
being made at the same time and since most of those substantive changes
are explicitly described at all it's hard to tell if they're intended or
doing what is expected.

> > I am getting completely fed up of saying this, it's not OK to just
> > expose pins to userspace when we have no idea what they are connected
> > to.

> I am getting fed up with this argument.

> First, this patchset only exposes to userspace pins that are configured a=
s SPI
> slaves in devicetree.

Are you *absolutely* positive your changes won't do anything on non-DT
systems?  That definitely doesn't appear to be the case (and shouldn't
be, not all the world is DT), but now I look in more detail what it is
doing is exposing spidev for each explicitly described slave which is
substantially more safe and does address the main problem with
undescribed devices.

Please split this up so it can be reviewed, providing clear and specific
descriptions of each individual change (as covered in
SubmittingPatches).

This:

> -       status =3D register_chrdev(SPIDEV_MAJOR, "spi", &spidev_fops);
> +       status =3D register_chrdev(SPIDEV_MAJOR, "spidev", &spidev_fops);

also looks like a needless ABI change and the removal of the locking on
minor device allocation seems concerning and at least needs to be
covered in the changelog.

> The fact that devicetree does not allow talking to a SPI device from user=
space
> without telling kernel what kind of protocol userspace is using is a regr=
ession
> from using board files. The kernel has no business knowing that. When you
> use a userspace driver it's userspace's job to manage protocols and devic=
es.

The system as a whole, including both the kernel and userspace, has
every business knowing what the hardware is so it can understand how to
control it.  Userspace is no more able to discover what the magic
undescribed bits of hardware are automatically than the kernel is
without help from a hardware description, the DT isn't just something
for the kernel once you have userspace drivers. =20

Directly enumerating spidev wasn't an especially great idea for board
files either, it was just an expedient hack that worked when the
hardware description was entirely in kernel and much easier to just go
and change but now we have an external ABI for hardware description and
we have to expect that people will use it as such.

> The purpose of this patchset is for the userspace applications to continu=
e doing
> so with devicetree based systems without the need to fabricate fake hardw=
are
> description. And the hardware description will necessarily be fake in the=
 case
> when it is in fact userspace implementing and managing the drivers.

If userspace is managing to figure out how to control the device then
providing a description of the hardware is clearly within the bounds of
possibility and there is no need to fake anything.

--pqZtgxSH0iQu6R78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXjiCYAAoJECTWi3JdVIfQ2UMH/0cLDXxhZaHEmD4xx5VCqHTf
UNtPTVXzPirjfaEslj6bWGFLmsKxWC3MOKaRu5M0FBRsu+3pBVdzNVs/gHhODpwd
YsKbbOUaLBrzh2KLQ16IgLqdWbAX0cTEWh7QbGzj/c3Ls19w1NTf9g6yd9fOh+eu
ob52VlARYk0iQEgrYb8leORQFAOvZ4Kndlr7mrfsg8R4cBWJBYvnLhRFxOjMbqJM
eTJCJLGraR0xU08fOxpfRMzXwhPlGfoQXzMbr5nfPSPZpV/4wS4+DrU+zfu7MLSA
Hgj628ldZBd+/HQZ5sqv2pZNJPwTIqsmxrn6Hy5QIVXg2NNQ1lpEnIDbH2YYikg=
=KSVV
-----END PGP SIGNATURE-----

--pqZtgxSH0iQu6R78--
