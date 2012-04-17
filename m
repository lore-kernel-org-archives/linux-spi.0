From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] spi/pl022: Fix range checking for bits per word
Date: Tue, 17 Apr 2012 16:49:04 +0530
Message-ID: <CAM=Q2cszuc=8+aXS-NXa8gEwMQ8vPxOazc3bTPpm5TvsZdni8A@mail.gmail.com>
References: <1334646613-12560-1-git-send-email-vinit.shenoy@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
To: Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1334646613-12560-1-git-send-email-vinit.shenoy-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Vinit,

Looks OK to me ,

On Tue, Apr 17, 2012 at 12:40 PM, Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org> wrote:
> pl022 ssp controller supports word lengths from 4 to 16 (or 32) bits.
> Currently implemented checks were incorrect. It has following check
>
> if (pl022->vendor->max_bpw >=3D 32)
>
> which must be checking for <=3D.
>
> Also error print message is incorrect, that prints "range is from 1 to
> 16".
>
> Fix both these issues.

Thanks ,

>
> Signed-off-by: Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
> ---
> V1->V2:
> - Fixed the check:
> =A0 =A0 =A0 =A0if (pl022->vendor->max_bpw >=3D 32)
> - Re-written complete range check logic.
I think the patches could be split as one is a fix the other corrects the
error msg.

Nit:
Also the changlogs spell the issue and not the solution.
I think that could be improved.
Other than  that feel free to add
Reviewed-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>

If you like.
>
> =A0drivers/spi/spi-pl022.c | =A0 25 +++++++++----------------
> =A01 files changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 09c925a..1ead49d 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1823,9 +1823,12 @@ static int pl022_setup(struct spi_device *spi)
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->cs_control =3D chip_info->cs_control;
>
> - =A0 =A0 =A0 if (bits <=3D 3) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* PL022 doesn't support less than 4-bits */
> + =A0 =A0 =A0 /* Check bits per word with vendor specific range */
> + =A0 =A0 =A0 if ((bits <=3D 3) || (bits > pl022->vendor->max_bpw)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOTSUPP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "illegal data size for t=
his controller!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "This controller can onl=
y handle 4 <=3D n <=3D %d bit words\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pl022->vend=
or->max_bpw);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_config_params;
> =A0 =A0 =A0 =A0} else if (bits <=3D 8) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&spi->dev, "4 <=3D n <=3D8 bits pe=
r word\n");
> @@ -1838,20 +1841,10 @@ static int pl022_setup(struct spi_device *spi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->read =3D READING_U16;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->write =3D WRITING_U16;
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pl022->vendor->max_bpw >=3D 32) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&spi->dev, "17 <=3D=
 n <=3D 32 bits per word\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->n_bytes =3D 4;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->read =3D READING_U32;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->write =3D WRITING_U32;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "illegal da=
ta size for this controller!\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "a standard=
 pl022 can only handle "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "1 <=3D n <=
=3D 16 bit words\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOTSUPP;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_config_params;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&spi->dev, "17 <=3D n <=3D 32 bits =
per word\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->n_bytes =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->read =3D READING_U32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->write =3D WRITING_U32;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Now Initialize all register settings required for this =
chip */
> --
> 1.7.3.4
>

---------------------------------------------------------------------------=
---
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second =

resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
