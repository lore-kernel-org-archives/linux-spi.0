From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/3] spi/s3c64xx diagnostic and PM updates
Date: Sat, 21 Jan 2012 07:27:23 -0700
Message-ID: <CACxGe6t_h9=U=TpK57XvLUKixmZRwovr_JionXBE39mSrTVHRQ@mail.gmail.com>
References: <20120121132329.GA10751@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120121132329.GA10751@opensource.wolfsonmicro.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Jan 21, 2012 at 6:23 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The following changes since commit 805a6af8dba5dfdd35ec35dc52ec012240=
0b2610:
>
> =A0Linux 3.2 (2012-01-04 15:55:44 -0800)
>
> are available in the git repository at:
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git spi=
/s3c64xx

Pushed out to git://git.secretlab.ca/git/linux-2.6.git spi/merge.
I'll ask Linus to pull in a couple of days after it has hit
linux-next.

g.

>
> They've all been posted several times before but seem to have got
> dropped on the floor somewhere along the line.
>
> Mark Brown (3):
> =A0 =A0 =A0spi/s3c64xx: Log error interrupts
> =A0 =A0 =A0spi/s3c64xx: Convert to dev_pm_ops
> =A0 =A0 =A0spi/s3c64xx: Implement runtime PM support
>
> =A0drivers/spi/spi-s3c64xx.c | =A0115 +++++++++++++++++++++++++++++++=
+++++++++----
> =A01 files changed, 104 insertions(+), 11 deletions(-)



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
