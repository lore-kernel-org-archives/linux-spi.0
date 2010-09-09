From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] SPI: S3C64XX: Correction for 16,32 bits bus width
Date: Thu, 9 Sep 2010 10:00:51 -0600
Message-ID: <20100909160051.GA6273@angua.secretlab.ca>
References: <1284016737-21620-1-git-send-email-jassi.brar@samsung.com>
	<20100909145115.GA5652@angua.secretlab.ca>
	<AANLkTim-gpnfsvWrFnJBcE9DcWFsh8soJwq4gL_bMpMv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim-gpnfsvWrFnJBcE9DcWFsh8soJwq4gL_bMpMv-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 10, 2010 at 12:07:50AM +0900, Jassi Brar wrote:
> On Thu, Sep 9, 2010 at 11:51 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>=
 wrote:
> > On Thu, Sep 09, 2010 at 04:18:57PM +0900, Jassi Brar wrote:
[...]
> > Nit: switch statements like this tend to obscure the fact that the same
> > function is called each time with a different value. =A0How about the
> > following:
> >
> > =A0 =A0 =A0 =A0width =3D 1;
> > =A0 =A0 =A0 =A0if (sdd->cur_bpw =3D=3D 32)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0width =3D 4;
> > =A0 =A0 =A0 =A0if (sdd->cur_bpw =3D=3D 16)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0width =3D 2;
> > =A0 =A0 =A0 =A0s3c2410_dma_config(sdd->tx_dmach, width);
> >
> > It's also more concise.
> =

> yuck! why didn't i do
>           s3c2410_dma_config(sdd->tx_dmach, sdd->cur_bpw / 8); ??

Heh, very true!

> >> @@ -610,6 +648,14 @@ static void handle_msg(struct s3c64xx_spi_driver_=
data *sdd,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bpw =3D xfer->bits_per_word ? : spi->bits_=
per_word;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 speed =3D xfer->speed_hz ? : spi->max_spee=
d_hz;
> >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (bpw !=3D 8 && xfer->len % (bpw / 8)) {
> >
> > The (bpw !=3D 8) test is superfluous.
> =

>  xfer->len % (bpw / 8)    always evaluate to true(error hence) when bpw=
=3D=3D8
> so we wanna avoid that case

When bpw =3D=3D 8, the equation reduces to (len % 1), which will always
evaluate to 0 (false) for integer len.

g.


---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
