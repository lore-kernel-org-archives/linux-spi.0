From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Subject: Re: [RFC,
	PATCH] SPI: fix return value for spi_read and spi_write
Date: Thu, 25 Oct 2007 12:52:06 +0200
Message-ID: <200710251252.06603.marc.pignat@hevs.ch>
References: <200710181840.38821.marc.pignat@hevs.ch>
	<20071019171619.ADB4C23BF09@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071019171619.ADB4C23BF09-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
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

Hi Dave!

On Friday 19 October 2007, David Brownell wrote:
> > From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
> > Date: Thu, 18 Oct 2007 18:40:38 +0200
> >
> > spi_read and spi_write functions don't report late errors, for
> > instance fifo underrun.
> >
> > Signed-off-by: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
> >
> > ---
> 
> Seems right to me.  This aspect of the spi_sync() calling
> convention can be annoying and error-prone.  I've sometimes
> thought about changing that instead of auditing all callers.
> 
> Are there any comments from others on this list?  Which
> approach would be preferred:  fixing callers (this is at
> least a partial fix for that) or updating spi_sync() so
> that callers don't need to check m->status?
> 

Here is a list of files using spi_sync (as in 2.6.23.1):
check only return value, does not check m->status:
drivers/mtd/devices/m25p80.c
drivers/mtd/devices/mtd_dataflash.c
drivers/spi/tle62x0.c
drivers/spi/spidev.c
drivers/spi/at25.c
include/linux/spi.h

read both return value and m->status, but does some unnecessary code when status!=0
drivers/rtc/rtc-max6902.c
drivers/spi/spi.c
drivers/input/touchscreen/ads7846.c

My conclusions: 
 * I can't find any spi_sync user wich does The Right Think(TM)
 * We should fix spi_sync (and not the callers), so forget the this patch and wait for the next one!

Regards

Marc

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
