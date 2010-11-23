From: David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
Subject: Re: spi/spi: don't release the spi device twice
Date: Tue, 23 Nov 2010 01:43:01 +0100
Message-ID: <20101123004301.GA1034746@jupiter.n2.diac24.net>
References: <20101122133503.GA25553@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101122133503.GA25553-Hfxr4Dq0UpYb1SvskN2V4Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Nov 22, 2010 at 01:35:03PM -0000, Sebastian Andrzej Siewior wrote:
> According to my debug printks, the loop
> 
> | dummy = device_for_each_child(master->dev.parent, &master->dev,
> | 		__unregister);
> 
> calls __unregister for all childs of spi devicee (spidev in my case) and
> the spi device itself. So calling device_unregister() for the device
> itself leads to trouble.
> This seems to be comming from  3486008 aka ("spi: free children in
> spi_unregister_master, not siblings") so therefore I cc stable for v36.

This code is the old code, before patch 3486008 which you're citing.
3486008 does:

-       dummy = device_for_each_child(master->dev.parent, &master->dev,
-                                       __unregister);
+       dummy = device_for_each_child(&master->dev, NULL, __unregister);

Considering that this patch is in 2.6.36 (and 36.1), you seem to have
mixed up your sources. Please make sure your checkout is current and
unbroken...

> This is on v2.6.37-rc1. Unless this got fixed somewhere else in the
> meantime it is still there.

"Mu."

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -586,7 +586,6 @@ void spi_unregister_master(struct spi_master *master)
>  
>  	dummy = device_for_each_child(master->dev.parent, &master->dev,
>  					__unregister);
> -	device_unregister(&master->dev);
>  }

This patch does, consequently, not apply on 2.6.37-rc, since the code
doesn't look like that anymore after 3486008...


-David


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
