From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: spi_async and heavy CPU occupation by
	ksoftirqd
Date: Thu, 9 Aug 2007 08:23:29 -0700
Message-ID: <200708090823.29708.david-b@pacbell.net>
References: <46B97D01.5000208@dave-tech.it>
	<200708080927.36737.david-b@pacbell.net>
	<46BB1F10.3030608@dave-tech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: llandre <r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46BB1F10.3030608-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
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

On Thursday 09 August 2007, llandre wrote:
> > At a first glance, I wonder if you're not spending too much time
> > in the spi_imx "pump_transfers" tasklet. =A0I have no idea how well
> > tuned that driver is...
> =

> Hmmm ... how do you suggest me to investigate around this tasklet? Do I =

> need to use the toggling pin technique

That seems to be the most precise tool you have, unless you
have access to the JTAG-style hardware tools giving access
to the on-chip instruction trace buffers found in many ARMs.


> or does the kernel provides some  =

> tools to do that? Could oprofile come to help?

Statistical profiling probably wouldn't help.  I'm not sure that
anything like gprof is working in the kernel.  Folk that I know
have done that level analysis tend to rely on hardware trace tools.


> > I'd expect that using spi_sync() wouldn't save much, but it might
> > be worth verifying that.
>
> Initially my driver used spi_sync. When I realized the huge CPU =

> occupation I modified it in order to use spi_async instead but, again, =

> nothing changed.

And that should have been a HUGE clue that the way you were calling
it wasn't a factor at all.  =


- Dave

 =




-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
