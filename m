From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] at25: call spi_setup before
	read/write access
Date: Wed, 23 Jul 2008 11:37:28 -0700
Message-ID: <200807231137.29170.david-b@pacbell.net>
References: <BD79186B4FD85F4B8E60E381CAEE190948112F@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190948112F-KURmP/Qoe8Pmp66j18f85VaTQe2KTcn/@public.gmane.org>
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

On Wednesday 23 July 2008, hartleys wrote:
> This patch makes the at25 driver call spi_setup before any read/write
> access to the eeprom to insure that the device mode and clock is set
> correctly.

Why would this be needed though?  It was called before probe(), and
nothing changed the setup ... so it should still be valid.


> Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> 
> 
> --- orig/linux-2.6.25.10/drivers/spi/at25.c	2008-07-02
> 20:46:47.000000000 -0700
> +++
> /home/bigguiness/buildroot/project_build_arm/ep9307/linux-2.6.25.10/driv
> ers/spi/at25.c	2008-07-23 10:45:51.000000000 -0700
> @@ -134,6 +134,8 @@ at25_bin_read(struct kobject *kobj, stru
>  	if (unlikely(!count))
>  		return count;
>  
> +	spi_setup(at25->spi);
> +
>  	return at25_ee_read(at25, buf, off, count);
>  }
>  
> @@ -260,6 +262,8 @@ at25_bin_write(struct kobject *kobj, str
>  	if (unlikely(!count))
>  		return count;
>  
> +	spi_setup(at25->spi);
> +
>  	return at25_ee_write(at25, buf, off, count);
>  }
>   
> 



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
