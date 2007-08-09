From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 3/4 2.6.23-rc2 + mm2-git-mmc] MMC
	core learns about SPI
Date: Thu, 9 Aug 2007 15:07:47 +0200
Message-ID: <20070809150747.62b1447a@poseidon.drzeus.cx>
References: <200708080906.18993.david-b@pacbell.net>
	<200708080911.33099.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708080911.33099.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, 8 Aug 2007 09:11:32 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> @@ -68,21 +72,26 @@ int mmc_io_rw_direct(struct mmc_card *ca
>  	cmd.arg |= (write && out) ? 0x08000000 : 0x00000000;
>  	cmd.arg |= addr << 9;
>  	cmd.arg |= in;
> -	cmd.flags = MMC_RSP_R5 | MMC_CMD_AC;
> +	cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC;
>  
>  	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>  	if (err)
>  		return err;
>  
> -	if (cmd.resp[0] & R5_ERROR)
> -		return -EIO;
> -	if (cmd.resp[0] & R5_FUNCTION_NUMBER)
> -		return -EINVAL;
> -	if (cmd.resp[0] & R5_OUT_OF_RANGE)
> -		return -ERANGE;
> +	if (mmc_host_is_spi(card->host)) {
> +		if (out)
> +			*out = (cmd.resp[0] >> 8) & 0xFF;
> +	} else {
> +		if (cmd.resp[0] & R5_ERROR)
> +			return -EIO;
> +		if (cmd.resp[0] & R5_FUNCTION_NUMBER)
> +			return -EINVAL;
> +		if (cmd.resp[0] & R5_OUT_OF_RANGE)
> +			return -ERANGE;
>  
> -	if (out)
> -		*out = cmd.resp[0] & 0xFF;
> +		if (out)
> +			*out = cmd.resp[0] & 0xFF;
> +	}
>  
>  	return 0;
>  }

What about error bits in the spi case? And could you do two if:s, one
for the error bits, and one for the different handling of getting the
data? I think that would be clearer in detailing the differences.

> @@ -131,12 +140,14 @@ int mmc_io_rw_extended(struct mmc_card *
>  	if (data.error)
>  		return data.error;
>  
> -	if (cmd.resp[0] & R5_ERROR)
> -		return -EIO;
> -	if (cmd.resp[0] & R5_FUNCTION_NUMBER)
> -		return -EINVAL;
> -	if (cmd.resp[0] & R5_OUT_OF_RANGE)
> -		return -ERANGE;
> +	if (!mmc_host_is_spi(card->host)) {
> +		if (cmd.resp[0] & R5_ERROR)
> +			return -EIO;
> +		if (cmd.resp[0] & R5_FUNCTION_NUMBER)
> +			return -EINVAL;
> +		if (cmd.resp[0] & R5_OUT_OF_RANGE)
> +			return -ERANGE;
> +	}
>  
>  	return 0;
>  }
> 
> 

Ditto on the error bits.

The emperor expects a follow-up patch.

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
