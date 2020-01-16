From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/7] dt-bindings: mmc: fsl-imx-esdhc: add i.MX8MP
 compatible string
Date: Thu, 16 Jan 2020 16:37:23 +0100
Message-ID: <CAPDyKFqbWrj5XruJW3ooQSzw51YAg2ukrjdBdkBx1szTU=5DJA@mail.gmail.com>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com> <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Vinod Koul <vkoul-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Andrey Smirnov <andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        rjones-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org,
        Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
        sebastien.szymanski-d2DlULPkwbNWk0Htik3J/w@public.gmane.org,
        Aisheng Dong <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, richard.hu-Ynyd8CyeeRDSUeElwK9/Pw@public.gmane.org,
        angus-HsWYs6tNinE@public.gmane.org, cosmin.stoica-3arQi8VN3Tc@public.gmane.org,
        Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Rabeeh Khoury <rabeeh-UBr1pzP51AyaMJb+Lgu22Q@public.gmane.org>,
        Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>,
To: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1578893602-14395-2-git-send-email-Anson.Huang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 13 Jan 2020 at 06:37, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org> wrote:
>
> Add compatible string for imx8mp
>
> Signed-off-by: Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> New patch
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 2fb466c..c93643f 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -21,6 +21,7 @@ Required properties:
>                "fsl,imx8mq-usdhc"
>                "fsl,imx8mm-usdhc"
>                "fsl,imx8mn-usdhc"
> +              "fsl,imx8mp-usdhc"
>                "fsl,imx8qxp-usdhc"
>
>  Optional properties:
> --
> 2.7.4
>
