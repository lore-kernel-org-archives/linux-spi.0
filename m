From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: S3C24XX: Ensure GPIO pins are configure
	properly on init and resume.
Date: Thu, 31 Jul 2008 01:14:42 -0700
Message-ID: <200807310114.42424.david-b@pacbell.net>
References: <20080729170053.251716620@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080729170053.251716620-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Content-Disposition: inline
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

On Tuesday 29 July 2008, Ben Dooks wrote:

> @@ -412,6 +428,26 @@ static int s3c24xx_spi_suspend(struct pl
>  {
>  	struct s3c24xx_spi *hw = platform_get_drvdata(pdev);
>  
> +	/* Place the gpio associated with the controller into input over

Well, input-with-pullup.  As usual, we don't want inputs to float.  :)


> +	 * suspend as on resume the controller is reset and will end up
> +	 * as a slave until we reconfigure it in the resume path.

Kind of unfriendly, and not something I've seen much on ARM, FWIW.

I generally like to see pinmux stuff kept out of drivers, since it
tends to change between revisions more than the controller design.
I take it that's not yet an issue with this controller ...


> 					This 
> +	 * means that we cannot allow the controller to drive MISO line
> +	 * during this period in case it drives against something on the
> +	 * board.
> +	 */
> +

What I don't get is that there are two outputs other than chipselect
(SCK on GPE13 and GPG7, and MOSI on GPE12 and GPG6), and you seem to
remux those on bus 0 but *NOT* bus 1:

> +	if (pdev->id == 0) {
> +		s3c2410_gpio_pullup(S3C2410_GPE12, 1);
> +		s3c2410_gpio_pullup(S3C2410_GPE13, 1);
> +		s3c2410_gpio_cfgpin(S3C2410_GPE12, S3C2410_GPIO_INPUT);
> +		s3c2410_gpio_cfgpin(S3C2410_GPE11, S3C2410_GPIO_INPUT);
> +	} else {
> +		s3c2410_gpio_pullup(S3C2410_GPG5, 1);
> +		s3c2410_gpio_pullup(S3C2410_GPG6, 1);
> +		s3c2410_gpio_cfgpin(S3C2410_GPG6, S3C2410_GPIO_INPUT);
> +		s3c2410_gpio_cfgpin(S3C2410_GPG5, S3C2410_GPIO_INPUT); 

... where you do GPG6/MOSI alright, but GPG5/MISO not GPG7/SCK.

Or is the suspend side of your patch inconsistent with the resume side?



> +	}
> +
>  	clk_disable(hw->clk);
>  	return 0;
>  }
> 
>

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
