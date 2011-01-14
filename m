From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] mtd: sst25l: fix reads with broken spi-masters
Date: Fri, 14 Jan 2011 14:34:33 -0800 (PST)
Message-ID: <605049.78283.qm@web180310.mail.gq1.yahoo.com>
References: <20110114222401.GA10504@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	David Woodhouse <dwmw2@infradead.org>,
	"Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>
To: H Hartley Sweeten <hartleys@visionengravers.com>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110114222401.GA10504@angua.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



--- On Fri, 1/14/11, Grant Likely <grant.likely@secretlab.ca> wrote:

> > The bug _is_ in the spi peripheral on the ep93xx.
> >=20

>=20
> No, David is correct.=A0 The fault is in the master
> driver.=A0 It is perfectly valid (and common) for spi
> peripherals to required the SS line to remain asserted over
> the entire transfer.=A0

And that's what the Linux SPI stack requires,
so any master driver that doesn't keep the
slave selected during the entiretransfer is buggy.
