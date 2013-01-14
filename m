From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH] spi: erase pointer to drvdata on removal
Date: Mon, 14 Jan 2013 16:24:22 -0500 (EST)
Message-ID: <509501101.524434.1358198662068.JavaMail.root@mail.savoirfairelinux.com>
References: <20130114201128.ECDD13E249D@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130114201128.ECDD13E249D@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark, Grant,

> On Mon, 14 Jan 2013 02:51:45 +0000, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Thu, Nov 01, 2012 at 02:05:36PM -0400, Vivien Didelot wrote:
> > > As for i2c-core, let the SPI core handle the removal of the
> > > device's
> > > drvdata, after a remove() or a probe() failure.
> > 
> > Any driver that notices this change is buggy, the driver shouldn't
> > use a drvdata value that it didn't set.  I had thought this stuff
> > had
> > all been removed from I2C and either dropped or factored out into
> > the
> > driver core...
> 
> Looks to me like __device_release_driver() in drivers/base/dd.c
> already
> does this.
> 
> g.

You are right, I figured this out after the resend of this patch, see my reply here:
https://lkml.org/lkml/2012/12/4/224

    -Vivien
