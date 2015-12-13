From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2] spi: dts: sun4i: Add support for
 inter-word wait cycles using the SPI Wait Clock Register
Date: Sun, 13 Dec 2015 22:07:19 +0100
Message-ID: <20151213210719.GC19456@lukather>
References: <1449873940-10167-1-git-send-email-mweseloh42@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBCF4W6ZQKGQEUXFOV6A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449873940-10167-1-git-send-email-mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Fri, Dec 11, 2015 at 11:45:39PM +0100, Marcus Weseloh wrote:
> Adds support and binding documentation for a new slave device property
> "sun4i,spi-word-wait-ns" that allows to set a hardware based delay
> between the transmission of words using the SPI Wait Clock Register.
> The SPI hardware needs 3 clock cycles to set up the delay, which makes
> the minimum non-zero wait time 4 clock cycles.
> 
> Signed-off-by: Marcus Weseloh <mweseloh42-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Changes from v1:
>  * renamed the property for more clarity
>  * wait time is set in nanoseconds instead of number of clock cycles
>  * transparently handle the 3 setup clock cycles
> 
> There is one review comment that I didn't address: Rob Herring suggested
> that this should be in the core-binding rather than in sun4i. I checked
> many of the hardware manuals of other SPI drivers and it looks to me like
> this hardware based inter-word delay is a feature that not many SPI
> controllers offer. And the SPI core currently has no way to control an
> inter-word delay, only inter-message. So I would like to propose this again
> as a sun4i binding, as it targets a sun4i (or sunxi?) specific hardware
> feature.

Only a few of them justify to have this in the framework. There's a
bunch of controllers that support such a feature, and it definitely
belongs in the core.

The point of the framework is not to be the least common denominator,
it's about having as much code in common as possible, and it
definitely falls into that category.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--H8ygTp4AXg6deix2--
