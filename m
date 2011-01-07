From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi_imx.c: correct the test on platform_get_irq() return value
Date: Fri, 7 Jan 2011 08:26:23 -0700
Message-ID: <AANLkTin0eXCpLD1B0+zABqYcWxzG8+kM1cpRyD+Af_2n@mail.gmail.com>
References: <AANLkTimpTUz_Fizef09urPBR8vP80KU-5yApjzGWFwc0@mail.gmail.com> <1294410361-9092-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294410361-9092-1-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 7, 2011 at 7:26 AM, Richard Genoud <richard.genoud@gmail.co=
m> wrote:
> The test "if (spi_imx->irq <=3D 0)" is not testing the IRQ value, but=
 the return value of platform_get_irq().
> As platform_get_irq() can return an error (-ENXIO) or the IRQ value i=
t found, the test should be "if (spi_imx->irq < 0)"
>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

=46or the majority of architectures in Linux, 0 is not a valid IRQ for
devices.  Unless there is an actual imx platform that currently
assigns linux irq 0 to the spi controller then I'd rather not apply
this change.

g.

> ---
> =A0drivers/spi/spi_imx.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 55a38e2..793ae99 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -847,7 +847,7 @@ static int __devinit spi_imx_probe(struct platfor=
m_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0spi_imx->irq =3D platform_get_irq(pdev, 0);
> - =A0 =A0 =A0 if (spi_imx->irq <=3D 0) {
> + =A0 =A0 =A0 if (spi_imx->irq < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_iounmap;
> =A0 =A0 =A0 =A0}
> --
> 1.7.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
