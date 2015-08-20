From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/9] spi: sunxi: check that transfer speed
 is non-zero
Date: Thu, 20 Aug 2015 23:23:36 +0200
Message-ID: <20150820212336.GJ30520@lukather>
References: <cover.1440080122.git.hramrach@gmail.com>
 <3688fab67e7cdc7bcbff73dfd6b0fcdcc4e79eb6.1440080122.git.hramrach@gmail.com>
 <20150820144836.GV30520@lukather>
 <CAOMqctSfdxWeWDogzHxONE+Qxf7vp6rJnBmxECV89PQO0hXARg@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jcZk2Ix8j3PVOBnV"
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBWMK3GXAKGQEFRYRL6A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctSfdxWeWDogzHxONE+Qxf7vp6rJnBmxECV89PQO0hXARg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--jcZk2Ix8j3PVOBnV
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Aug 20, 2015 at 09:45:07PM +0200, Michal Suchanek wrote:
> On 20 August 2015 at 16:48, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Thu, Aug 20, 2015 at 02:19:46PM -0000, Michal Suchanek wrote:
> >> When the maximum transfer speed is not set for a SPI slave the value
> >> remains 0 and the code in sunxi SPI divides by it. Use an arbitrary
> >> speed instead in that case.
> >>
> >> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > spi->max_speed_hz is set using the spi-max-frequency property, and
> > spi->will error out if that property isn't set. What am I missing?
> >
> 
> Spidev I guess.
> 
> You can set the speed to arbitrary value from userspace at any time
> using the spidev ioctls.

Then why should it be fixed at the controller driver level? It looks
more like an issue that impacts everyone and should be fixed either in
spidev directly or in the framework.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--jcZk2Ix8j3PVOBnV--
