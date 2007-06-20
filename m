From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 4/4] MMC-over-SPI host driver
Date: Wed, 20 Jun 2007 10:05:11 -0700
Message-ID: <20070620170511.EC564F31CB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200706101257.45278.david-b@pacbell.net>
	<200706132105.51711.david-b@pacbell.net> <4672D9C5.9080707@drzeus.cx>
	<200706171329.12709.david-b@pacbell.net> <467953E0.8050408@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mikael.starvik-VrBV9hrLPhE@public.gmane.org,
	hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org, mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org
To: drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <467953E0.8050408-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
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

> > Right now it looks like the main reason to keep including mmc.h is
> > to handle one aspect of mapping the data error token. ...
>
> Don't map at all. Just give the core what you got from the card.

Tried that, it fails for the obvious (in retrospect) reason:  after each
command that's issued, something needs to ensure that the return code won't
be MMC_ERR_NONE after errors.  That means looking at those R1 bits which
report that hardware status.

And it's got to do that pretty much immediately, since when an error shows
up in the command, the data stage must not be performed.  It's impractical
to consider delegating such triage to the core.

The data token was a bit of a red herring, and after some re-factoring it
turned out that there's no current win to reporting those slightly more
detailed data stage errors.  (Or any obvious place to report them...)


> > You're thinking of something like this?
> > 
> >  - always do the (dirt cheap) crc7 in the command;
> >  - move the module parameter into mmc core, default spi_crc=y;
> >  - add mmc_ios.spi_crc, initialized to match the module parameter;
> >  - mmc_spi_set_crc() uses that parameter; and
> >  - mmc_spi host will use that instead of its current use_crc, to
> >    tell whether it should init or verify datablock CRC16 values.
> > 
>
> Yes. It more clearly separates mechanism (the host driver) from policy (the mmc
> core).

OK, I'll look down that route.


> > Except this doesn't seem like an ios-style thing to me... that's
> > on top of me disliking that confusing and error-prone "check N
> > parameters to see which ones should change this time" API style.
>
> I'm no fan of this ios thing either, but it's what we've got and it hasn't been
> worth the effort to rewrite it yet.
>
> > Having a simple flag in mmc_host would be much better.
>
> Perhaps. But there's a lot of value in consistency.

Unless you strongly object, I'll go the flag route though.  The thing is,
the IOS thing ("kitchen sink") will never vanish if it keeps growning at
every opportunity.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
