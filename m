From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: add support for DLN-2 USB-SPI adapter
Date: Mon, 17 Nov 2014 14:30:39 +0200
Message-ID: <20141117123039.GB2583@lpalcu-linux>
References: <1415799490-27989-1-git-send-email-laurentiu.palcu@intel.com>
 <1415799490-27989-2-git-send-email-laurentiu.palcu@intel.com>
 <20141113122728.GA18285@localhost>
 <20141113151721.GQ5826@lpalcu-linux>
 <20141114105645.GB18285@localhost>
 <20141117103300.GA2583@lpalcu-linux>
 <20141117115316.GA19375@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141117115316.GA19375@localhost>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Nov 17, 2014 at 12:53:16PM +0100, Johan Hovold wrote:
> On Mon, Nov 17, 2014 at 12:33:01PM +0200, Laurentiu Palcu wrote:
> > Hi Johan,
> > 
> > On Fri, Nov 14, 2014 at 11:56:45AM +0100, Johan Havold wrote:
> > > On Thu, Nov 13, 2014 at 05:17:21PM +0200, Laurentiu Palcu wrote:
> > > > Hi Johan,
> > > > 
> > > > On Thu, Nov 13, 2014 at 01:27:28PM +0100, Johan Havold wrote:
> > > > > On Wed, Nov 12, 2014 at 03:38:09PM +0200, Laurentiu Palcu wrote:
> 
> > > And since there's no gain from using the global buffer why not simply
> > > use stack allocated ones here as well (e.g. for both tx and rx above)?
> >
> > However, I will give this a shot though... Sounds reasonable and I could
> > probably lose the struct constructs too if the struct contains just
> > one field.
> 
> You might want to keep the structs for single-field messages for
> consistency reasons (also used in the other dln2 subdrivers).
Ok, fair enough.

laurentiu
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
