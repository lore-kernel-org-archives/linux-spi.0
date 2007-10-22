From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
Subject: Re: [RFC,
	PATCH] SPI: fix return value for spi_read and spi_write
Date: Mon, 22 Oct 2007 08:40:26 +0200
Message-ID: <200710220840.26829.marc.pignat@hevs.ch>
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

Hi!

On Friday 19 October 2007, David Brownell wrote:
> > From: Marc Pignat <marc.pignat-7TsPiqsLilE@public.gmane.org>
...
> Seems right to me.  This aspect of the spi_sync() calling
> convention can be annoying and error-prone.  I've sometimes
> thought about changing that instead of auditing all callers.
> 
> Are there any comments from others on this list?  Which
> approach would be preferred:  fixing callers (this is at
> least a partial fix for that) or updating spi_sync() so
> that callers don't need to check m->status?
> 
> - Dave

The API will be simpler with an updated spi_sync().

Regards

Marc

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
