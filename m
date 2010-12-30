From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [git pull] one more spi bugfix for 2.6.37
Date: Thu, 30 Dec 2010 00:59:11 -0700
Message-ID: <AANLkTi=PrTZ7faC6VQmqVjKo0FP9h1SqPFW7tWcsm2V8@mail.gmail.com>
References: <AANLkTimc2U==zvuRU67Bohsb5uCNjD8fX-6s7EefY6EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTimc2U==zvuRU67Bohsb5uCNjD8fX-6s7EefY6EQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Oops, missed one.  Here's an updated pull req.

The following changes since commit 387c31c7e5c9805b0aef8833d1731a5fe7bd=
ea14:

  Linux 2.6.37-rc8 (2010-12-28 17:05:48 -0800)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 merge-spi

Gregory CLEMENT (1):
      spi/omap2_mcspi.c: Force CS to be in inactive state after
off-mode transition

Jate Sujjavanich (1):
      spi/m68knommu: Coldfire QSPI platform support

 drivers/spi/coldfire_qspi.c |    2 +-
 drivers/spi/omap2_mcspi.c   |   39 +++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 40 insertions(+), 1 deletions(-)


On Wed, Dec 29, 2010 at 6:45 PM, Grant Likely <grant.likely@secretlab.c=
a> wrote:
> Hi Linus,
>
> Here is one more spi bug fix for .37
>
> The following changes since commit 387c31c7e5c9805b0aef8833d1731a5fe7=
bdea14:
>
> =A0Linux 2.6.37-rc8 (2010-12-28 17:05:48 -0800)
>
> are available in the git repository at:
> =A0git://git.secretlab.ca/git/linux-2.6 merge-spi
>
> Gregory CLEMENT (1):
> =A0 =A0 =A0spi/omap2_mcspi.c: Force CS to be in inactive state after
> off-mode transition
>
> =A0drivers/spi/omap2_mcspi.c | =A0 39 +++++++++++++++++++++++++++++++=
++++++++
> =A01 files changed, 39 insertions(+), 0 deletions(-)
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
