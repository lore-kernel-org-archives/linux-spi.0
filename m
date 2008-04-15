From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: mmc_spi.c driver
Date: Tue, 15 Apr 2008 12:04:19 -0700
Message-ID: <200804151204.19776.david-b@pacbell.net>
References: <1CF6EDDF0820924DA43C9A52FE7325950A27D544@MI8NYCMAIL17.Mi8.com>
	<200804151137.00997.david-b@pacbell.net>
	<1CF6EDDF0820924DA43C9A52FE7325950A89D882@MI8NYCMAIL17.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
To: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1CF6EDDF0820924DA43C9A52FE7325950A89D882-3jZfQB9DylyX6QUl2nWcdlaTQe2KTcn/@public.gmane.org>
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

On Tuesday 15 April 2008, hartleys wrote:
> I do get the IRQ on every card insertion and removal. Actually if I boot
> the system with the card removed I end up getting a:
> =

> mmc0: error -22 whilst initialising SDIO card

That's correct, except for the obvious lie about SDIO.  ;)


> If I then insert the card I get the IRQ and:
> =

> mmc0: new MMC card on SPI
> mmcblk0: mmc0:0001 SDM064 62720KiB
> =A0mmcblk0: p1 p2 p3 p4
> =

> So it appears the initial card detect does work. But for some reason
> it's not seeing the removal of the card or the insertion of a new card.
> =

> Any ideas?

No; that used to work OK.  I wonder if there have been
changes in the MMC framework which caused this trouble;
I've seen some oddness there too, the last few times I
have tried to use those card detect code paths.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
