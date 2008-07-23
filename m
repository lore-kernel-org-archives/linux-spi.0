From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] at25: call spi_setup before
	read/write access
Date: Wed, 23 Jul 2008 12:11:19 -0700
Message-ID: <200807231211.19974.david-b@pacbell.net>
References: <BD79186B4FD85F4B8E60E381CAEE190948112F@mi8nycmail19.Mi8.com>
	<200807231137.29170.david-b@pacbell.net>
	<BD79186B4FD85F4B8E60E381CAEE1909481160@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "hartleys" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909481160-KURmP/Qoe8Pmp66j18f85VaTQe2KTcn/@public.gmane.org>
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
> On Wednesday, July 23, 2008 David Brownell wrote:
> >> This patch makes the at25 driver call spi_setup before any read/write
> 
> >> access to the eeprom to insure that the device mode and clock is set 
> >> correctly.
> >
> > Why would this be needed though?  It was called before probe(), and
> > nothing changed the setup ... so it should still be valid.
> 
> With multiple slaves another driver could change the clock.

No it can't.  If you're seeing that behavior, it's a bug in your
SPI controller driver ... it's not properly keeping track of
the device settings.  The spi_setup() call only changes records
of settings for that device; those settings become active the
next time I/O is performed to that device.  The controllers often
have per-chipselect registers with settings for speed, mode, word
size, and so forth.  If they don't have such registers, they need
to emulate having them.

Also, note that your patch wouldn't actually work around that
controller driver bug.  A driver for a different SPI device
could issue requests between the spi_setup() you added and
the I/O calls ...

- Dave


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
