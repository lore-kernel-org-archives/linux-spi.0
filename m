From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 4/4] MMC-over-SPI host driver
Date: Thu, 12 Jul 2007 11:14:01 -0700
Message-ID: <200707121114.02190.david-b@pacbell.net>
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

As I said earlier:  not with the current codebase, which disagrees
with your "only controller status" notion.  The original authors of
that code clearly had a "single level fault reporting" model in mind;
after all, that's pretty much standard practice everywhere.

I've worked with "multi level fault reporting" frameworks, and they
have uniformly been a pain in the posterior unless they can be used
in a "single level" mode.  Being able to drill down to lower level
details is an OK thing, although it's rarely used for anything except
debugging.  Being *forced* to do so is evil, especially when the
structure of those lower layers can be complex and nonuniform.

In this case, for example, you're assuming there *is* a "controller".
There might not be one; SPI (and for that matter the native protocol)
can just be bitbanged.  If there's hardware acceleration for various
protocol messages, that's fine but irrelevant to whether or not the
sequencing requirements of the protocol were followed.


> > And it's got to do that pretty much immediately, since when an error shows
> > up in the command, the data stage must not be performed.  It's impractical
> > to consider delegating such triage to the core.
> > 
> 
> This is an architectural limitation in the MMC layer that affects the native
> protocol aswell. If you need it fixed, I'd say we have to do it in a proper,
> general manner.

Disagree.  See above:  single layer fault reporting models are the
norm ... for very good reasons.  And even in those simpler models,
very little code ever cares about fault details when it comes to
recovery strategies.


> Why can't you do what native controllers do, just fling the data out there and
> break when the card doesn't respond properly to it?

One reason is that the "native" controllers split command and data
streams into different physical channels.  Cards can't ever mistake
data for commands ... which is a very real possibility with SPI.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
