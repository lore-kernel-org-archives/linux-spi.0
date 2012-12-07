From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH resend] spi: Add support for specifying 3-wire mode via
 device tree
Date: Fri, 07 Dec 2012 13:14:05 +0000
Message-ID: <20121207131405.EBFDE3E0B87@localhost>
References: <1354809333-18364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
 linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354809333-18364-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

On Thu,  6 Dec 2012 16:55:33 +0100, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
> This patch allows to specify that a SPI device is connected in 3-wire mode via
> device tree.
> 
> Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
> Acked-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Applied, thanks.

g.

> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 2 ++
>  drivers/spi/spi.c                                 | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> index 77a8b0d..296015e 100644
> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> @@ -53,6 +53,8 @@ contain the following properties.
>      		shifted clock phase (CPHA) mode
>  - spi-cs-high     - (optional) Empty property indicating device requires
>      		chip select active high
> +- spi-3wire       - (optional) Empty property indicating device requires
> +    		    3-wire mode.
>  
>  If a gpio chipselect is used for the SPI slave the gpio number will be passed
>  via the cs_gpio
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 22c71e2..cb61ada 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -861,6 +861,8 @@ static void of_register_spi_devices(struct spi_master *master)
>  			spi->mode |= SPI_CPOL;
>  		if (of_find_property(nc, "spi-cs-high", NULL))
>  			spi->mode |= SPI_CS_HIGH;
> +		if (of_find_property(nc, "spi-3wire", NULL))
> +			spi->mode |= SPI_3WIRE;
>  
>  		/* Device speed */
>  		prop = of_get_property(nc, "spi-max-frequency", &len);
> -- 
> 1.8.0
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
