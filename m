From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 08/12] spi/mxs: Fix race in setup method
Date: Tue, 2 Apr 2013 23:08:40 -0700
Message-ID: <CA+7tXih2r6YFE80y7z7Nj7c0Ytvh+v56-SrbS+VQ7kCW3KBRXA@mail.gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
	<201304030131.37782.marex@denx.de>
	<CA+7tXigasUbSRD6hQH66m6XsDkzS9ubLSB24f4akB3pv9xrT=A@mail.gmail.com>
	<201304030427.41297.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201304030427.41297.marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Apr 2, 2013 7:27 PM, "Marek Vasut" <marex-ynQEQJNshbs@public.gmane.org> wrote:
>
> > The only useful thing mxs_spi_setup_transfer() (which
> > is no longer called) did in this instance was make that check.
> >
> > > btw. I was under the impression the MXS SSP block can handle other
> > > word-widths than 8 bit, no ?
> >
> > In theory it can,
>
> In practice too ;-)
>
> > however the driver only supports 8-bits and will
> > reject anything else.
>
> Then please at least add a comment about this.

What does that have to do with this patch?  There was no comment about
it before.  You're insisting that changes be broken up to the extent
that changing one line of code takes multiple patches!  Now you want a
comment about existing driver behavior added to patch that doesn't
change that behavior?

Documenting the driver behavior would seem to be a job for the driver
maintainer.  If doing this is something I need to do, then maybe I
should maintain it?

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
