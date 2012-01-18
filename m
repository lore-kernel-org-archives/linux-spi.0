From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH] RFC: spi/sa1100: rewrite the SA1100 SPI driver
Date: Wed, 18 Jan 2012 13:36:49 +0000
Message-ID: <20120118133649.GG1068@n2100.arm.linux.org.uk>
References: <1326841236-25178-1-git-send-email-linus.walleij@linaro.org>
	<20120117231314.GA1068@n2100.arm.linux.org.uk>
	<CACRpkdbynmvcjOY=7_6wK3YTJHpS16Y0fU-Ka3-qw6Vt+eXy0A@mail.gmail.com>
	<20120118123037.GF1068@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kristoffer Ericson <kristoffer.ericson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120118123037.GF1068-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 18, 2012 at 12:30:37PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2012 at 01:13:29PM +0100, Linus Walleij wrote:
> > On Wed, Jan 18, 2012 at 12:13 AM, Russell King - ARM Linux
> > <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> > 
> > > Please don't delete the above definitions.
> > 
> > OK don't want to break anything...
> > 
> > > The SSP interface is more than just SPI (it's microwire and TI format,
> > > and I have a working ASoC driver for the Assabet.)
> > 
> > We usually merge drivers for microwire, TI, Motorola ... etc into
> > drivers/spi as well. It's a good enough fit, the differences are very
> > small. This is how we configure mode from the PL022 driver platform data:
> 
> How do you send audio data at 16-bit 2 channel 48kHz continuously with
> the SPI subsystem?

Actually, feel free to move these definitions; my ASoC SSP driver already
contains a cleaner copy of them.

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
