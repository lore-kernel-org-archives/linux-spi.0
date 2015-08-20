From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/9] spi: sunxi: fix transfer timeout
Date: Thu, 20 Aug 2015 14:08:30 -0700
Message-ID: <20150820210830.GS12027@sirena.org.uk>
References: <cover.1440080122.git.hramrach@gmail.com>
 <0e0b52774a48ddb71dc8095b66942451cd31ff7d.1440080122.git.hramrach@gmail.com>
 <20150820184132.GO12027@sirena.org.uk>
 <20150820193433.GH30520@lukather>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tgGnixv3tJWXBxdL"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBZUD3GXAKGQEQYTYXBQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150820193433.GH30520@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--tgGnixv3tJWXBxdL
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Aug 20, 2015 at 09:34:33PM +0200, Maxime Ripard wrote:
> On Thu, Aug 20, 2015 at 11:41:32AM -0700, Mark Brown wrote:
> > On Thu, Aug 20, 2015 at 02:19:45PM -0000, Michal Suchanek wrote:

> > >  drivers/spi/spi-sun4i.c | 10 +++++++++-
> > >  drivers/spi/spi-sun6i.c | 10 +++++++++-

> > Are we *sure* we can't work on merging these drivers :(

> Those are two different IPs, that don't really share anything but
> their author...

I seem to be seeing a number of changes like this one which make
apparently very similar modifications to both.  Perhaps there is more
core usage that should be happening instead?
--tgGnixv3tJWXBxdL--
