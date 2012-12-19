From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH V2] spi: remove check for bits_per_word on transfer from
	low level driver
Date: Wed, 19 Dec 2012 16:24:33 +0000
Message-ID: <20121219162433.1E1E43E0BCF@localhost>
References: <1355820943-25228-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org,
	baohua.song-kQvG35nSl+M@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1355820943-25228-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 18 Dec 2012 14:25:43 +0530, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> The spi core make sure that each transfer structure have the proper
> setting for bits_per_word before calling low level transfer APIs.
> 
> Hence it is no more require to check again in low level driver for
> this field whether this is set correct or not. Removing such code
> from low level driver.
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
[...]
> diff --git a/drivers/spi/spi-txx9.c b/drivers/spi/spi-txx9.c
> index d5a3cbb..550b5f4 100644
> --- a/drivers/spi/spi-txx9.c
> +++ b/drivers/spi/spi-txx9.c
> @@ -189,9 +189,8 @@ static void txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
>  		unsigned int len = t->len;
>  		unsigned int wsize;
>  		u32 speed_hz = t->speed_hz ? : spi->max_speed_hz;
> -		u8 bits_per_word = t->bits_per_word ? : spi->bits_per_word;
> +		u8 bits_per_word = t->bits_per_word;
>  
> -		bits_per_word = bits_per_word ? : 8;
>  		wsize = bits_per_word >> 3; /* in bytes */
>  
>  		if (prev_speed_hz != speed_hz
> @@ -316,9 +315,8 @@ static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)
>  	/* check each transfer's parameters */
>  	list_for_each_entry (t, &m->transfers, transfer_list) {
>  		u32 speed_hz = t->speed_hz ? : spi->max_speed_hz;
> -		u8 bits_per_word = t->bits_per_word ? : spi->bits_per_word;
> +		u8 bits_per_word = t->bits_per_word;
>  
> -		bits_per_word = bits_per_word ? : 8;

Have you verified here that bits_per_word can never be '0' here? What is
the path that ensures spi->bits_per_word (and hence t->bits_per_word) is
set to 8 here?

Otherwise the patch looks good. Thanks for doing this work.

g.


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
