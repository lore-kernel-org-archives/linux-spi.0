From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 3/4] MMC core learns
	about SPI
Date: Thu, 26 Jul 2007 19:18:24 +0200
Message-ID: <20070726191824.569542fd@poseidon.drzeus.cx>
References: <200707141504.51950.david-b@pacbell.net>
	<200707141507.17484.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200707141507.17484.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, 14 Jul 2007 15:07:16 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> @@ -541,7 +548,9 @@ void mmc_rescan(struct work_struct *work
>  
>  		err = mmc_send_app_op_cond(host, 0, &ocr);
>  		if (err == MMC_ERR_NONE) {
> -			if (mmc_attach_sd(host, ocr))
> +			if (mmc_host_is_spi(host))
> +				err = mmc_spi_read_ocr(host, &ocr);
> +			if (err != MMC_ERR_NONE || mmc_attach_sd(host, ocr))
>  				mmc_power_off(host);
>  		} else {
>  			/*

Getting the OCR is not vital to determine if it's SD or MMC, so we can move that into mmc.c and sd.c, reducing the code in here.

> @@ -550,7 +559,10 @@ void mmc_rescan(struct work_struct *work
>  			 */
>  			err = mmc_send_op_cond(host, 0, &ocr);
>  			if (err == MMC_ERR_NONE) {
> -				if (mmc_attach_mmc(host, ocr))
> +				if (mmc_host_is_spi(host))
> +					err = mmc_spi_read_ocr(host, &ocr);
> +				if (err != MMC_ERR_NONE
> +						|| mmc_attach_mmc(host, ocr))
>  					mmc_power_off(host);
>  			} else {
>  				mmc_power_off(host);

This will fail to initialise a high capacity MMC card. From the MMC spec:

"Without the CMD58 with bits [30:29] set as "10b" in prior to the CMD1 a higher than 2GB of density of memory will remain in Idle state forever."

> @@ -95,14 +106,18 @@ int mmc_send_op_cond(struct mmc_host *ho
>  
>  	cmd.opcode = MMC_SEND_OP_COND;
>  	cmd.arg = ocr;

Argument is "None", not "Ignored", so this should be 0 for SPI.

>  
> -	mmc_set_data_timeout(&data, card, 0);
> +	/* Note that for MMC_SEND_EXT_CSD we could set the timeout; but
> +	 * not for the other requests. But host->card isn't set yet!
> +	 */
>  

This will break on native hosts as a timeout of 0 means exactly that.

> +
> +int mmc_spi_send_cid(struct mmc_host *host, u32 *cid)
> +{
> +	if (!mmc_host_is_spi(host))
> +		return mmc_send_cxd_native(host, 0, cid, MMC_SEND_CID);
> +
> +	return mmc_send_cxd_data(host, MMC_SEND_CID, cid, 16);
> +}
> +

As this is not SPI specific (except for its current use), why not mmc_send_cid() ?

And the argument for it is the RCA (in native mode).

> +
> +/* Enabling software CRCs can be a significant (30%) performance cost,
> + * and for other reasons isn't always desired; so it can be disabled.
> + */
> +static int use_spi_crc = 1;
> +module_param(use_spi_crc, bool, 0);
> +

The *_ops.c only contain function wrappers of protocol commands, not policy. So I think this is better placed where mmc_spi_set_crc() is called.

> --- g26.orig/drivers/mmc/core/mmc.c	2007-07-14 14:47:12.000000000 -0700
> +++ g26/drivers/mmc/core/mmc.c	2007-07-14 14:47:54.000000000 -0700
> @@ -264,7 +264,13 @@ static int mmc_init_card(struct mmc_host
>  	/*
>  	 * Fetch CID from card.
>  	 */
> -	err = mmc_all_send_cid(host, cid);
> +	if (mmc_host_is_spi(host)) {
> +		err = mmc_spi_set_crc(host);
> +		if (err != MMC_ERR_NONE)
> +			goto err;
> +		err = mmc_spi_send_cid(host, cid);
> +	} else
> +		err = mmc_all_send_cid(host, cid);
>  	if (err != MMC_ERR_NONE)
>  		goto err;
>  

A matter of taste, but wouldn't it be clearer if you separated out the crc bit and did that earlier, before the above comment?

> --- g26.orig/drivers/mmc/core/sd.c	2007-07-14 14:47:12.000000000 -0700
> +++ g26/drivers/mmc/core/sd.c	2007-07-14 14:47:54.000000000 -0700
> @@ -321,7 +321,13 @@ static int mmc_sd_init_card(struct mmc_h
>  	/*
>  	 * Fetch CID from card.
>  	 */
> -	err = mmc_all_send_cid(host, cid);
> +	if (mmc_host_is_spi(host)) {
> +		err = mmc_spi_set_crc(host);
> +		if (err != MMC_ERR_NONE)
> +			goto err;
> +		err = mmc_spi_send_cid(host, cid);
> +	} else
> +		err = mmc_all_send_cid(host, cid);
>  	if (err != MMC_ERR_NONE)
>  		goto err;
>  

Ditto.

> --- g26.orig/drivers/mmc/core/sd_ops.c	2007-07-14 14:47:12.000000000 -0700
> +++ g26/drivers/mmc/core/sd_ops.c	2007-07-14 14:47:54.000000000 -0700
> @@ -70,6 +70,12 @@ int mmc_wait_for_app_cmd(struct mmc_host
>  		err = cmd->error;
>  		if (cmd->error == MMC_ERR_NONE)
>  			break;
> +
> +		/* no point in retrying illegal commands! */
> +		if (mmc_host_is_spi(host)) {
> +			if (cmd->resp[0] & R1_SPI_ILLEGAL_COMMAND)
> +				break;
> +		}
>  	}
>  
>  	return err;

"Illegal command" refers to the previous command sent (and failed). So this can give false negatives.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
