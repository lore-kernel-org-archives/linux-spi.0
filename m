From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_topcliff_pch: reload issue
Date: Wed, 2 Mar 2011 15:07:56 -0700
Message-ID: <20110302220756.GC22854@angua.secretlab.ca>
References: <7FC6F7C4A6284C0FBD95D71D76B7528D@hacdom.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'David Brownell' <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, qi.wang@intel.com,
	yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com,
	Toshiharu Okada <toshiharu-linux@dsn.okisemi.com>
To: Tomoya MORINAGA <morinaga526@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7FC6F7C4A6284C0FBD95D71D76B7528D@hacdom.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 22, 2011 at 10:22:11AM +0900, Tomoya MORINAGA wrote:
> Hi,
> 
> issue: after reload the spi module, it can't do SPI communication.
> 
> We have faced issue when execute the following command.
> insmod xxx.ko(Then, /dev/spidev0.0 is created with success)
> rmmod xxx.ko (Then, /dev/spidev0.0 is deleted with success)
> insmod xxx.ko(Then, /dev/spidev0.0 is created, however, below error message is showed)
> 
>   0000:02:0c.1: registered master spi0
>   0000:02:0c.1: chipselect 0 already in use
>   0000:02:0c.1: can't create new device for spidev
> 
> Do you have any information about the above ?

Nope, I'm not an expert on that driver, but it definitely looks like a
bug!  :-)  It *looks* like the spi_device slaves are not getting unregistered
when the driver unloads.  That's where I would start investigating.
The bug could either be in core code or the device driver itself, but
I don't know without digging deeper.

g.
