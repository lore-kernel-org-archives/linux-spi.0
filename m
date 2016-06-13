From: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 07/13] spi: sunxi: rename constants to
 match between sun4i and sun6i
Date: Tue, 14 Jun 2016 09:31:44 +1000
Message-ID: <CAGRGNgWFKXd64-wYbG0dQez8hbzC1BPWFsBXBr7tCjVO_DBwGQ@mail.gmail.com>
References: <cover.1465490774.git.hramrach@gmail.com> <c27d58f634daa4785e90c2716c8bb90399db3bf2.1465490774.git.hramrach@gmail.com>
Reply-To: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Timo Sigurdsson <public_timo.s-fWgRPtSzPNU3WX+qO2AYSQ@public.gmane.org>, Jonathan Liu <net147-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Gerhard Bertelsmann <info-La43T0Mi4bH5xCKuJOYmCvaTkwRoYoCU@public.gmane.org>, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>,
	devicet
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDQIP76OUQLBB5EE7W5AKGQEJI2NSXI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <c27d58f634daa4785e90c2716c8bb90399db3bf2.1465490774.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi Michal,

On Tue, Jun 14, 2016 at 3:46 AM, Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> SUNXI_CTL_ -> SUNXI_TFR_CTL_
> SUNXI_TFR_CTL_LMTF -> SUNXI_TFR_CTL_FBS

I don't know these abbreviations, are they both referring to the same thing?

> SUNXI_TFR_CTL_CS_ACTIVE_LOW -> SUNXI_TFR_CTL_SPOL

It looks like you're making the constant name less descriptive here.
Is the old version (CS_ACTIVE_LOW) incorrect?

> and some SUNXI_???_CTL_ -> SUNXI_CTL_
> for constants migrated to different registers between sun4i and sun6i
>
> No functional change.
>
> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-sun4i.c | 68 ++++++++++++++++++++++++-------------------------
>  drivers/spi/spi-sun6i.c | 14 +++++-----
>  2 files changed, 41 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 155d720..b7f8de1 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -28,21 +28,21 @@
>
>  #define SUNXI_TXDATA_REG               0x04
>
> -#define SUNXI_CTL_REG                  0x08
> +#define SUNXI_TFR_CTL_REG              0x08
>  #define SUNXI_CTL_ENABLE               BIT(0)
>  #define SUNXI_CTL_MASTER               BIT(1)
> -#define SUNXI_CTL_CPHA                 BIT(2)
> -#define SUNXI_CTL_CPOL                 BIT(3)
> -#define SUNXI_CTL_CS_ACTIVE_LOW                BIT(4)
> -#define SUNXI_CTL_LMTF                 BIT(6)
> +#define SUNXI_TFR_CTL_CPHA             BIT(2)
> +#define SUNXI_TFR_CTL_CPOL             BIT(3)
> +#define SUNXI_TFR_CTL_SPOL             BIT(4)
> +#define SUNXI_TFR_CTL_FBS              BIT(6)
>  #define SUNXI_CTL_TF_RST               BIT(8)
>  #define SUNXI_CTL_RF_RST               BIT(9)
> -#define SUNXI_CTL_XCH                  BIT(10)
> -#define SUNXI_CTL_CS_MASK              0x3000
> -#define SUNXI_CTL_CS(cs)               (((cs) << 12) & SUNXI_CTL_CS_MASK)
> -#define SUNXI_CTL_DHB                  BIT(15)
> -#define SUNXI_CTL_CS_MANUAL            BIT(16)
> -#define SUNXI_CTL_CS_LEVEL             BIT(17)
> +#define SUNXI_TFR_CTL_XCH              BIT(10)
> +#define SUNXI_TFR_CTL_CS_MASK          0x3000
> +#define SUNXI_TFR_CTL_CS(cs)           (((cs) << 12) & SUNXI_TFR_CTL_CS_MASK)
> +#define SUNXI_TFR_CTL_DHB              BIT(15)
> +#define SUNXI_TFR_CTL_CS_MANUAL                BIT(16)
> +#define SUNXI_TFR_CTL_CS_LEVEL         BIT(17)
>  #define SUNXI_CTL_TP                   BIT(18)
>
>  #define SUNXI_INT_CTL_REG              0x0c
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index a27bf8f..f26b52a 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -26,9 +26,9 @@
>  #define SUNXI_FIFO_DEPTH               128
>
>  #define SUNXI_GBL_CTL_REG              0x04
> -#define SUNXI_GBL_CTL_BUS_ENABLE       BIT(0)
> -#define SUNXI_GBL_CTL_MASTER           BIT(1)
> -#define SUNXI_GBL_CTL_TP               BIT(7)
> +#define SUNXI_CTL_ENABLE               BIT(0)
> +#define SUNXI_CTL_MASTER               BIT(1)
> +#define SUNXI_CTL_TP                   BIT(7)

If these are bit definitions for the GBL register, why throw that
information away?

>  #define SUNXI_GBL_CTL_RST              BIT(31)
>
>  #define SUNXI_TFR_CTL_REG              0x08
> @@ -50,8 +50,8 @@
>  #define SUNXI_INT_STA_REG              0x14
>
>  #define SUNXI_FIFO_CTL_REG             0x18
> -#define SUNXI_FIFO_CTL_RF_RST          BIT(15)
> -#define SUNXI_FIFO_CTL_TF_RST          BIT(31)
> +#define SUNXI_CTL_RF_RST               BIT(15)
> +#define SUNXI_CTL_TF_RST               BIT(31)

Same here with FIFO.

>
>  #define SUNXI_FIFO_STA_REG             0x1c
>  #define SUNXI_FIFO_STA_RF_CNT_MASK     0x7f

My gut feeling on this is that we have a lot of cases of a definition
of a register offset, then definitions of the bits in that register
with that register encoded into the constant's name. You appear to be
throwing a lot of that information away which makes me worry.

Thanks,

-- 
Julian Calaby

Email: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Profile: http://www.google.com/profiles/julian.calaby/
