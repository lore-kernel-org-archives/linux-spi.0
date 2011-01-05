From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] spi_topcliff_pch: support new device ML7213
Date: Wed, 5 Jan 2011 09:38:35 -0700
Message-ID: <20110105163835.GD17272@angua.secretlab.ca>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com>
 <20101229064937.GC8172@angua.secretlab.ca>
 <280596192AA74D208C2C5F6389DBE8C1@hacdom.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, qi.wang@intel.com,
	yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com,
	Toshiharu Okada <toshiharu-linux@dsn.okisemi.com>
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <280596192AA74D208C2C5F6389DBE8C1@hacdom.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 05, 2011 at 11:34:20AM +0900, Tomoya MORINAGA wrote:
> Hi Grant,
> 
> On Wednesday, December 29, 2010 3:49 PM, Grant Likely wrote:
> >As previously discussed on this list, I would like to see support for
> >multiple bus instances implemented differently.  Rather than storing
> >the spi_master instances in an array in the pci device private data,
> >the pci device should register a separate platform_device for each spi
> >bus instance, and each of those bus instances should get bound to a
> >topcliff_spi_bus driver which doesn't need to have any special
> >knowledge about how many spi_master instances actually exist.
> >
> >Basically, the way it is implemented in this patch isn't taking
> >advantage of the infrastructure and instance management provided by
> >the driver model.
> 
> I see.
> I will modify like your suggestion.
> Could you show the reference SPI driver using multi-instance ?

In an multi-instance scenario, the spi driver is just a plain-jane
platform_driver.  There isn't anything special about it.  Instead, the
pci_driver becomes responsible to register one or more platform
devices for the child busses.  Much like one of the multifunction
devices in drivers/mfd.

As far as examples go, drivers/mfd/timberdale.c seems reasonable, if a
bit larger than what you need.

g.

> 
> Thanks,
> ---
> Tomoya MORINAGA
> OKI SEMICONDUCTOR CO., LTD.
> 
