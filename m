From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 1/2] spi: add support for DLN-2 USB-SPI adapter
Date: Fri, 28 Nov 2014 20:13:26 +0200
Message-ID: <20141128181326.GA23784@lpalcu-laptop>
References: <1416312599-5176-2-git-send-email-laurentiu.palcu@intel.com>
 <1417180198-9393-1-git-send-email-laurentiu.palcu@intel.com>
 <20141128141053.GL7712@sirena.org.uk>
 <20141128145703.GA16201@lpalcu-linux>
 <20141128151435.GQ7712@sirena.org.uk>
 <20141128153125.GB16201@lpalcu-linux>
 <20141128160156.GX7712@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Johan Havold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141128160156.GX7712-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Nov 28, 2014 at 04:01:56PM +0000, Mark Brown wrote:
> On Fri, Nov 28, 2014 at 05:31:25PM +0200, Laurentiu Palcu wrote:
> > On Fri, Nov 28, 2014 at 03:14:35PM +0000, Mark Brown wrote:
> > > On Fri, Nov 28, 2014 at 04:57:04PM +0200, Laurentiu Palcu wrote:
> 
> > > > The other patch in this series was already applied by Lee on
> > > > for-mfd-next branch:
> 
> > > What this means is that the series you're sending actually contains one
> > > patch, not two.  The point of numbering patches within a series is so
> > > people can tell what order to apply them in, nothing else.  Things can
> > > be lumped together and split during the upstreaming process, the only
> > > thing that matterrs is what you're sending at a given time.
> 
> > The order of the patches in this series can be interchanged. However, if
> > you wish, I can resend the entire series again.
> 
> No, please don't - you're missing the point.  The point is that now Lee
> has applied the other patch you're not sending two patches any more,
> you're sending a single patch.  This isn't patch 1/2, it's just a single
> patch by itself now.
I have to admit Linux kernel mailing list workflow is a little new to
me...

All I did was send new revisions of the 1/2 patch using the
--in-reply-to option of git-send-email, with the message-id of the
original version. I used to do this for other projects I contributed to,
so I didn't have to re-send the entire series for just one patch that
needs to be changed. Mail clients, at least the ones I use (mutt,
evolution), order the mails nicely and you have all the history in one
thread. So, one can see the cover letter of the series and the other
original patches in the series, together with the new revisions of the
changed patch. Of course, if more patches needed change, I would re-send a new
series.

So, Mark, can you please instruct me (a link to a page explaining the
workflow would be fine too) what is the exact workflow you are/were
expecting?

thanks in advance,
laurentiu

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
