From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] spi/bcm63xx: Ensure that memory is freed only after
 it is no longer used
Date: Mon, 13 Aug 2012 13:29:35 +0100
Message-ID: <20120813122934.GB13446@opensource.wolfsonmicro.com>
References: <1344632187-9603-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Florian Fainelli <florian@openwrt.org>
To: Guenter Roeck <linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1344632187-9603-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Aug 10, 2012 at 01:56:27PM -0700, Guenter Roeck wrote:
> The call to spi_unregister_master() in the device remove function frees device
> memory, and with it any device local data. However, device local data is still
> accessed after the call to spi_unregister_master().

Applied, thanks.
