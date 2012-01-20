From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: mc13xxx: add I2C support
Date: Fri, 20 Jan 2012 12:08:36 +0000
Message-ID: <20120120120836.GA18297@opensource.wolfsonmicro.com>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
 <87lip4kktc.fsf@lebrac.rtp-net.org>
 <20120119112941.GC29494@sirena.org.uk>
 <201201201855.35971.marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Arnaud Patard <arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201201201855.35971.marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 20, 2012 at 06:55:35PM +1100, Marc Reilly wrote:
> On Thursday, January 19, 2012 10:29:41 PM Mark Brown wrote:
> > On Thu, Jan 19, 2012 at 12:12:31PM +0100, Arnaud Patard wrote:

> > > I've never looked at regmap deeply but can't it be done with regmap or is
> > > it just a bad idea ?

> > Glancing quickly at the existing code it should map on reasonably well,
> > though a new format definition may be required for the 25 bit shift that
> > would be trivial.

> I'm sadly unfamiliar with regmap, is it a far superior solution? does it need 
> to used now? (ie. I'm relucant to totally rework this now. Please convince me 
> I need to if required.)

It shouldn't be a total rework - the conversion is usually just a case
of replacing the body of the current read/write functions (and ideally
also update_bits() if you've got a one of those) with the equivalent
regmap calls and adding the calls to initialise and free to the probe
functions.  This should be pretty quick and easy.

The benefit of doing the simple conversion is mostly just code sharing,
though you do also get some trace infrastructure for logging register
writes for free.  With a tiny bit more work (saying what the highest
register number is) you'd also get debugfs support for dumping the
register map which is handy for development.  With another small bit of
work (turning on a flag when registering the device and adding a
function which says which registers the chip can change itself) you can
get a register cache which gives a nice performance improvement on
read/modify/write updates as it cuts out the read.  This is useful for
things like DVFS where the regulator voltage change should be as quick
as possible.  None of this is earth shattering but it's very easy to
deploy once the infrastructure is shared.

I doubt Samuel would insist on doing this immediately, though given that
you're adding new bus support it'd be nice.
