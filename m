From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 4/4] MMC-over-SPI host driver
Date: Sat, 30 Jun 2007 20:46:48 +0200
Message-ID: <20070630204648.31a5e754@poseidon.drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<20070620170511.EC564F31CB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<4679691C.2060803@drzeus.cx>
	<200706221418.44214.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org, mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706221418.44214.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

Sorry for being unresponsive to your mails. I appreciate the hard work
you're doing, but I have too many other things on my table to answer
you in a timely manner. I hope you can put up with the delays.

On Fri, 22 Jun 2007 14:18:43 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> 
> If so, then the MMC core is full of bugs, needing fixes
> that are *FAR* beyond scope of my patches.
> 
> Essentially every error check compares against MMC_ERR_NONE.
> 
> This distinction you're making between "controller" and
> "card" seems unnatural -- and counterproductive -- in
> this context.  What the core code expects to see is fault
> reports.  It doesn't actually understand layering to any
> relevant degree; all it cares about is whether the operation
> it requested has succeeded or not.
> 

Indeed. But the status bits in the responses are context dependent and
the same for all controllers. I fully agree that we pay too little
attention to them as it is. But fixing this should be done in the core,
not in each and every host driver.

> 
> > > And it's got to do that pretty much immediately, since when an
> > > error shows up in the command, the data stage must not be
> > > performed.  It's impractical to consider delegating such triage
> > > to the core.
> > > 
> > 
> > This is an architectural limitation in the MMC layer that affects
> > the native protocol aswell. If you need it fixed, I'd say we have
> > to do it in a proper, general manner.
> 
> So, I wait for patches from you which fix all those issues?
> 

This is not a problem in practice, so it is not something I will
prioritize.

The big problem fixing this is that it is very difficult,
if not impossible, to be able to apply some policy between the command
response and the data. Most hardware will simply trod along and start
shuffling data, no matter the response

> 
> Because that would be a remarkably ... naive? ... way to
> implement *any* protocol stack.  If I were grading college
> students again, any such implementation would be seriously
> downgraded.  It's a virtual certainty that throwing garbage
> commands (like that "data") will make things break.  At
> best, it enters a recoverable fault mode, only wasting the
> time used to recover from having thrown known-to-be garbage
> bytes at the card.  At worst ... devices become unrecoverable
> with weaker provocations than that.
> 

The system is crap from a theoretical point of view. But the system
differentiates between commands and data well enough for this to not be
a problem in practice. Solving this is complex and will be a no or
little gain.

> 
> State flags predate the notion of this "ios" thingie;
> they're far from being an "ad-hoc" notion.
> 

In other systems, yes. But it is inconsistent when it comes to the mmc
code.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
