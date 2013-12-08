From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: Re: [PATCH] spi: dt-binding: clarify gpio chipselect language
Date: Sun, 8 Dec 2013 07:37:12 +0200
Message-ID: <20131208053712.GA3869@tarshish>
References: <542dfeee809e73f7f071f4ae0b4f95af7736f70b.1386243545.git.baruch@tkos.co.il>
 <20131205164400.GI12805@ns203013.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131205164400.GI12805-HVbc7XotTAhnXn40ka+A6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jean-Christophe,

On Thu, Dec 05, 2013 at 05:44:00PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:39 Thu 05 Dec     , Baruch Siach wrote:
> > Commit 743179849015 (of_spi: add generic binding support to specify cs gpio)
> > introduced generic binding for gpio chip-select. The cs_gpio struct field,
> > however, is an internal implementation detail of the Linux SPI subsystem, and
> > should not be mentioned in the device tree binding documentation. Mention the
> > previously defined cs-gpios master node property instead.
> > 
> > Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-bus.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
> > index 800dafe..e5a4d1b 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
> > @@ -67,7 +67,7 @@ only 1(SINGLE), 2(DUAL) and 4(QUAD).
> >  Dual/Quad mode is not allowed when 3-wire mode is used.
> >  
> >  If a gpio chipselect is used for the SPI slave the gpio number will be passed
> > -via the cs_gpio
> > +via the SPI master node cs-gpios property.
> 
> here it's an information about the c structure

Is binding documentation the place for implementation notes? Especially since 
cs_gpio struct member is never mentioned in this document, and its name is 
confusingly similar to the cs-gpios property name.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org - tel: +972.2.679.5364, http://www.tkos.co.il -
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
