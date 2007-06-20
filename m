From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 4/4] MMC-over-SPI host driver
Date: Wed, 20 Jun 2007 19:51:24 +0200
Message-ID: <4679691C.2060803@drzeus.cx>
References: <200706101257.45278.david-b@pacbell.net>
	<200706132105.51711.david-b@pacbell.net>
	<4672D9C5.9080707@drzeus.cx>
	<200706171329.12709.david-b@pacbell.net>
	<467953E0.8050408@drzeus.cx>
	<20070620170511.EC564F31CB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org, mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070620170511.EC564F31CB-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
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

David Brownell wrote:
>>> Right now it looks like the main reason to keep including mmc.h is
>>> to handle one aspect of mapping the data error token. ...
>> Don't map at all. Just give the core what you got from the card.
> 
> Tried that, it fails for the obvious (in retrospect) reason:  after each
> command that's issued, something needs to ensure that the return code won't
> be MMC_ERR_NONE after errors.  That means looking at those R1 bits which
> report that hardware status.

The error codes were never supposed to report card status, only controller
status. So MMC_ERR_NONE is perfectly valid for a status response filled with
error bits.

> And it's got to do that pretty much immediately, since when an error shows
> up in the command, the data stage must not be performed.  It's impractical
> to consider delegating such triage to the core.
> 

This is an architectural limitation in the MMC layer that affects the native
protocol aswell. If you need it fixed, I'd say we have to do it in a proper,
general manner.

Why can't you do what native controllers do, just fling the data out there and
break when the card doesn't respond properly to it?

>>> Having a simple flag in mmc_host would be much better.
>> Perhaps. But there's a lot of value in consistency.
> 
> Unless you strongly object, I'll go the flag route though.  The thing is,
> the IOS thing ("kitchen sink") will never vanish if it keeps growning at
> every opportunity.
> 

But if we keep inventing new systems ad-hoc, we'll have a much bigger mess to
deal with.

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
