From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spidev: Add DT binding example.
Date: Mon, 4 May 2015 14:17:39 +0100
Message-ID: <20150504131739.GW15510@sirena.org.uk>
References: <20150429174059.GQ22845@sirena.org.uk>
 <CAOMqctQmpYmD0J9=o6FVjJhXBc8b+oGd7cNh5aH_fmgE3vk5+A@mail.gmail.com>
 <20150429180659.GT22845@sirena.org.uk>
 <CAOMqctSMeWvG6YsCFn5=wxS2nCBbMiiCKUNJh8oFsH1VZY4H-w@mail.gmail.com>
 <20150430195829.GG22845@sirena.org.uk>
 <A92B1688-9A12-4462-BA02-AEEE197C0FF4@martin.sperl.org>
 <20150503095917.GQ22845@sirena.org.uk>
 <A1FB2CDB-6735-46B2-BB74-80F1B2033E23@martin.sperl.org>
 <20150504101207.GR22845@sirena.org.uk>
 <CAOMqctQq=CLsXf-RCrtJq5H9skdO1y4mV9iM2pOk69+voMiS0g@mail.gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L0mHLbha4YKvhGtu"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	"Eric D." <eric.dillmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBB7DTWVAKGQE64RBTKI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQq=CLsXf-RCrtJq5H9skdO1y4mV9iM2pOk69+voMiS0g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--L0mHLbha4YKvhGtu
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, May 04, 2015 at 12:42:03PM +0200, Michal Suchanek wrote:
> On 4 May 2015 at 12:12, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > I'm confused.  What would the point of the functionality be if not to
> > override the existing data, otherwise we'd already have bound the
> > driver?

> Presumably you can swap different versions of a driver this way.

> Many devices have two drivers in Linux (old and new) which are
> obviously both compatible.

Many?  We have a couple but if we ever have many then that would be a
bit of a disaster.
--L0mHLbha4YKvhGtu--
