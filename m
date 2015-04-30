From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Thu, 30 Apr 2015 20:58:29 +0100
Message-ID: <20150430195829.GG22845@sirena.org.uk>
References: <cd282abf-898a-4f01-90a6-8bf2db160b8e@googlegroups.com>
 <CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg@mail.gmail.com>
 <20150428141630.GR22845@sirena.org.uk>
 <CAOMqctTNSgycy7K=ZMK9aaZGyybDT61e0Y6Fwf1jtoMbSVoNQQ@mail.gmail.com>
 <20150428171738.GY22845@sirena.org.uk>
 <CAOMqctSEAd-WeBRLabvDugN04XaqY6Y1UyO9UPLaTW9ce7t_rQ@mail.gmail.com>
 <20150429174059.GQ22845@sirena.org.uk>
 <CAOMqctQmpYmD0J9=o6FVjJhXBc8b+oGd7cNh5aH_fmgE3vk5+A@mail.gmail.com>
 <20150429180659.GT22845@sirena.org.uk>
 <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w@mail.gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="suYuRLWiGRtbsVTA"
Cc: "Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBB4ESRKVAKGQEW4P2HWQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--suYuRLWiGRtbsVTA
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Apr 29, 2015 at 08:37:24PM +0200, Michal Suchanek wrote:
> On 29 April 2015 at 20:06, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I think the rest of the thread had that covered - there's both adding
> > the device IDs and Maxime's patch.

> And adding device IDs is unacceptable for users of devboards while
> Maxime's patch is not accepted into the kernel.

> I am using a version of Maxime's patch myself right now. It does not
> seem it's going to be include in the kernel any time soon, however.

A big reason for that is that it's not in my inbox for me to review,
these messages I flagged as unhelpful aren't going to help with that if
only because I don't want to create the impression that such behaviour
achieves results.

> FWIW I added the ability to open any CS, even those claimed by kernel
> drivers. This addresses any potential race of spidev binding before
> the actual driver but has the potential to introduce some subtle bugs
> when you open and reconfigure a CS used by a kernel driver or send
> some commands that upset the device.

This doesn't seem like an obviously good idea - having userspace be able
to interact with a device without a running kernel driver knowing about
it doesn't seem like something that will end well.
--suYuRLWiGRtbsVTA--
