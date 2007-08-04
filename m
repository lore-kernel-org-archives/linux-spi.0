From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 4/4] mmc_spi host driver
Date: Sat, 4 Aug 2007 10:32:09 -0700
Message-ID: <200708041032.10001.david-b@pacbell.net>
References: <200707141504.51950.david-b@pacbell.net>
	<200708021334.50670.david-b@pacbell.net>
	<20070804151452.0efaa5a9@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070804151452.0efaa5a9-mgABNEgzgxm+PRNnhPf8W5YgPPQkE1Si@public.gmane.org>
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

On Saturday 04 August 2007, Pierre Ossman wrote:
> On Thu, 2 Aug 2007 13:34:49 -0700
> David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > The intended design of an MMC/SD host driver has never
> > been all that clear.  It's becoming more clear with your
> > recent work ... but it's not there yet, and there aren't
> > even test scripts or suites for de-facto requirements
> > (and to facilitate regression testing).
> 
> I agree. There are still a bunch of corner cases that are fuzzy at
> best. Unfortunately, all difficult cases usually involve error
> conditions. So I haven't been able to come up with a way to test things
> without having a custom card that can fail requests in different exotic
> ways.

There's always writing negative tests ... i.e. issue requests
that will fail, and make sure they fail "correctly".  One of
those might be an alternative to the current block driver.

One expects that code developed outside any test framework
will have fair coverage for success paths (e.g. whatever is
needed to make MMC and SD memory cards work), and the most
common fault paths (e.g. what's triggered during enumeration).
But beyond that ... passing illegal params, reading past end
of card, "unusual" write sizes, and other things are unlikely
to behave consistently between drivers.


> > Patches #1 and #2 were easy fixes; about 2/3 of #3 is rejected,
> > and I've not yet looked at the details ... that's all the core
> > changes, which haven't previously cared about much more than
> > success-or-fault.  #4 should be easy to cope with.
> 
> It should just be a matter of replacing MMC_ERR_ codes with -Esomething.

Or MMC_ERR_NONE with zero.  Almost ... thing is, the new SDIO stuff
seems to bork things in some cases, more with SD cards than MMC.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
