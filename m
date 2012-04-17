From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Fix error print while setting bits/word on
	pl022
Date: Tue, 17 Apr 2012 11:54:36 +0530
Message-ID: <CAM=Q2csRwyGYgQ27bXjX=m6pqFoZFim=y3Qzv_DCQvyR5G0brg@mail.gmail.com>
References: <1334642325-29159-1-git-send-email-vinit.shenoy@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
To: Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1334642325-29159-1-git-send-email-vinit.shenoy-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Vinit ,
A minor comment/ suggestion.

On Tue, Apr 17, 2012 at 11:28 AM, Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org> wrote:
> pl022 ssp controller supports word lengths from 4 to 16 bits.
> The kernel error message says:
> "a standard pl022 can only handle 1 <=3D n <=3D 16 bit words".
>
> Fixed above range to 4 <=3D n <=3D 16.
>
> Signed-off-by: Vinit Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
> ---
> =A0drivers/spi/spi-pl022.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 09c925a..905752f 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1848,7 +1848,7 @@ static int pl022_setup(struct spi_device *spi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"illegal d=
ata size for this controller!\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&spi->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"a standar=
d pl022 can only handle "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "1 <=3D n <=
=3D 16 bit words\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "4 <=3D n <=
=3D 16 bit words\n");
However this print will not executed for sizes < 4
Can we have something like. [1]


> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOTSUPP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_config_params;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> --
> 1.7.3.4
>
>
> -------------------------------------------------------------------------=
-----
> Better than sec? Nothing is better than sec when it comes to
> monitoring Big Data applications. Try Boundary one-second
> resolution app monitoring today. Free.
> http://p.sf.net/sfu/Boundary-dev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
[1]

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 09c925a..6444a5e 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1823,11 +1823,7 @@ static int pl022_setup(struct spi_device *spi)
        } else
                chip->cs_control =3D chip_info->cs_control;

-       if (bits <=3D 3) {
-               /* PL022 doesn't support less than 4-bits */
-               status =3D -ENOTSUPP;
-               goto err_config_params;
-       } else if (bits <=3D 8) {
+       if (bits <=3D 8 && bits > 3) {
                dev_dbg(&spi->dev, "4 <=3D n <=3D8 bits per word\n");
                chip->n_bytes =3D 1;
                chip->read =3D READING_U8;
@@ -1848,7 +1844,7 @@ static int pl022_setup(struct spi_device *spi)
                                "illegal data size for this controller!\n");
                        dev_err(&spi->dev,
                                "a standard pl022 can only handle "
-                               "1 <=3D n <=3D 16 bit words\n");
+                               "4 <=3D n <=3D 16 bit words\n");
                        status =3D -ENOTSUPP;
                        goto err_config_params;
                }

---------------------------------------------------------------------------=
---
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second =

resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
