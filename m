From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 2/2] spi/spi_s3c64xx: Increase dead reckoning time in wait_for_xfer()
Date: Wed, 8 Sep 2010 10:44:26 +0900
Message-ID: <AANLkTimxXWjiX64wJcNui2mLrvVg9RUtN9fFVnLhZsBY@mail.gmail.com>
References: <1283873872-8633-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1283873872-8633-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Jassi Brar <jassi.brar@samsung.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283873872-8633-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 8, 2010 at 12:37 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> For small transfers at high speeds the expected transfer time can eas=
ily
> be well under 1ms, causing the delay in wait_for_xfer() to be only th=
e
> dead reckoning fudge factor of 5ms currently included. Experiments on
> some of my systems shows that this is marginal for some transfers so
> double it to 10ms.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> =C2=A0drivers/spi/spi_s3c64xx.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
> index 03b28e4..4abb441 100644
> --- a/drivers/spi/spi_s3c64xx.c
> +++ b/drivers/spi/spi_s3c64xx.c
> @@ -326,7 +326,7 @@ static int wait_for_xfer(struct s3c64xx_spi_drive=
r_data *sdd,
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* millisecs to xfer 'len' bytes @ 'cur_sp=
eed' */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ms =3D xfer->len * 8 * 1000 / sdd->cur_spe=
ed;
> - =C2=A0 =C2=A0 =C2=A0 ms +=3D 5; /* some tolerance */
> + =C2=A0 =C2=A0 =C2=A0 ms +=3D 10; /* some tolerance */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dma_mode) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D msecs_=
to_jiffies(ms) + 10;

Acked-by: Jassi Brar <jassi.brar@samsung.com>
