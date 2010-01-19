From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] [PATCH] Clear control
	bits in drivers/spi/spi_bfin5xx.c as necessary
Date: Tue, 19 Jan 2010 09:12:42 -0700
Message-ID: <fa686aa41001190812l28cf29fs5471c1022d25deee@mail.gmail.com>
References: <DA80C3E6C10BE94E8FCACEB239C2FEE46645317E77@EXVS01.olin.edu>
	<8bd0f97a0912180514k42f32162jc850f4b4abbc3f7a@mail.gmail.com>
	<8bd0f97a0912180934s3d2c70b7uf65d09dc016c1faa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>,
	James Getzendanner <James.Getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a0912180934s3d2c70b7uf65d09dc016c1faa-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 18, 2009 at 10:34 AM, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
> On Fri, Dec 18, 2009 at 08:14, Mike Frysinger wrote:
>> On Fri, Dec 18, 2009 at 02:29, James Getzendanner wrote:
>>> From: Andy Getzendanner <james.getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org>
>>>=A0The patch also modifies bfin_spi_setup() to
>>> set/clear the SIZE bit as appropriate.
>>
>> ok, but this isnt the place to do it. =A0the size can be changed on a
>> per-transfer basis. =A0i have a patch locally to unify the transfer size
>> logic and i'll include this fix in the process.
>
> i lied, this isnt necessary. =A0it's already handled in the transfer code.
> =A0 =A0cr =3D (read_CTRL(drv_data) & (~BIT_CTL_TIMOD));
> =A0 =A0cr |=3D (width << 8);
> =A0 =A0write_CTRL(drv_data, cr);
>
> where width is CFG_SPI_WORDSIZE16 or CFG_SPI_WORDSIZE8 as dictated by
> the transfer.
> -mike

Mike & James,

It's not clear to me from the discussion.  What is the status of this
patch, is it still needed?

also...

On Fri, Dec 18, 2009 at 12:29 AM, James Getzendanner
<James.Getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org> wrote:
> --- linux-2.6.32.1/drivers/spi/spi_bfin5xx.c.orig       2009-12-14 12:47:=
25.000000000 -0500
> +++ linux-2.6.32.1/drivers/spi/spi_bfin5xx.c    2009-12-18 00:27:10.00000=
0000 -0500
> @@ -1051,10 +1051,16 @@ static int bfin_spi_setup(struct spi_dev
>        /* translate common spi framework into our register */
>        if (spi->mode & SPI_CPOL)
>                chip->ctl_reg |=3D CPOL;
> +       else
> +               chip->ctl_reg &=3D ~CPOL;
>        if (spi->mode & SPI_CPHA)
>                chip->ctl_reg |=3D CPHA;
> +       else
> +               chip->ctl_reg &=3D ~CPHA;
>        if (spi->mode & SPI_LSB_FIRST)
>                chip->ctl_reg |=3D LSBF;
> +       else
> +               chip->ctl_reg &=3D ~LSBF;
>        /* we dont support running in slave mode (yet?) */
>        chip->ctl_reg |=3D MSTR;

chip->ctl_reg &=3D ~(CPOL | CPHA | LSBF); before the set of if()
statements would be more concise.

g.

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
