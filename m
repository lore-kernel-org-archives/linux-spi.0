From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH V2 08/12] spi/mxs: Fix race in setup method
Date: Wed, 3 Apr 2013 04:27:41 +0200
Message-ID: <201304030427.41297.marex@denx.de>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
	<201304030131.37782.marex@denx.de>
	<CA+7tXigasUbSRD6hQH66m6XsDkzS9ubLSB24f4akB3pv9xrT=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA+7tXigasUbSRD6hQH66m6XsDkzS9ubLSB24f4akB3pv9xrT=A@mail.gmail.com>
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

> On Tue, Apr 2, 2013 at 4:31 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> >>  static int mxs_spi_setup(struct spi_device *dev)
> >>  {
> >> 
> >> -     int err = 0;
> >> -
> >> 
> >>       if (!dev->bits_per_word)
> >>       
> >>               dev->bits_per_word = 8;
> >>       
> >>       if (dev->mode & ~(SPI_CPOL | SPI_CPHA))
> >>       
> >>               return -EINVAL;
> >> 
> >> -     err = mxs_spi_setup_transfer(dev, NULL);
> >> -     if (err) {
> >> -             dev_err(&dev->dev,
> >> -                     "Failed to setup transfer, error = %d\n", err);
> >> -     }
> >> +     if (dev->bits_per_word != 8)
> >> +             return -EINVAL;
> > 
> > What's this new addition doing here?
> 
> It's not new.

It is new in the context of this patch and it's not described in the commit 
message.

> The only useful thing mxs_spi_setup_transfer() (which
> is no longer called) did in this instance was make that check.
> 
> > btw. I was under the impression the MXS SSP block can handle other
> > word-widths than 8 bit, no ?
> 
> In theory it can,

In practice too ;-)

> however the driver only supports 8-bits and will
> reject anything else.

Then please at least add a comment about this.

Best regards,
Marek Vasut

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
