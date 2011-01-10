From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] mtd: sst25l: fix reads with broken spi-masters
Date: Mon, 10 Jan 2011 14:20:21 -0800 (PST)
Message-ID: <909411.87280.qm@web180312.mail.gq1.yahoo.com>
References: <0D753D10438DA54287A00B027084269764CDF4146A@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	"Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>
To: linux-kernel@vger.kernel.org,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	H
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0D753D10438DA54287A00B027084269764CDF4146A@AUSP01VMBX24.collaborationhost.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



--- On Mon, 1/10/11, H Hartley Sweeten <hartleys@visionengravers.com> wrote:

> From: H Hartley Sweeten <hartleys@visionengravers.com>
> Subject: [PATCH] mtd: sst25l: fix reads with broken spi-masters

NAK.  I'm surprised you even thought to submit
such a clearly-wrong patch.

The bug is in the SPI master driver, and thus
so should the fix be.  Or make your system use
the GPIO based SPI master driver.
