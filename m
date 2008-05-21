From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling
 support for the card detect line
Date: Wed, 21 May 2008 21:28:31 +0200
Message-ID: <20080521212831.523f344b@mjolnir.drzeus.cx>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<20080517133633.5aa26938@mjolnir.drzeus.cx>
	<20080521184713.GA30284@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080521184713.GA30284-PHTr8nzUCjejyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
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

On Wed, 21 May 2008 22:47:13 +0400
Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org> wrote:

> 
> Calling get_cd() for every request smells like overhead, especially given
> that that get_cd() could ask for GPIO status via relatively slow bus (like
> I2C GPIO expanders). So, polling seems most reasonable solution here, no
> need to call it very often.
> 

Fair enough. You should probably add a comment about this somewhere so
that people do not call get_cd() in the core request function and
similar places. Place it so that both get_cd() and get_ro() are covered
though, as it should be relevant for both.

> How about these patches? Tested with and without get_cd() optimization.
> 

Very nice. But I have some concerns:

> @@ -53,6 +53,7 @@ struct mmc_host_ops {
>  	void	(*request)(struct mmc_host *host, struct mmc_request *req);
>  	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
>  	int	(*get_ro)(struct mmc_host *host);
> +	int	(*get_cd)(struct mmc_host *host);
>  	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
>  };

I'm always nervous when it comes to adding more callbacks, but I
suppose I've resisted this one for far too long already.

> +	if (host->ops->get_cd) {
> +		int old_cd_status = host->cd_status;
> +
> +		host->cd_status = !!host->ops->get_cd(host);
> +		if (!(old_cd_status ^ host->cd_status)) {
> +			mmc_bus_put(host);
> +			goto out;
> +		}
> +	}
> +

This should only be done when there is no bus handler. Since we are
polling, we might actually miss the user removing and reinserting the
card. The only way to check for that is to poke the card and see if it
is still alive. This also means you won't need that state variable.

Also, that second if clause seems fit for an obfuscation contest. ;)

> p.s. Since mmc_host_ops no longer the same for every instance of
> mmc_spi, struct mmc_host_ops can't be const and should be allocated
> dynamically.

This can be solved by allowing get_cd() to return an error that will be
treated as if get_cd() wasn't defined. -ENODEV seems suitable.

(get_ro() needs the same treatment, but I haven't gotten around to
that)

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
