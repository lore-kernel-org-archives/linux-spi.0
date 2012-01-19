From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] RFC: spi/sa1100: rewrite the SA1100 SPI driver
Date: Thu, 19 Jan 2012 18:49:25 +0100
Message-ID: <CACRpkdYdwKmrL6K9P05COxMVRgHECj_4CUE9COYiuFsQj5N39g@mail.gmail.com>
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
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

On Wed, Jan 18, 2012 at 1:30 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
> On Wed, Jan 18, 2012 at 01:13:29PM +0100, Linus Walleij wrote:

>> We usually merge drivers for microwire, TI, Motorola ... etc into
>> drivers/spi as well. It's a good enough fit, the differences are very
>> small. This is how we configure mode from the PL022 driver platform data:
>
> How do you send audio data at 16-bit 2 channel 48kHz continuously with
> the SPI subsystem?

Can't say because we haven't used it for audio transfers. However
I am pretty convinced that it'd work because we're running a
20 Mbit data link on that SPI port.

To get the high data rates we have an internal message queue in
the driver that saturates the SPI port. Sometimes we even start to
run parts of the driver in parallel on two cores: CPU0 is handling
IRQs from the driver while CPU1 is preparing messages to/from
the SPI subsystem.

Yours,
Linus Walleij

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
