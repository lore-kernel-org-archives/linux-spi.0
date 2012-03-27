From: "Oskar Schirmer" <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 4/4] mfd: mc13xxx: Add i2c driver
Date: 27 Mar 2012 08:24:19 +0000
Message-ID: <20120327082419.GA5080@curry>
References: <1332129838-7080-1-git-send-email-marc@cpdesign.com.au> <1332129838-7080-5-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: "Marc Reilly" <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1332129838-7080-5-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Test against Linux 3.3 fails as crucial patches in regmap core
are not yet mainline. However, with commit cc374fbf5305 from
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
applied, this series works fine.

Signed-off-by: Oskar Schirmer <oskar-fYPSZ7JpQqsAvxtiuMwx3w@public.gmane.org>

On Mon, Mar 19, 2012 at 15:03:58 +1100, Marc Reilly wrote:
> Adds support for mc13xxx family ICs connected via i2c.
> 
> Signed-off-by: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
> ---
>  drivers/mfd/Kconfig       |    8 +++-
>  drivers/mfd/Makefile      |    1 +
>  drivers/mfd/mc13xxx-i2c.c |  128 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 136 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/mfd/mc13xxx-i2c.c
[...]
