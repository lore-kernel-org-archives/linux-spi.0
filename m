From: "Joakim Tjernlund" <Joakim.Tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH] spi_mpc83xx: handle odd transfer
	sizes
Date: Wed, 10 Sep 2008 23:48:09 +0200
Message-ID: <16243.1497280069$1221083374@news.gmane.org>
References: <1221041160-19342-1-git-send-email-jacmet@sunsite.dk>
	<200809101028.01997.david-b@pacbell.net>
	<87k5djdeew.fsf@macbook.be.48ers.dk>
	<200809101405.39285.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "'David Brownell'" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	"'Peter Korsgaard'" <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200809101405.39285.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Language: sv
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



> -----Original Message-----
> From: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]
> Sent: den 10 september 2008 23:06
> To: Peter Korsgaard
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; joakim.tjernlund-SNLAxHN9vbcOP4wsBPIw7w@public.gmane.org
> Subject: Re: [PATCH] spi_mpc83xx: handle odd transfer sizes
> 
> On Wednesday 10 September 2008, Peter Korsgaard wrote:
> > It would indeed be clearer to change it to to return -errno on errors
> > instead, but the problem my patch solves is real (crash on too small
> > message lengths) and I wanted to keep the patch to it's minimum now
> > that we're so close to 2.6.27.
> >
> > But I can change it to use return -EINVAL instead if you prefer - The
> > caller doesn't care as long as it's != 0.
> >
> > Then we can do the real cleanup later and push it for 2.6.28.
> 
> OK, I was thinking this minimal tweak to your patch.  It adds only
> one more patch segment, and makes the routine obey stndard kernel
> calling conventions ... still a small patch.  :)

Yes, this is fine, but ..
> 
> 
> 
> --- g26.orig/drivers/spi/spi_mpc83xx.c	2008-09-10 14:03:03.000000000 -0700
> +++ g26/drivers/spi/spi_mpc83xx.c	2008-09-10 10:27:23.000000000 -0700
> @@ -315,13 +315,13 @@ static int mpc83xx_spi_bufs(struct spi_d
>  	if (bits_per_word > 8) {
>  		/* invalid length? */
>  		if (len & 1)
> -			return len;
> +			return -EINVAL;
>  		len /= 2;
>  	}
>  	if (bits_per_word > 16) {
>  		/* invalid length? */
>  		if (len & 1)
> -			return len;
> +			return -EINVAL;
>  		len /= 2;
>  	}
>  	mpc83xx_spi->count = len;
> @@ -340,7 +340,7 @@ static int mpc83xx_spi_bufs(struct spi_d
>  	/* disable rx ints */
>  	mpc83xx_spi_write_reg(&mpc83xx_spi->base->mask, 0);
> 
> -	return mpc83xx_spi->count;
> +	return 0;
This hunk should probably stay untouched, not sure the mpc83xx_spi->count always
is zero in case of TX errors.

 Jocke



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
