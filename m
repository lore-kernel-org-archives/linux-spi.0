From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Fix the build warning with
 CONFIG_ARM_LPAE=y
Date: Wed, 13 Nov 2013 13:34:42 -0800
Message-ID: <20131113213442.GA3294@quad.lixom.net>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
 <20131001104840.GL19304@sirena.org.uk>
 <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
 <20131113132952.GK878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131113132952.GK878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Nov 13, 2013 at 01:29:52PM +0000, Mark Brown wrote:
> On Tue, Nov 12, 2013 at 10:38:13PM -0800, Olof Johansson wrote:
> > On Tue, Oct 1, 2013 at 3:48 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> > > Applied, thanks.
> 
> > These warnings are showing up (again?), so wherever it was applied is
> > not making it into -next. Did it fall between the cracks?
> 
> Looks lie it never got pushed and nobody looked at the warnings for over
> a month.  Oh well, sorry about that.

No worries.

I've been eyeing the warnings but not doing anything about it. Didn't
notice that there was a patch until I started looking for existing
patches to take care of it (and post patches where needed).


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
