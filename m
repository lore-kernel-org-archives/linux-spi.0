From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 4/4] mach-u300: set apropriate FIFO trigger levels
Date: Thu, 16 Jun 2011 06:22:35 -0600
Message-ID: <20110616122235.GA31534@ponder.secretlab.ca>
References: <1308212094-22592-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1308212094-22592-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 16, 2011 at 10:14:54AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> The U300 just defined the fill level limits for the FIFOs to
> 1 item out of habit. It can easily handle four.
> 
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

I assume this one will go via your tree?

g.

> ---
>  arch/arm/mach-u300/spi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
> index 5767208..7b597e2 100644
> --- a/arch/arm/mach-u300/spi.c
> +++ b/arch/arm/mach-u300/spi.c
> @@ -40,8 +40,8 @@ struct pl022_config_chip dummy_chip_info = {
>  	.hierarchy = SSP_MASTER,
>  	/* 0 = drive TX even as slave, 1 = do not drive TX as slave */
>  	.slave_tx_disable = 0,
> -	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
> -	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
> +	.rx_lev_trig = SSP_RX_4_OR_MORE_ELEM,
> +	.tx_lev_trig = SSP_TX_4_OR_MORE_EMPTY_LOC,
>  	.ctrl_len = SSP_BITS_12,
>  	.wait_state = SSP_MWIRE_WAIT_ZERO,
>  	.duplex = SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
> -- 
> 1.7.3.2
> 

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
