From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [spi-devel-general] [patch 2.6.27-git] spi_gpio driver
Date: Mon, 20 Oct 2008 10:11:27 +0100
Message-ID: <20081020091127.GA4413@trinity.fluff.org>
References: <200807202146.12759.mb@bu3sch.de> <200810181354.23955.david-b@pacbell.net> <aec7e5c30810191944u4c125943h895099b3f1eaa813@mail.gmail.com> <200810192124.36402.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel <linux-kernel@vger.kernel.org>
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752324AbYJTILu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200810192124.36402.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Oct 19, 2008 at 09:24:36PM -0700, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Generalize the old at91rm9200 "bootstrap" bitbanging SPI master driver
> as "spi_gpio", so it works with arbitrary GPIOs and can be configured
> through platform_data.  Such SPI masters support:
> 
>  - any number of bus instances (bus_num is the platform_device.id)
>  - any number of chipselects (one GPIO per spi_device)
>  - all four SPI_MODE values, and SPI_CS_HIGH
>  - i/o word sizes from 1 to 32 bits;
>  - devices configured as with any other spi_master controller

Probably worth looking at removing the s3c24xx gpio specific driver and
replacing it with this.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
