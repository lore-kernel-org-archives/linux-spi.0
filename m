From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2 08/12] spi/mxs: Fix race in setup method
Date: Wed, 3 Apr 2013 08:50:31 +0200
Message-ID: <201304030850.31752.marex@denx.de>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
	<201304030427.41297.marex@denx.de>
	<CA+7tXih2r6YFE80y7z7Nj7c0Ytvh+v56-SrbS+VQ7kCW3KBRXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA+7tXih2r6YFE80y7z7Nj7c0Ytvh+v56-SrbS+VQ7kCW3KBRXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Dear Trent Piepho,

> On Apr 2, 2013 7:27 PM, "Marek Vasut" <marex-ynQEQJNshbs@public.gmane.org> wrote:
> > > The only useful thing mxs_spi_setup_transfer() (which
> > > is no longer called) did in this instance was make that check.
> > > 
> > > > btw. I was under the impression the MXS SSP block can handle other
> > > > word-widths than 8 bit, no ?
> > > 
> > > In theory it can,
> > 
> > In practice too ;-)
> > 
> > > however the driver only supports 8-bits and will
> > > reject anything else.
> > 
> > Then please at least add a comment about this.
> 
> What does that have to do with this patch?

You're adding a piece of code. This change is
a) not documented in the commit message
b) unrelated to this fix, seems to be more fitting in 10/12 or something -- 
maybe even shuffling the patches a bit might help

So add a comment to make this clearer for people who hack on this after you.

> There was no comment about
> it before.  You're insisting that changes be broken up to the extent
> that changing one line of code takes multiple patches!  Now you want a
> comment about existing driver behavior added to patch that doesn't
> change that behavior?
> 
> Documenting the driver behavior would seem to be a job for the driver
> maintainer.  If doing this is something I need to do, then maybe I
> should maintain it?

You ain't rubbing people the right way at all, I tell you. This pushy/offensive 
behavior helps noone, calm down please. It is usually a good idea to sleep on 
your reply or take your time.

Ad maintainership -- there's no maintainer of the driver, there's only Fabio, 
Shawn, me and the SPI subsystem guys. And it works well. It's everybodys' code 
and everyone's welcome to contribute. What's the problem? 

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
