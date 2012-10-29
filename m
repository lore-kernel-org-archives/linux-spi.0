From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spidev: Add device tree bindings
Date: Mon, 29 Oct 2012 16:26:11 +0100
Message-ID: <508EA013.7050907@free-electrons.com>
References: <1351238873-25230-1-git-send-email-maxime.ripard@free-electrons.com>
	<1351238873-25230-2-git-send-email-maxime.ripard@free-electrons.com>
	<20121027221955.GO4564@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Brian Lilly <brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121027221955.GO4564-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

Le 28/10/2012 00:19, Mark Brown a =E9crit :
> On Fri, Oct 26, 2012 at 10:07:52AM +0200, Maxime Ripard wrote:
>> This will allow to probe spidev from device tree
> =

> So, this isn't really something we should have in DT in this format
> - the fact that we happen to control some device from userspace
> isn't a generic property of the board really, we may end up
> changing our minds on Linux too.  The most obvious thing for this
> seems to be to add the specific devices to spidev as the OF
> bindings rather than just register as some non-specific "spidev" so
> we can change our minds later about how to handle the devices.  Not
> sure that's urgently tasteful but it does mean we move the "we
> handle this in userspace" bit out of the .dts into the kernel which
> seems better.

Ok, so I guess that leaves us with 2 choices here:
  * Declare the device in the dt as you would have with any other
    driver, with its own compatible string, and we add this compatible
    string to the spidev dt ids array. It allows to use the existing
    code and thus doesn't require any effort at all, but it will
    generate a lot of noise for the spidev driver, since all of us will
    need to add its compatible string to spidev.
  * Rework the spidev code so that it behaves mostly like i2c-dev, that
    is you have an instance of it for every device enumerated in the dt,
    regardless of wether it has a driver loaded or not. If the
    userspace opens the device file corresponding to a device already
    attached to a driver, you return EBUSY, and that's it. I guess it
    would be the cleaner solution, since you only select spidev in
    configuration, but it definitely requires way more development than
    the first one.

What's your views on this?
Did you have in mind another solution?

Thanks,
Maxime

-- =

Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

---------------------------------------------------------------------------=
---
The Windows 8 Center - In partnership with Sourceforge
Your idea - your app - 30 days.
Get started!
http://windows8center.sourceforge.net/
what-html-developers-need-to-know-about-coding-windows-8-metro-style-apps/
