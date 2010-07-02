From: Brian Niebuhr <BNiebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Subject: Re: [PATCH] spi: bitbang: reinitialize transfer
	parameters for every message
Date: Fri, 2 Jul 2010 10:37:12 -0500
Message-ID: <BA34378D1528D04CB3C865B8BAB2472B035F54@transmx01.transcrypt.local>
References: <1278084617-23027-1-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org
To: "Brian Niebuhr" <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Class: urn:content-classes:message
In-Reply-To: <1278084617-23027-1-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> This patch fixes the setup_transfer logic to account for the 
> case where
> multiple messages to different SPI devices are in the queue 
> simultaneously.
> With the current logic, the second message in the queue will end up
> using the transfer parameters for the previous message in the queue.
> 
> The fix is to reinitialize the transfer parameters for each message
> rather than only once on the first message.
> 
> Signed-off-by: Brian Niebuhr <bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
> ---
>  drivers/spi/spi_bitbang.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
> index 5265330..8b55724 100644
> --- a/drivers/spi/spi_bitbang.c
> +++ b/drivers/spi/spi_bitbang.c
> @@ -259,7 +259,6 @@ static void bitbang_work(struct work_struct *work)
>  	struct spi_bitbang	*bitbang =
>  		container_of(work, struct spi_bitbang, work);
>  	unsigned long		flags;
> -	int			do_setup = -1;
>  	int			(*setup_transfer)(struct spi_device *,
>  					struct spi_transfer *);
>  
> @@ -275,6 +274,7 @@ static void bitbang_work(struct work_struct *work)
>  		unsigned		tmp;
>  		unsigned		cs_change;
>  		int			status;
> +		int			do_setup = -1;
>  
>  		m = container_of(bitbang->queue.next, struct 
> spi_message,
>  				queue);
> @@ -307,6 +307,8 @@ static void bitbang_work(struct work_struct *work)
>  				status = setup_transfer(spi, t);
>  				if (status < 0)
>  					break;
> +				if (do_setup == -1)
> +					do_setup = 0;
>  			}
>  
>  			/* set up default clock polarity, and 
> activate chip;
> @@ -367,11 +369,6 @@ static void bitbang_work(struct 
> work_struct *work)
>  		m->status = status;
>  		m->complete(m->context);
>  
> -		/* restore speed and wordsize if it was overridden */
> -		if (do_setup == 1)
> -			setup_transfer(spi, NULL);
> -		do_setup = 0;
> -
>  		/* normally deactivate chipselect ... unless no 
> error and
>  		 * cs_change has hinted that the next message 
> will probably
>  		 * be for this chip too.
> -- 
> 1.6.3.3

Hopefully this version should address all of the previous comments.  I
tested it on my board with multiple spi devices, each using different
transfer parameters, and it still works.

Brian


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
