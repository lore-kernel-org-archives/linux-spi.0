From: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 11/11] dt: Exynos: add Snow SPI NOR node.
Date: Wed, 17 Jun 2015 14:19:20 +0200
Message-ID: <20150617121920.GB20728@amd>
References: <cover.1433364398.git.hramrach@gmail.com>
 <3234c12c90eabbeeb6d33604a324231937e309ec.1433364398.git.hramrach@gmail.com>
 <556FB222.2070406@samsung.com>
 <201506041720.54666.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Alison Chaiken <alison_chaiken-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>,
	Knut Wohlrab <knut.wohlrab-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	Bean Huo =?utf-8?B?6ZyN5paM5paMIChiZWFuaHVvKQ==?=
	<b
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201506041720.54666.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu 2015-06-04 17:20:54, Marek Vasut wrote:
> On Thursday, June 04, 2015 at 04:04:18 AM, Krzysztof Kozlowski wrote:
> > On 04.06.2015 06:26, Michal Suchanek wrote:
> > > The Snow has onboard SPI NOR flash which contains the bootloader.
> > > 
> > > Add DT node for this flash chip. The flash is rated 133MHz but the pl330
> > > controller can transfer only up to 128 bytes at this speed so use more
> > > conservative settings. Even at 40MHz pl330 can transfer at most 64k with
> > > the current driver.
> > > 
> > > Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > ---
> > > 
> > >  arch/arm/boot/dts/exynos5250-snow.dts | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/exynos5250-snow.dts
> > > b/arch/arm/boot/dts/exynos5250-snow.dts index 1fa72cf..38e4cda 100644
> > > --- a/arch/arm/boot/dts/exynos5250-snow.dts
> > > +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> > > @@ -691,6 +691,18 @@
> > > 
> > >  	num-cs = <1>;
> > >  	cs-gpios = <&gpa2 5 0>;
> > >  	status = "okay";
> > > 
> > > +		flash: m25p80@0 {
> > 
> > The indentation looks odd. This should be at the same level as "status".
> > 
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			compatible = "jedec,spi-nor";
> > > +			reg = <0>;
> > > +			spi-max-frequency = <40000000>;
> > 
> > So actually you wanted 133 MHz but as a workaround for DMA issue you use
> > 40 MHz, right? Could you add here a small TODO note in comment about it?
> 
> I disagree. There is a problem, the problem should actually be analyzed and 
> fixed, not just postponed with some TODO nonsense.

Of course, that would be preferable if submitter has time. But OTOH
slow SPI is probably better than no SPI at all, and debugging this can
be nasty. I think that TODO is suitable.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
