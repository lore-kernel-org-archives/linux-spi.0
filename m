From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH 14/26] spi: dw-pci: constify local structures
Date: Mon, 12 Sep 2016 14:01:49 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1609121400350.3049@hadrien>
References: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr> <1473599168-30561-15-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473599168-30561-15-git-send-email-Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On Sun, 11 Sep 2016, Julia Lawall wrote:

> For structure types defined in the same file or local header files, find
> top-level static structure declarations that have the following
> properties:
> 1. Never reassigned.
> 2. Address never taken
> 3. Not passed to a top-level macro call
> 4. No pointer or array-typed field passed to a function or stored in a
> variable.
> Declare structures having all of these properties as const.

Please ignore this patch.  The file contains eg

{ PCI_VDEVICE(INTEL, 0x0800), (kernel_ulong_t)&spi_pci_mid_desc_1}

which Coccinelle was incorrectly interpreting as a bit and operation, due
to not realizing that kernel_ulong_t is a type.

julia

> Done using Coccinelle.
> Based on a suggestion by Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>.
>
> Signed-off-by: Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>
>
> ---
> The semantic patch seems too long for a commit log, but is in the cover
> letter.
>
>  drivers/spi/spi-dw-pci.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
> index ef7db75..60198a3 100644
> --- a/drivers/spi/spi-dw-pci.c
> +++ b/drivers/spi/spi-dw-pci.c
> @@ -29,13 +29,13 @@ struct spi_pci_desc {
>  	u16	bus_num;
>  };
>
> -static struct spi_pci_desc spi_pci_mid_desc_1 = {
> +static const struct spi_pci_desc spi_pci_mid_desc_1 = {
>  	.setup = dw_spi_mid_init,
>  	.num_cs = 5,
>  	.bus_num = 0,
>  };
>
> -static struct spi_pci_desc spi_pci_mid_desc_2 = {
> +static const struct spi_pci_desc spi_pci_mid_desc_2 = {
>  	.setup = dw_spi_mid_init,
>  	.num_cs = 2,
>  	.bus_num = 1,
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
