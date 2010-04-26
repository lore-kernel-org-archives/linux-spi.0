From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] DaVinci SPI: Fix SPI clock prescale
	factor computation
Date: Mon, 26 Apr 2010 09:06:11 -0600
Message-ID: <k2zfa686aa41004260806r691e1880i2a80b102c108be5a@mail.gmail.com>
References: <871veaksca.fsf@deeprootsystems.com>
	<1272272505-5021-2-git-send-email-thomas.koeller@baslerweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>,
	Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	Sandeep Paulraj <s-paulraj-l0cyMroinI0@public.gmane.org>, Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/Nq7ICLvS4PUAC/G2K4zDHf@public.gmane.org
To: thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1272272505-5021-2-git-send-email-thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 26, 2010 at 3:01 AM,  <thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org> wrote:
> From: Thomas Koeller <thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org>
>
> Computation of the clock prescaler value returned bogus results if
> the requested SPI clock was impossible to set. It now sets either
> the maximum or minimum clock frequency, as appropriate.
>
> Signed-off-by: Thomas Koeller <thomas.koeller-x9WYMywdo8BF6kxbq+BtvQ@public.gmane.org>
> ---
> =A0drivers/spi/davinci_spi.c | =A0 12 +++++++++---
> =A01 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
> index 956f617..02e1a76 100644
> --- a/drivers/spi/davinci_spi.c
> +++ b/drivers/spi/davinci_spi.c
> @@ -153,7 +153,7 @@ static int davinci_spi_setup_transfer(struct spi_devi=
ce *spi,
> =A0 =A0 =A0 =A0struct davinci_spi *davinci_spi;
> =A0 =A0 =A0 =A0struct davinci_spi_platform_data *pdata;
> =A0 =A0 =A0 =A0u8 bits_per_word =3D 0;
> - =A0 =A0 =A0 u32 hz =3D 0, prescale;
> + =A0 =A0 =A0 u32 hz =3D 0, prescale =3D 0, clkspeed;
>
> =A0 =A0 =A0 =A0davinci_spi =3D spi_master_get_devdata(spi->master);
> =A0 =A0 =A0 =A0pdata =3D davinci_spi->pdata;
> @@ -190,10 +190,16 @@ static int davinci_spi_setup_transfer(struct spi_de=
vice *spi,
> =A0 =A0 =A0 =A0set_fmt_bits(davinci_spi->base, bits_per_word & 0x1f,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi->chip_select);
>
> - =A0 =A0 =A0 prescale =3D ((clk_get_rate(davinci_spi->clk) / hz) - 1) & =
0xff;
> + =A0 =A0 =A0 clkspeed =3D clk_get_rate(davinci_spi->clk);
> + =A0 =A0 =A0 if (hz > clkspeed / 2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D 1 << 8;
> + =A0 =A0 =A0 if (hz < clkspeed / 256)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D 255 << 8;
> + =A0 =A0 =A0 if (!prescale)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescale =3D ((clkspeed / hz - 1) << 8) & 0=
x0000ff00;

Is be appropriate to WARN_ON() or WARN_ONCE() when the clamp condition
occurs?  Particularly the condition where the minimum clock speed is
higher that the requested clock.

I'd also consider an if / else if / else structure for readability and clar=
ity.

g.

---------------------------------------------------------------------------=
---
