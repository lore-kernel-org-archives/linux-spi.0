From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/spi_topcliff_pch.c Typo change threhold to
 threshold
Date: Fri, 31 Dec 2010 17:49:44 -0700
Message-ID: <20110101004944.GC19643@angua.secretlab.ca>
References: <1293817831-8263-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: "Justin P. Mattock" <justinmattock@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1293817831-8263-1-git-send-email-justinmattock@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Dec 31, 2010 at 09:50:31AM -0800, Justin P. Mattock wrote:
> The below patch changes a typo from "threhold" to "threshold".
> Let me know if I missed anything.
> 
> Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

Applied, thanks.

g.

> 
> ---
>  drivers/spi/spi_topcliff_pch.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi_topcliff_pch.c b/drivers/spi/spi_topcliff_pch.c
> index 58e187f..be451e3 100644
> --- a/drivers/spi/spi_topcliff_pch.c
> +++ b/drivers/spi/spi_topcliff_pch.c
> @@ -677,7 +677,7 @@ static void pch_spi_set_ir(struct pch_spi_data *data)
>  {
>  	/* enable interrupts */
>  	if ((data->bpw_len) > PCH_MAX_FIFO_DEPTH) {
> -		/* set receive threhold to PCH_RX_THOLD */
> +		/* set receive threshold to PCH_RX_THOLD */
>  		pch_spi_setclr_reg(data->master, PCH_SPCR,
>  				   PCH_RX_THOLD << SPCR_TFIC_FIELD,
>  				   ~MASK_TFIC_SPCR_BITS);
> @@ -685,7 +685,7 @@ static void pch_spi_set_ir(struct pch_spi_data *data)
>  		pch_spi_setclr_reg(data->master, PCH_SPCR,
>  				   SPCR_RFIE_BIT | SPCR_TFIE_BIT, 0);
>  	} else {
> -		/* set receive threhold to maximum */
> +		/* set receive threshold to maximum */
>  		pch_spi_setclr_reg(data->master, PCH_SPCR,
>  				   PCH_RX_THOLD_MAX << SPCR_TFIC_FIELD,
>  				   ~MASK_TFIC_SPCR_BITS);
> -- 
> 1.6.5.2.180.gc5b3e
> 
