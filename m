From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH 1/3 v3]spi: controller driver for
	Designware SPI core
Date: Mon, 12 Oct 2009 15:23:04 -0700
Message-ID: <20091012152304.9ebc6077.akpm@linux-foundation.org>
References: <20091012141915.5c8aa520@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091012141915.5c8aa520@feng-desktop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 12 Oct 2009 14:19:15 +0800
Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> >From 2945f4eab344742d878ea10a774285fe770e6b10 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date: Sat, 10 Oct 2009 14:55:48 +0800
> Subject: [PATCH 1/3] spi: controller driver for Designware SPI core
> 
> Driver for the Designware SPI core, it supports multipul interfaces
> like PCI/APB etc. User can use "dw_apb_ssi_db.pdf" from Synopsys as
> HW datasheet.
> 
> ...
>
> +#define START_STATE	((void *)0)
> +#define RUNNING_STATE	((void *)1)
> +#define DONE_STATE	((void *)2)
> +#define ERROR_STATE	((void *)-1)

What's going on here?

>
> ...
>
> +static void *next_transfer(struct dw_spi *dws)
> +{
> +	struct spi_message *msg = dws->cur_msg;
> +	struct spi_transfer *trans = dws->cur_transfer;
> +
> +	/* Move to next transfer */
> +	if (trans->transfer_list.next != &msg->transfers) {
> +		dws->cur_transfer =
> +			list_entry(trans->transfer_list.next,
> +					struct spi_transfer,
> +					transfer_list);
> +		return RUNNING_STATE;
> +	} else
> +		return DONE_STATE;
> +}

Seems that you only need a single word of device-private storage in
`struct spi_message'.  So instead of kmallocing enough memory to store
the `state' value, you've stuffed that value directly into the
spi_message, pretending to be a kernel address.

Correct?

If so, it's a bit nasty but probabyl a worthwhile thing to do.  It'd be
nice to add a code comment somewhere explaining this.  Plasing it at
the definition site of the *_STATE values would be appropriate.  



------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
