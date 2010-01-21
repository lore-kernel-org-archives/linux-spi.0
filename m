From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/dw_spi: add a FIFO depth
	detection
Date: Thu, 21 Jan 2010 07:49:04 -0700
Message-ID: <fa686aa41001210649n82c20a6qf893d4b25cf723e5@mail.gmail.com>
References: <20100121105139.3d0fbd42@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100121105139.3d0fbd42@feng-desktop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 20, 2010 at 7:51 PM, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> From aa51023622a3393dc8f412b11e9db2f5fc0334ad Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date: Thu, 21 Jan 2010 10:41:10 +0800
> Subject: [PATCH] spi/dw_spi: add a FIFO depth detection
>
> FIFO depth is configurable for each implementation of DW core,
> so add a depth detection for those interface drivers who don't set
> the fifo_len explicitly
>
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

merged


> ---
> =A0drivers/spi/dw_spi.c | =A0 16 ++++++++++++++++
> =A01 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> index 4e2774c..0e76a6e 100644
> --- a/drivers/spi/dw_spi.c
> +++ b/drivers/spi/dw_spi.c
> @@ -990,6 +990,22 @@ static void spi_hw_init(struct dw_spi *dws)
> =A0 =A0 =A0 =A0spi_mask_intr(dws, 0xff);
> =A0 =A0 =A0 =A0spi_enable_chip(dws, 1);
> =A0 =A0 =A0 =A0flush(dws);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Try to detect the FIFO depth if not set by interface d=
river,
> + =A0 =A0 =A0 =A0* the depth could be from 2 to 256 from HW spec
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!dws->fifo_len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 fifo;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (fifo =3D 2; fifo <=3D 257; fifo++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_writew(dws, txfltr, fifo=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fifo !=3D dw_readw(dws,=
 txfltr))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->fifo_len =3D (fifo =3D=3D 257) ? 0 : f=
ifo;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_writew(dws, txfltr, 0);
> + =A0 =A0 =A0 }
> =A0}
>
> =A0int __devinit dw_spi_add_host(struct dw_spi *dws)
> --
> 1.6.0.4
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
