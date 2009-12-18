From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: [spi-devel-general] [git pull] 2nd batch of SPI changes
Date: Fri, 18 Dec 2009 09:45:08 +0900
Message-ID: <1b68c6790912171645m4de68ac9i6f31346249147bd1@mail.gmail.com>
References: <fa686aa40912170840h6bd921b4me244cb83c31cab7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Brownell <dbrownell@users.sourceforge.net>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754904AbZLRApT@vger.kernel.org>
In-Reply-To: <fa686aa40912170840h6bd921b4me244cb83c31cab7f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 18, 2009 at 1:40 AM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> Hi Linus,
>
> This is later than I'd like it to be, and I hope it gets to you befor=
e
> you cut -rc1. =C2=A0There was some slack between Andrew and I on hand=
ing
> off SPI maintainership. =C2=A0Patches I had picked up in the last bat=
ch
> conflicted with his stack and we decided it was best if I just take
> the remainder of his SPI queue and commit them to my tree.
> (Basically, I made the mess, so I got to clean it up). =C2=A0It took =
me a
> bit to get sorted out.
>
> Commits in this batch are either a) from Andrew's tree, b) trivial
> fixes from the list, or c) new drivers.
>
> The following changes since commit 718deb6b61e34c200c1f2b706176d9aac3=
34cb2d:
> =C2=A0Al Viro (1):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Fix breakage in shmem.c
>
> are available in the git repository at:
>
> =C2=A0git://git.secretlab.ca/git/linux-2.6 next-spi
>
> Ben Dooks (1):
> =C2=A0 =C2=A0 =C2=A0spi_s3c24xx: add FIQ pseudo-DMA support
>
> Ben Nizette (1):
> =C2=A0 =C2=A0 =C2=A0atmel_spi: fix dma addr calculation for len > BUF=
=46ER_SIZE
>
> Feng Tang (1):
> =C2=A0 =C2=A0 =C2=A0spi: controller driver for Designware SPI core
>
> Jassi Brar (1):
> =C2=A0 =C2=A0 =C2=A0spi: Add s3c64xx SPI Controller driver
IIRC, I didn't get any final ack of acceptance from you or any other ma=
intainer.
I thought perhaps the patch is lost and was preparing to resend after
including some minor changes suggested by my ARCH maintainer(Ben Dooks)=
=2E
Though I can just as well send those changes as patches right away.
I apologize, if i messed up.

> Mike Frysinger (1):
> =C2=A0 =C2=A0 =C2=A0spidev: add proper section markers
>
> Thadeu Lima de Souza Cascardo (1):
> =C2=A0 =C2=A0 =C2=A0spidev: use DECLARE_BITMAP instead of declaring t=
he array
>
> hartleys (5):
> =C2=A0 =C2=A0 =C2=A0spi: atmel_spi.c: use resource_size()
> =C2=A0 =C2=A0 =C2=A0spi: spi_bfin5xx.c: use resource_size()
> =C2=A0 =C2=A0 =C2=A0spi: spi_mpc8xxx.c: use resource_size()
> =C2=A0 =C2=A0 =C2=A0spi: spi_sh_sci.c: use resource_size()
> =C2=A0 =C2=A0 =C2=A0spi: spi_txx9.c: use resource_size()
>
> =C2=A0arch/arm/mach-s3c2410/include/mach/spi.h | =C2=A0 =C2=A02 +
> =C2=A0drivers/spi/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 28 +
> =C2=A0drivers/spi/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 10 +-
> =C2=A0drivers/spi/atmel_spi.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A06 +-
> =C2=A0drivers/spi/dw_spi.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0944 +++++++++++++++++++++++
> =C2=A0drivers/spi/dw_spi_pci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0169 +++++
> =C2=A0drivers/spi/spi_bfin5xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0drivers/spi/spi_mpc8xxx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0drivers/spi/spi_s3c24xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| =C2=A0244 ++++++-
> =C2=A0drivers/spi/spi_s3c24xx_fiq.S =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0116 +++
> =C2=A0drivers/spi/spi_s3c24xx_fiq.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 26 +
> =C2=A0drivers/spi/spi_s3c64xx.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 1196 ++++++++++++++++++++++++++++++
> =C2=A0drivers/spi/spi_sh_sci.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0drivers/spi/spi_txx9.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A06 +-
> =C2=A0drivers/spi/spidev.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 18 +-
> =C2=A0include/linux/spi/dw_spi.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0212 ++++++
> =C2=A016 files changed, 2950 insertions(+), 33 deletions(-)
> =C2=A0create mode 100644 drivers/spi/dw_spi.c
> =C2=A0create mode 100644 drivers/spi/dw_spi_pci.c
> =C2=A0create mode 100644 drivers/spi/spi_s3c24xx_fiq.S
> =C2=A0create mode 100644 drivers/spi/spi_s3c24xx_fiq.h
> =C2=A0create mode 100644 drivers/spi/spi_s3c64xx.c
> =C2=A0create mode 100644 include/linux/spi/dw_spi.h
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>
> ---------------------------------------------------------------------=
---------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast a=
nd easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>
