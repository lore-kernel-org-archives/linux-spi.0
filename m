From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 4/4] mmc_spi host driver
Date: Sat, 4 Aug 2007 15:14:52 +0200
Message-ID: <20070804151452.0efaa5a9@poseidon.drzeus.cx>
References: <200707141504.51950.david-b@pacbell.net>
	<200708011117.24664.david-b@pacbell.net>
	<20070802150615.36e073c6@poseidon.drzeus.cx>
	<200708021334.50670.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708021334.50670.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Thu, 2 Aug 2007 13:34:49 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> > Except for omap, 
> > which caused it to break in fun and interesting ways.
> 
> I think the only time I touched that code was to teach it
> how to do SD ... 4wire support, writeprotect sensing, and
> funky block sizes.
> 
> The intended design of an MMC/SD host driver has never
> been all that clear.  It's becoming more clear with your
> recent work ... but it's not there yet, and there aren't
> even test scripts or suites for de-facto requirements
> (and to facilitate regression testing).
> 

I agree. There are still a bunch of corner cases that are fuzzy at
best. Unfortunately, all difficult cases usually involve error
conditions. So I haven't been able to come up with a way to test things
without having a custom card that can fail requests in different exotic
ways.

> 
> Fault handling being orthogonal to that.  And at this time,
> like it or (clearly!) not, the mmc core does virtually no
> fault checking ... it relies on reports from host drivers.
> 
> You're probably on to something with the notion that the
> I/O wrappers should check the status codes.  But that's
> a substantial change from how the stack has worked, ever
> since it was written.
> 

Indeed. The core lacks proper error checking on that level because
those errors are so extremely rare. People are lazy and "good enough"
goes a long way. I'd love to see better error handling, but with these
low odds, other things get prioritized.

> > 
> > I don't see how it would have been easier. The only difference is
> > that I'd get a merge problem when I applied the new stuff. So the
> > difference is really whose lap it would have fallen in.
> 
> Not exactly ... you'd have been developing that new stuff against
> current GIT, which would already have had some of those patches,
> so there wouldn't even *be* a merge problem for that stuff.
> 

I'm afraid my development is far from serial. All code that needs
further testing gets its own branch, as there is still some uncertainty
as to when it will be pushed upstream.

> 
> Patches #1 and #2 were easy fixes; about 2/3 of #3 is rejected,
> and I've not yet looked at the details ... that's all the core
> changes, which haven't previously cared about much more than
> success-or-fault.  #4 should be easy to cope with.
> 

It should just be a matter of replacing MMC_ERR_ codes with -Esomething.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
