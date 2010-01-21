From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/5] include/linux/spi/dw_spi.h:
	enable platform specific chipselect.
Date: Thu, 21 Jan 2010 07:49:27 -0700
Message-ID: <fa686aa41001210649l4926613cncdab1326b3fe304a@mail.gmail.com>
References: <1264074052-2214-1-git-send-email-george@georgeshore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1264074052-2214-1-git-send-email-george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 21, 2010 at 4:40 AM, George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org> wrot=
e:
> The driver core allows for a platform-specific chipselect assert/deassert
> function, however the chipselect function in the core doesn't take advant=
age
> of this fact.
>
> This enables the use of a custom function, should it be defined.
>
> Signed-off-by: George Shore <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>

all 5 patches merged.

> ---
> =A0include/linux/spi/dw_spi.h | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/spi/dw_spi.h b/include/linux/spi/dw_spi.h
> index 1a127a3..cc813f9 100644
> --- a/include/linux/spi/dw_spi.h
> +++ b/include/linux/spi/dw_spi.h
> @@ -172,6 +172,10 @@ static inline void spi_chip_sel(struct dw_spi *dws, =
u16 cs)
> =A0{
> =A0 =A0 =A0 =A0if (cs > dws->num_cs)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> +
> + =A0 =A0 =A0 if (dws->cs_control)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->cs_control(1);
> +
> =A0 =A0 =A0 =A0dw_writel(dws, ser, 1 << cs);
> =A0}
>
> --
> 1.6.6.264.gd0743
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
