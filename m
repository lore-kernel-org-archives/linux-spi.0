From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Question: Can transfer speed change mid
	message
Date: Thu, 27 Aug 2009 19:26:16 -0700
Message-ID: <200908271926.16740.david-b@pacbell.net>
References: <BD79186B4FD85F4B8E60E381CAEE190901BEA097@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "H Hartley Sweeten" <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901BEA097-KURmP/Qoe8Pmp66j18f85VaTQe2KTcn/@public.gmane.org>
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

On Monday 17 August 2009, H Hartley Sweeten wrote:
> Hello David,
> 
> I'm getting ready to post a SPI master driver for the EP93xx ARM processor.
> Before I do I have a question.
> 
> My driver uses a work queue to process the struct spi_message's for the
> devices.  It pulls each message out of the queue and then process all the
> struct spi_transfer's for the message.  At the start of the message the
> appropriate clock rate, SPI mode and bits/word are setup.  Then the device
> is chip selected followed by actually sending/receiving the data for the
> transfer.

Sounds right.


> My question is, if a message is composed of multiple transfers, is it possible
> for the speed to change mid message?

Yes; spi_transfer.speed_hz can override the default
setting in spi_device.


> If it is, does this need to be handled? 

Either handle it or reject transfers which try using
that mechanism before queueing them up.

- Dave



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
