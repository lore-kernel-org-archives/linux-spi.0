From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/5] spi: sunxi: expose maximum transfer
 size limit
Date: Wed, 1 Jun 2016 20:14:39 +0200
Message-ID: <20160601181439.GB4908@lukather>
References: <cover.1464130597.git.hramrach@gmail.com>
 <5fffb7eca6f4b70853d92be2403595d6d06bede7.1464130597.git.hramrach@gmail.com>
 <20160530083745.GG4247@lukather>
 <CAOMqctQdbipvvTnF253S4jGDos1crYXk9nuzDcRvy4geeS=GrQ@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eN+VsUY52o/CFM+1"
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBEGMXS5AKGQEUUUMV5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAOMqctQdbipvvTnF253S4jGDos1crYXk9nuzDcRvy4geeS=GrQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org


--eN+VsUY52o/CFM+1
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, May 30, 2016 at 10:57:10AM +0200, Michal Suchanek wrote:
> Hello,
> 
> On 30 May 2016 at 10:37, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > On Thu, May 26, 2016 at 07:25:24PM -0000, Michal Suchanek wrote:
> >> The sun4i spi hardware can trasfer at most 63 bytes of data without DMA
> >> support so report the limitation. Same on sun6i.
> >
> > Is it? Is there timeouts on the A31 and later SoCs?
> >
> 
> I have no sun6i hardware to test with.
> 
> This is an advisory limit you can query and it better be smaller
> rather than unreliable. The hard limit in the driver is still
> SUN6I_FIFO_DEPTH (which is 128 bytes on sun6i).
> 
> You can test his without any actual SPI device. Unused pins you can
> multiplex as SPI suffice.

Ok, for the time being:

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--eN+VsUY52o/CFM+1--
