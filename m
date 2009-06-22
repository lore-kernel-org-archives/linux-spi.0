From: Artem Bityutskiy <dedekind@infradead.org>
Subject: Re: [PATCH] SST25L (non JEDEC) SPI Flash driver
Date: Mon, 22 Jun 2009 11:15:10 +0300
Message-ID: <1245658510.9487.32.camel@localhost.localdomain>
References: <4A3F017B.2010409@bluewatersys.com>
Reply-To: dedekind@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net, mike@steroidmicros.com,
	linux kernel <linux-kernel@vger.kernel.org>
To: Ryan Mallon <ryan@bluewatersys.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755290AbZFVIQQ@vger.kernel.org>
In-Reply-To: <4A3F017B.2010409@bluewatersys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 2009-06-22 at 15:58 +1200, Ryan Mallon wrote:
> Add support for the non JEDEC SST25L SPI Flash devices.
>=20
> Signed-off-by: Andre Renaud <andre@bluewatersys.com>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
>=20
> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfi=
g
> index 325fab9..c222514 100644
> --- a/drivers/mtd/devices/Kconfig
> +++ b/drivers/mtd/devices/Kconfig
> @@ -104,6 +104,16 @@ config M25PXX_USE_FAST_READ
>  	help
>  	  This option enables FAST_READ access supported by ST M25Pxx.

Would it please be possible to get rid of this warning:

  CC [M]  drivers/mtd/devices/sst25l.o
drivers/mtd/devices/sst25l.c: In function =E2=80=98sst25l_write=E2=80=99=
:
drivers/mtd/devices/sst25l.c:306: warning: comparison of distinct point=
er types lacks a cast

I see it on my x86_64.

--=20
Best regards,
Artem Bityutskiy (=D0=91=D0=B8=D1=82=D1=8E=D1=86=D0=BA=D0=B8=D0=B9 =D0=90=
=D1=80=D1=82=D1=91=D0=BC)
