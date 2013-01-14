From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: erase pointer to drvdata on removal
Date: Mon, 14 Jan 2013 20:11:28 +0000
Message-ID: <20130114201128.ECDD13E249D@localhost>
References: <1351793136-14126-1-git-send-email-vivien.didelot@savoirfairelinux.com> <20130114025145.GC4928@sirena.org.uk>
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130114025145.GC4928@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 14 Jan 2013 02:51:45 +0000, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Nov 01, 2012 at 02:05:36PM -0400, Vivien Didelot wrote:
> > As for i2c-core, let the SPI core handle the removal of the device's
> > drvdata, after a remove() or a probe() failure.
> 
> Any driver that notices this change is buggy, the driver shouldn't
> use a drvdata value that it didn't set.  I had thought this stuff had
> all been removed from I2C and either dropped or factored out into the
> driver core...

Looks to me like __device_release_driver() in drivers/base/dd.c already
does this.

g.


-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
