From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: spi_set_drvdata() handling in spidev_probe()
Date: Thu, 10 Dec 2009 18:25:21 -0800
Message-ID: <200912101825.21244.david-b@pacbell.net>
References: <8bd0f97a0910122332y321138ak8294e5f152064344@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a0910122332y321138ak8294e5f152064344-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Monday 12 October 2009, Mike Frysinger wrote:
> i was browsing the change history of spidev when i noticed the change:
> aaacf4bb51b243875b203e6ff73b5047636b4efa spi: avoid spidev crash when
> device is removed
> 
> which seems to be due to this change:
> 3d81252ddb10f63ae4db713d9b32faabe641b850 device create: spi: convert
> device_create to device_create_drvdata
> 
> getting an incomplete revert with this change:
> a9b12619f7b6f19c871437ec24a088787a04b1de device create: misc: convert
> device_create_drvdata to device_create

More accurately:  not a revert, but a name change.


> my point being is that the original code was doing the
> spi_set_drvdata() while holding the device_list_lock mutex while the
> new one is not.  shouldnt the code be changed back to the state
> previous to 3d81252d ?

Yes, that particular assignment should be mutex-protected.

The original patch shouldn't really have removed it; the
change to the device_create() signature was addressing a
slightly different race.

- Dave


> -mike
> 
> 



------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
