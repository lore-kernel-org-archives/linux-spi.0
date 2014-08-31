From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [GIT PULL] SPI fixes for v3.17
Date: Sun, 31 Aug 2014 13:50:46 +0100
Message-ID: <20140831125046.GE29327@sirena.org.uk>
References: <20140831122045.GD29327@sirena.org.uk>
 <CAMuHMdU4G2ntmn-=+TJG9PNE7ZHfvh0XhvMFBx3hZso69FnpLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z3ND3gJe4e1E4uwh"
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU4G2ntmn-=+TJG9PNE7ZHfvh0XhvMFBx3hZso69FnpLg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--z3ND3gJe4e1E4uwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2014 at 02:39:40PM +0200, Geert Uytterhoeven wrote:
> On Sun, Aug 31, 2014 at 2:20 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Geert Uytterhoeven (2):
> >       spi: sh-msiof: Fix leaking of unused DMA descriptors

> I think you forgot this one, which fixes a stupid but critical typo in
> the above:

> commit 7a9f957b395fc08edc47620c01e8bb5b798caddb
> Author: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> Date:   Thu Aug 7 14:07:43 2014 +0200
>=20
>     spi: sh-msiof: Fix transmit-only DMA transfers

Ah, right - looks like it got sent as patch 2/2 in a series with patch
1/1 being an optimisation patch rather than a fix so I didn't register
it as a fix for the -rcs.  When sending fixes please put them at the
start of the patch series (or send them separately if there's no
dependency in the rest of the series), this both ensures that there's no
dependencies that prevent them being applied and makes it clearer that
they aren't fixes for the in-development code.

Updated pull request below:

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v3=
=2E17-rc3-2

for you to fetch changes up to 2dbf5910442dfe3de239df7c01d6b83e72b8dbdd:

  Merge remote-tracking branch 'spi/fix/sh-msiof' into spi-linus (2014-08-3=
1 13:46:19 +0100)

----------------------------------------------------------------
spi: Bug fixes for v3.17

A smattering of bug fixes for the SPI subsystem, all in driver code
which has seen active work recently and none of them with any great
global impact.

There's also a new ACPI ID for the pxa2xx driver which required no code
changes and the addition of kerneldoc for some structure fields that
were missing it and generating warnings during documentation builds as a
result.

----------------------------------------------------------------
Addy Ke (1):
      spi/rockchip: fixup incorrect dma direction setting

Alan Cox (1):
      spi/pxa2xx: Add ACPI ID for Intel Braswell

Andy Shevchenko (2):
      spi: dw-pci: fix bug when regs left uninitialized
      spi: dw: fix kernel crash due to NULL pointer dereference

Doug Anderson (1):
      spi/rockchip: Avoid accidentally turning off the clock

Geert Uytterhoeven (3):
      spi: sh-msiof: Fix leaking of unused DMA descriptors
      spi: rspi: Fix leaking of unused DMA descriptors
      spi: sh-msiof: Fix transmit-only DMA transfers

Grygorii Strashko (1):
      spi: davinci: fix SPI_NO_CS functionality

Jorge A. Ventura (1):
      spi/omap-mcspi: Fix the spi task hangs waiting dma_rx

Manuel Lauss (1):
      spi: spi-au1550: fix build failure

Mark Brown (4):
      Merge remote-tracking branch 'spi/fix/sh-msiof' into spi-linus
      Merge remote-tracking branches 'spi/fix/au1550', 'spi/fix/davinci', '=
spi/fix/doc', 'spi/fix/dw', 'spi/fix/omap-mcspi', 'spi/fix/pxa2xx', 'spi/fi=
x/rockchip' and 'spi/fix/rspi' into spi-linus
      Merge tag 'spi-v3.17-rc3' into spi-linus
      Merge remote-tracking branch 'spi/fix/sh-msiof' into spi-linus

Thierry Reding (1):
      spi: Add missing kerneldoc bits

 drivers/spi/spi-au1550.c      |  2 +-
 drivers/spi/spi-davinci.c     | 16 ++++----
 drivers/spi/spi-dw-pci.c      |  2 +
 drivers/spi/spi-dw.c          |  2 +-
 drivers/spi/spi-omap2-mcspi.c |  3 +-
 drivers/spi/spi-pxa2xx.c      |  1 +
 drivers/spi/spi-rockchip.c    |  4 +-
 drivers/spi/spi-rspi.c        | 94 ++++++++++++++++++++++++++-------------=
----
 drivers/spi/spi-sh-msiof.c    | 71 +++++++++++++++++---------------
 drivers/spi/spi.c             |  1 +
 include/linux/spi/spi.h       |  7 ++++
 11 files changed, 121 insertions(+), 82 deletions(-)

--z3ND3gJe4e1E4uwh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUAxojAAoJELSic+t+oim9PLwQAIHAH+wsXXXBzkCKXWJwsN56
Ec/DWAbBEL0dXT8aKb+BYPySEzL4kYwTn0vuM1WUFZYBZaxusnpdOMDwNnqKGL0y
jKEo/LyB9L0Akj+uu1dtNCn6NliGpGf9sy6C56tUAS4sk20fTTi5dNpNCumsydwi
uoqX1kYAKLiZhS57+k6Uig7Z1N69ANqHnIf2CkxXBlylv9pozilVEOh9SjQgD3ou
PfpJxkEgQPORZX8MZq00CgoYIhANBQwZ72UvTzUfFrek2q9HkZkY5kiqV8np2YII
OZ2hzmt6LQIj/uk28QCuER846SDOOoT9PAli/eTh59cP22M6AkZhaq7lAImzi28+
yYTKGnyx8CeCFKMJoiL/YSmhOh9SFnkF9rewke4u3ywINZgGCp1JMJCmMiWHbngk
XRQNl4Z/1f0IGPQmpZUW5AqlgUBrER+TraLm6JFEe3sOEwMAB4llQjYLW83waW4F
mPuDSnx0ePhP5wNkjLnJnQ4EQa3JjA7M2umoJII9yeWcFrM/kOpjip+Bk04/c196
JD8gSp3JCi0vG/owcLbLyoVSPThcbuJ61pH74kS/DCVLqEs0Ct3Y1So7zFYd12EO
/zyrGmHP32HK5NkJEFyn0LPYcysK3vHSPLOg4obumK+e1OCNI7DDVkgdFEkQiWln
GPKlG6I2LsX92A38xfa1
=eKi8
-----END PGP SIGNATURE-----

--z3ND3gJe4e1E4uwh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
