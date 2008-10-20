From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] mtd m25p80: add support for
	Macronix MX25L12805D
Date: Sun, 19 Oct 2008 17:12:07 -0700
Message-ID: <200810191712.08047.david-b@pacbell.net>
References: <20081019173252.GA16094@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, nico-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
	prafulla-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
To: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20081019173252.GA16094-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I'll let you sort this out over on the MTD list.  I'm fine
with the patch, but it won't apply against the version in
the MTD GIT tree...


On Sunday 19 October 2008, Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index b35c333..299047e 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -467,6 +467,9 @@ static struct flash_info __devinitdata m25p_data [] = {
>  	{ "at26df161a", 0x1f4601, 64 * 1024, 32, SECT_4K, },
>  	{ "at26df321",  0x1f4701, 64 * 1024, 64, SECT_4K, },
>  
> +	/* Macronix */
> +	{ "mx25l12805d", 0xc22018, 64 * 1024, 256, SECT_4K, },
> +
>  	/* Spansion -- single (large) sector size only, at least
>  	 * for the chips listed here (without boot sectors).
>  	 */
> 
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
