From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v5 04/12] spi: add ti-ssp spi master driver
Date: Tue, 16 Nov 2010 13:45:54 -0700
Message-ID: <20101116204554.GB5016@angua.secretlab.ca>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
	<20101116113409.GH3338@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20101116113409.GH3338-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Nov 16, 2010 at 11:34:09AM +0000, Mark Brown wrote:
> On Tue, Nov 16, 2010 at 12:47:04AM -0700, Grant Likely wrote:
> > On Tue, Nov 16, 2010 at 12:22 AM, Grant Likely
> 
> > > Instead, it is now incumbent on the board support code to ensure that
> > > any device that depends on another device (including i2c or spi
> > > regulators) will defer registration until the prerequisite devices are
> > > bound to drivers.
> 
> You did also say you were going to write helpers to make this easier - I
> do fear that we're going to end up with far too much boiler plate code
> in machine drivers if we have to open code this.  I guess device tree is
> going to need the helpers anyway :)

Yup, and I will, but as can be seen the boilerplate required is
actually pretty minimal, and I'd like to have a couple of platforms to
work with before actually settling on what the helpers need to look
like.

> 
> > > I don't *think* this change will affect anything in this particular
> > > patch series, but if it does then let me know and I'll help you work out
> > > how to fix it using a bus notifier.
> 
> > Oh, wait, spoke too soon.  You do add a regulator in this series, so
> > this change will require a fixup.  The solution is to register an
> > bus_notifier to the spi bus type before you start registering devices.
> 
> > It also requires deferring the musb_hdrc.1 and tps6116x registrations
> > until the bus_notifier callback gets called with an indication that
> > the regulator is bound.  It will look something like this:
> 
> Did you come up with a way of handling situations like cpufreq where we
> have no device to wait for?

Haven't dug into it yet.

g.


------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
