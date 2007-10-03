From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Revisiting "problem with converting from
 at91_spi to atmel_spi (AT91RM9200)"
Date: Wed, 03 Oct 2007 09:33:58 -0700
Message-ID: <20071003163358.6C79A235028@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <37ED64EE21A398409D609EAF7B0525A02164EB@hw-mail.hannover.huwag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, LTI-mKfYHFOTJHu+onKQ3Rj6Dg@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37ED64EE21A398409D609EAF7B0525A02164EB-4fFKm6SzF271qYPpFx2fzhn/E98GtLqgrE5yTffgRl4@public.gmane.org>
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

> I was wondering if the problem described in the thread "problem with
> converting from at91_spi to atmel_spi (AT91RM9200)" from last May
> was ever solved, as I'm currently running into the same trouble.
> at91_spi works nicely with an at25-driven EEPROM on CS0, but atmel_spi
> doesn't - it just blocks whatever thread is using it.

Andrew Victor had partial success after updating the platform setup
code appropriately.  I don't know what the status of that patch is.


> While that's no problem in the EEPROM case, a customer wants to use
> SPI basically as a very fast UART between two AT91RM9200 based boards
> now, on which only CS0 is available. Is there no other chance than
> converting the layout to use another CS instead?

Unfortunately CS0 on rm9200 seems especially full of trouble; from
what I've seen and heard, using another chipselect would be good
just on the basis of the number of CS0-specific errata.

Of course, if you just want UART-ish behavior, you might also be
able to use one of the SSC channels.  The SPI stack aims to handle
master/slave style communication, not peer-to-peer.  When you're
modeling a bidirectional byte stream, that's the wrong model. 
Plus, you'd have fewer chip errata to cope with.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
