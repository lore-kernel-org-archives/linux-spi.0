From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 4/4] MMC-over-SPI host driver
Date: Fri, 22 Jun 2007 14:18:43 -0700
Message-ID: <200706221418.44214.david-b@pacbell.net>
References: <200706101257.45278.david-b@pacbell.net>
	<20070620170511.EC564F31CB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<4679691C.2060803@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org, mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org
To: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4679691C.2060803-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
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

On Wednesday 20 June 2007, Pierre Ossman wrote:
> David Brownell wrote:
> >>> Right now it looks like the main reason to keep including mmc.h is
> >>> to handle one aspect of mapping the data error token. ...
> >> Don't map at all. Just give the core what you got from the card.
> > 
> > Tried that, it fails for the obvious (in retrospect) reason:  after each
> > command that's issued, something needs to ensure that the return code won't
> > be MMC_ERR_NONE after errors.  That means looking at those R1 bits which
> > report that hardware status.
> 
> The error codes were never supposed to report card status, only controller
> status. So MMC_ERR_NONE is perfectly valid for a status response filled with
> error bits.

If so, then the MMC core is full of bugs, needing fixes
that are *FAR* beyond scope of my patches.

Essentially every error check compares against MMC_ERR_NONE.

This distinction you're making between "controller" and
"card" seems unnatural -- and counterproductive -- in
this context.  What the core code expects to see is fault
reports.  It doesn't actually understand layering to any
relevant degree; all it cares about is whether the operation
it requested has succeeded or not.


> > And it's got to do that pretty much immediately, since when an error shows
> > up in the command, the data stage must not be performed.  It's impractical
> > to consider delegating such triage to the core.
> > 
> 
> This is an architectural limitation in the MMC layer that affects the native
> protocol aswell. If you need it fixed, I'd say we have to do it in a proper,
> general manner.

So, I wait for patches from you which fix all those issues?


> Why can't you do what native controllers do, just fling the data out there and
> break when the card doesn't respond properly to it?

Because that would be a remarkably ... naive? ... way to
implement *any* protocol stack.  If I were grading college
students again, any such implementation would be seriously
downgraded.  It's a virtual certainty that throwing garbage
commands (like that "data") will make things break.  At
best, it enters a recoverable fault mode, only wasting the
time used to recover from having thrown known-to-be garbage
bytes at the card.  At worst ... devices become unrecoverable
with weaker provocations than that.

I sure hope you have heard that old chestnut, "Be liberal
in what you accept, and conservative in what you send."

That's an ancient principle for robust interoperation.  The
first RFC describing it was RFC 760, but the principle
predates that 1980 document by at least a few years.  The
way to apply that principle here is obvious:  don't throw
known garbage commands at a card.


> >>> Having a simple flag in mmc_host would be much better.
> >> Perhaps. But there's a lot of value in consistency.
> > 
> > Unless you strongly object, I'll go the flag route though.  The thing is,
> > the IOS thing ("kitchen sink") will never vanish if it keeps growning at
> > every opportunity.
> > 
> 
> But if we keep inventing new systems ad-hoc, we'll have a much bigger mess to
> deal with.

State flags predate the notion of this "ios" thingie;
they're far from being an "ad-hoc" notion.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
