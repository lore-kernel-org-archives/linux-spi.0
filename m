From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2/2] mmc-spi update
Date: Sun, 3 Jun 2007 19:14:40 -0700
Message-ID: <200706031914.40360.david-b@pacbell.net>
References: <464350D0.5060102@gmail.com>
	<200705102257.26301.david-b@pacbell.net> <46441785.40300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org
To: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46441785.40300-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Friday 11 May 2007, Jan Nikitenko wrote:
> David Brownell wrote:
> 
> > Just for the record, my plan is to post updates against 2.6.22-rc1
> > (with the MMC stack reorg, new CRC, etc) and then start splitting
> > this up into more mergeable chunks once it all works again on some
> > hardware I have in hand.

Revised plan:  it'll probably be against RC4, and that will include
some of how I think that code splitting should work.


> > It sure seems like this _ought_ to be nearly mergeable by now, at
> > least in terms of the "it works" metric.  In terms of factoring
> 
> so now it works also with your hw?

I had to change f_min from 125 KHz to 400 KHz, since the minimum
that my hardware supports is 138 KHz.  At least without some nasty
updates to the controller driver, forcing it in and out of a global
divide-by-32 mode based on what device it's talking to.  :(

Turns out the main reason for enumerating with a low frequency is
because MMC (or SD) cards would start in BUSMODE_OPENDRAIN, which
has speed limits not unlike I2C.  But since SPI doesn't use that
mode, there seems to be no need to be that low.  The only solid
constraint I could find is that lowspeed SDIO cards may not work
with speeds over 400 KHz.

- Dave

 
> Jan
> 
> > the code, it's too monolithic ... but I think that probably helped
> > get us this far, since circulating a bunch of mmc core patches
> > along with a driver-in-development would have been painful.
> > 
> > - Dave
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
