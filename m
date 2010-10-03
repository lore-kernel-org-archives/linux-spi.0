From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [git pull] SPI bug fixes for 2.6.36
Date: Sat, 2 Oct 2010 21:43:50 -0600
Message-ID: <AANLkTi=GjpvhexkGdwJmigX0yOE6at-vdEq+OR_HG9kG@mail.gmail.com>
References: <AANLkTimgKWoFt8Kd3DCG20Mpkib54ePPiiGbabVvrYuU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>, Sinan Akman <sinan-w0xpxkV3uqlBDgjK7y7TUQ@public.gmane.org>,
	Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimgKWoFt8Kd3DCG20Mpkib54ePPiiGbabVvrYuU-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Oops, missed one.  Here is an updated pull req:

The following changes since commit c6ea21e35bf3691cad59647c771e6606067f627d:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../sfrench/cifs-2.6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge-spi

Roel Kluin (1):
      spi: spi-gpio.c tests SPI_MASTER_NO_RX bit twice, but not SPI_MASTER_=
NO_TX

Sinan Akman (1):
      of/spi: Fix OF-style driver binding of spi devices

christophe leroy (1):
      spi/mpc8xxx: fix buffer overrun on large transfers

 drivers/spi/spi.c         |    5 +++++
 drivers/spi/spi_gpio.c    |    2 +-
 drivers/spi/spi_mpc8xxx.c |   10 ++++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)



On Sat, Oct 2, 2010 at 9:26 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wr=
ote:
> Hi Linus,
>
> Some spi bug fixes for 2.6.36
>
> The following changes since commit 899611ee7d373e5eeda08e9a8632684e1ebbbf=
00:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 2.6.36-rc6
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6 merge-spi
>
> Roel Kluin (1):
> =A0 =A0 =A0spi: spi-gpio.c tests SPI_MASTER_NO_RX bit twice, but not SPI_=
MASTER_NO_TX
>
> christophe leroy (1):
> =A0 =A0 =A0spi/mpc8xxx: fix buffer overrun on large transfers
>
> =A0drivers/spi/spi_gpio.c =A0 =A0| =A0 =A02 +-
> =A0drivers/spi/spi_mpc8xxx.c | =A0 10 ++++++++--
> =A02 files changed, 9 insertions(+), 3 deletions(-)
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
