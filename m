From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: [PATCH v2] ARM: spi/sun7i: Add Master Sample Data
 Mode for SPI
Date: Sat, 11 Feb 2017 14:58:54 +0800
Message-ID: <20170212033109.V3xe2GIs@smtp2p.mail.yandex.net>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org,
 linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
To: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBVGZ73CAKGQEL5BTHBY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org


ARM: is not needed.

2017=E5=B9=B42=E6=9C=8811=E6=97=A5 11:54=E4=BA=8E Vinicius Maciel <vinicius=
fre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> In order to work appropriately, the max11043 ADC chip and probably=20
> others, needs SPI master samples the data at the correct edge. From=20
> max11043 datasheet: "The data at DIN is latched on the rising edge=20
> of SCLK". Same to DOUT.=20
>
> This patch add Master Sample Data Mode bit in normal sample mode.=20
> It will affect only A20.=20
>
> Signed-off-by: Vinicius Maciel <viniciusfre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=20
> Reviewed-by: Siarhei Siamashka <siarhei.siamashka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=20
> ---=20
> drivers/spi/spi-sun4i.c | 4 +++-=20
> 1 file changed, 3 insertions(+), 1 deletion(-)=20
>
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c=20
> index c5cd635c28f3..6325be2ce8d9 100644=20
> --- a/drivers/spi/spi-sun4i.c=20
> +++ b/drivers/spi/spi-sun4i.c=20
> @@ -44,6 +44,7 @@=20
> #define SUN4I_CTL_CS_MANUAL BIT(16)=20
> #define SUN4I_CTL_CS_LEVEL BIT(17)=20
> #define SUN4I_CTL_TP BIT(18)=20
> +#define SUN4I_CTL_SDM BIT(20)=20
>
> #define SUN4I_INT_CTL_REG 0x0c=20
> #define SUN4I_INT_CTL_RF_F34 BIT(4)=20
> @@ -407,7 +408,8 @@ static int sun4i_spi_runtime_resume(struct device *de=
v)=20
> }=20
>
> sun4i_spi_write(sspi, SUN4I_CTL_REG,=20
> - SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP);=20
> + SUN4I_CTL_ENABLE | SUN4I_CTL_MASTER | SUN4I_CTL_TP |=20
> + SUN4I_CTL_SDM);=20
>
> return 0;=20
>
> --=20
> 2.11.0=20
>
> --=20
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.=20
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org=20
> For more options, visit https://groups.google.com/d/optout.=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
