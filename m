From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 6/6] SPI: S3C64XX: Add new parameter
	to cs callback
Date: Mon, 18 Jan 2010 11:15:04 -0700
Message-ID: <fa686aa41001181015g6b3d35fdy8ee0f5134a8ca1a5@mail.gmail.com>
References: <1263808215-16544-1-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-2-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-3-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-4-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-5-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-6-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org
To: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1263808215-16544-6-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 18, 2010 at 2:50 AM,  <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
> Since most of the chip-selects are simply going to be like
> gpio_set_value, it would do good to have the same callback type
> so that it could simply be made to point at gpio_set_value.
>
> Signed-off-by: Jassi Brar <jassi.brar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

This patch changes the calling arguments, but I don't see any function
signatures changed to reflect the new parameters.  Is this going to
break stuff?

g.

> ---
> =A0drivers/spi/spi_s3c64xx.c | =A0 =A07 ++++---
> =A01 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> index 9fa0b99..32db695 100644
> --- a/drivers/spi/spi_s3c64xx.c
> +++ b/drivers/spi/spi_s3c64xx.c
> @@ -300,13 +300,14 @@ static inline void enable_cs(struct s3c64xx_spi_dri=
ver_data *sdd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sdd->tgl_spi !=3D spi) { /* if last ms=
sg on diff device */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Deselect the last toggl=
ed device */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs =3D sdd->tgl_spi->contr=
oller_data;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->set_level(spi->mode & S=
PI_CS_HIGH ? 0 : 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs->set_level(cs->line,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spi->mode & SPI_CS_HIGH ? 0 : 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdd->tgl_spi =3D NULL;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0cs =3D spi->controller_data;
> - =A0 =A0 =A0 cs->set_level(spi->mode & SPI_CS_HIGH ? 1 : 0);
> + =A0 =A0 =A0 cs->set_level(cs->line, spi->mode & SPI_CS_HIGH ? 1 : 0);
> =A0}
>
> =A0static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
> @@ -386,7 +387,7 @@ static inline void disable_cs(struct s3c64xx_spi_driv=
er_data *sdd,
> =A0 =A0 =A0 =A0if (sdd->tgl_spi =3D=3D spi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdd->tgl_spi =3D NULL;
>
> - =A0 =A0 =A0 cs->set_level(spi->mode & SPI_CS_HIGH ? 0 : 1);
> + =A0 =A0 =A0 cs->set_level(cs->line, spi->mode & SPI_CS_HIGH ? 0 : 1);
> =A0}
>
> =A0static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
> --
> 1.6.2.5
>
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
