From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [patch 2.6.26-rc8] spi:
	spi_mpc83xx	clockrate fixes
Date: Thu, 3 Jul 2008 20:23:47 +0400
Message-ID: <20080703162347.GA2647@polina.dev.rtsoft.ru>
References: <200806271821.50913.david-b@pacbell.net>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Chen Gong <g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806271821.50913.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Fri, Jun 27, 2008 at 06:21:50PM -0700, David Brownell wrote:
> From: Chen Gong <g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Subject: [PATCH] fix spi_mpc83xx prescale
> 
> This updates the SPI clock rate calculations for the spi_mpc83xx
> driver.  Some boundary conditions were wrong, and in several cases
> divide-by-16 wasn't always needed
> 
> Signed-off-by: Chen Gong <g.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---

Hmmm...

David, maybe I'm completely misunderstood this patch (again), but it seems
wrong to me:

http://ozlabs.org/pipermail/linuxppc-dev/2008-June/058253.html
(Chen posted this patch separately to linuxppc-dev and spi lists)

I would be more happy if Chen could explain which boundary conditions
were wrong.

Something like I did once:

commit a44648b057f5331fe6c0e863dc693ed335490e7a
Author: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Date:   Fri Aug 10 13:01:02 2007 -0700

    spi_mpc83xx: fix prescale modulus calculation

    Long ago I've noticed (but didn't pay much attention) that
    spi_mpc83xx using PM calculations that differs from what
    specs describe. I.e.

    u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 4);

    While specs says: "The SPI baud rate generator clock source (either
    system clock or system clock divided by 16, depending on DIV16 bit) is
    divided by 4 * ([PM] + 1), a range from 4 to 64.".

    Thus " - 1" is missing in the spi_mpc83xx's formula.

    Why nobody noticed that bug? Probably because sysclk usually less then
    user expects, e.g. you expect 200 MHz, but real clock is 198 MHz,
    and integer rounding helps when this formula is used.

    Suppose it's SPI in QE, SYSCLK at 198 MHz, thus SPIBRG at 99MHz, 25 MHz
    requested.

    PM = (99MHz / ( 25 MHz * 4 )), PM == 0, output SPICLK will be 24.75 MHz

    At lower frequencies this bug is more noticeable, though.

    And this bug shows itself in all its beauty if SYSCLK is equal or a bit
    more than you expect (200 MHz SYSCLK, 100 MHz SPIBRG):
    PM = (100MHz / ( 25 MHz * 4 )), PM == 1, output SPICLK will be 12.625 MHz!

At the time I posted this patch, I tested SPICLK outputs by an oscilloscope,
and with SYSCLK 198 MHz everything was (and is, I suppose) just fine.

>  drivers/spi/spi_mpc83xx.c |   29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> --- a/drivers/spi/spi_mpc83xx.c	2008-05-13 15:17:37.000000000 -0700
> +++ b/drivers/spi/spi_mpc83xx.c	2008-06-27 18:17:17.000000000 -0700
> @@ -266,21 +266,24 @@ int mpc83xx_spi_setup_transfer(struct sp
>  
>  	cs->hw_mode |= SPMODE_LEN(bits_per_word);
>  
> -	if ((mpc83xx_spi->spibrg / hz) >= 64) {
> -		pm = mpc83xx_spi->spibrg / (hz * 64) - 1;
> -		if (pm > 0x0f) {
> -			dev_err(&spi->dev, "Requested speed is too "
> -				"low: %d Hz. Will use %d Hz instead.\n",
> -				hz, mpc83xx_spi->spibrg / 1024);
> -			pm = 0x0f;
> +	if ((mpc83xx_spi->spibrg / hz) > 64) {
> +		pm = mpc83xx_spi->spibrg / (hz * 64);
> +		if (pm > 16) {
> +			cs->hw_mode |= SPMODE_DIV16;
> +			pm /= 16;
> +			if (pm > 16) {
> +				dev_err(&spi->dev, "Requested speed is too "
> +					"low: %d Hz. Will use %d Hz instead.\n",
> +					hz, mpc83xx_spi->spibrg / 1024);
> +				pm = 16;
> +			}
>  		}
> -		cs->hw_mode |= SPMODE_PM(pm) | SPMODE_DIV16;
> -	} else {
> +	} else
>  		pm = mpc83xx_spi->spibrg / (hz * 4);
> -		if (pm)
> -			pm--;
> -		cs->hw_mode |= SPMODE_PM(pm);
> -	}
> +	if (pm)
> +		pm--;
> +
> +	cs->hw_mode |= SPMODE_PM(pm);
>  	regval =  mpc83xx_spi_read_reg(&mpc83xx_spi->base->mode);
>  	if (cs->hw_mode != regval) {
>  		unsigned long flags;
> 

-- 
Anton Vorontsov
email: cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
