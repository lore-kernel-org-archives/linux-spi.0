From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH V2 1/4] pinctrl: sh-pfc: r8a7791: Add QSPI pin groups
Date: Sun, 12 Jan 2014 22:42:16 +0100
Message-ID: <1480099.289e9Xmm12@avalon>
References: <1389524433-2823-1-git-send-email-geert@linux-m68k.org> <1389524433-2823-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	"Cc: Linus Walleij" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389524433-2823-2-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

Thank you for the patch.

On Sunday 12 January 2014 12:00:30 Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> 
> A QSPI function set consists of 3 groups:
>   - qspi_ctrl (2 control wires)
>   - qspi_data2 (2 data wires, for Single/Dual SPI)
>   - qspi_data4 (4 data wires, for Quad SPI)
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> Cc: Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

and applied to my tree.

> ---
> V2:
>   - Split in 2 sets of 3 pin groups
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   63
> ++++++++++++++++++++++++++++++++++ 1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c index 654bef369ab8..0ac8264440df
> 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> @@ -2135,6 +2135,53 @@ static const unsigned int msiof2_tx_pins[] = {
>  static const unsigned int msiof2_tx_mux[] = {
>  	MSIOF2_TXD_MARK,
>  };
> +/* - QSPI
> ------------------------------------------------------------------- */
> +static const unsigned int qspi_ctrl_pins[] = {
> +	/* SPCLK, SSL */
> +	RCAR_GP_PIN(1, 4), RCAR_GP_PIN(1, 9),
> +};
> +static const unsigned int qspi_ctrl_mux[] = {
> +	SPCLK_MARK, SSL_MARK,
> +};
> +static const unsigned int qspi_data2_pins[] = {
> +	/* MOSI_IO0, MISO_IO1 */
> +	RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6),
> +};
> +static const unsigned int qspi_data2_mux[] = {
> +	MOSI_IO0_MARK, MISO_IO1_MARK,
> +};
> +static const unsigned int qspi_data4_pins[] = {
> +	/* MOSI_IO0, MISO_IO1, IO2, IO3 */
> +	RCAR_GP_PIN(1, 5), RCAR_GP_PIN(1, 6), RCAR_GP_PIN(1, 7),
> +	RCAR_GP_PIN(1, 8),
> +};
> +static const unsigned int qspi_data4_mux[] = {
> +	MOSI_IO0_MARK, MISO_IO1_MARK, IO2_MARK, IO3_MARK,
> +};
> +
> +static const unsigned int qspi_ctrl_b_pins[] = {
> +	/* SPCLK, SSL */
> +	RCAR_GP_PIN(6, 0), RCAR_GP_PIN(6, 5),
> +};
> +static const unsigned int qspi_ctrl_b_mux[] = {
> +	SPCLK_B_MARK, SSL_B_MARK,
> +};
> +static const unsigned int qspi_data2_b_pins[] = {
> +	/* MOSI_IO0, MISO_IO1 */
> +	RCAR_GP_PIN(6, 1), RCAR_GP_PIN(6, 2),
> +};
> +static const unsigned int qspi_data2_b_mux[] = {
> +	MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
> +};
> +static const unsigned int qspi_data4_b_pins[] = {
> +	/* MOSI_IO0, MISO_IO1, IO2, IO3 */
> +	RCAR_GP_PIN(6, 1), RCAR_GP_PIN(6, 2), RCAR_GP_PIN(6, 3),
> +	RCAR_GP_PIN(6, 4),
> +};
> +static const unsigned int qspi_data4_b_mux[] = {
> +	SPCLK_B_MARK, MOSI_IO0_B_MARK, MISO_IO1_B_MARK,
> +	IO2_B_MARK, IO3_B_MARK, SSL_B_MARK,
> +};
>  /* - SCIF0
> ------------------------------------------------------------------ */
> static const unsigned int scif0_data_pins[] = {
>  	/* RX, TX */
> @@ -2877,6 +2924,12 @@ static const struct sh_pfc_pin_group pinmux_groups[]
> = { SH_PFC_PIN_GROUP(msiof2_ss2),
>  	SH_PFC_PIN_GROUP(msiof2_rx),
>  	SH_PFC_PIN_GROUP(msiof2_tx),
> +	SH_PFC_PIN_GROUP(qspi_ctrl),
> +	SH_PFC_PIN_GROUP(qspi_data2),
> +	SH_PFC_PIN_GROUP(qspi_data4),
> +	SH_PFC_PIN_GROUP(qspi_ctrl_b),
> +	SH_PFC_PIN_GROUP(qspi_data2_b),
> +	SH_PFC_PIN_GROUP(qspi_data4_b),
>  	SH_PFC_PIN_GROUP(scif0_data),
>  	SH_PFC_PIN_GROUP(scif0_data_b),
>  	SH_PFC_PIN_GROUP(scif0_data_c),
> @@ -3074,6 +3127,15 @@ static const char * const msiof2_groups[] = {
>  	"msiof2_tx",
>  };
> 
> +static const char * const qspi_groups[] = {
> +	"qspi_ctrl",
> +	"qspi_data2",
> +	"qspi_data4",
> +	"qspi_ctrl_b",
> +	"qspi_data2_b",
> +	"qspi_data4_b",
> +};
> +
>  static const char * const scif0_groups[] = {
>  	"scif0_data",
>  	"scif0_data_b",
> @@ -3230,6 +3292,7 @@ static const struct sh_pfc_function pinmux_functions[]
> = { SH_PFC_FUNCTION(msiof0),
>  	SH_PFC_FUNCTION(msiof1),
>  	SH_PFC_FUNCTION(msiof2),
> +	SH_PFC_FUNCTION(qspi),
>  	SH_PFC_FUNCTION(scif0),
>  	SH_PFC_FUNCTION(scif1),
>  	SH_PFC_FUNCTION(scif2),
-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
