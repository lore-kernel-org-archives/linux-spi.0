From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [spi-devel-general] [PATCH v4] powerpc/5200: Add mpc5200-spi
	(non-PSC) device driver
Date: Fri, 3 Jul 2009 01:01:24 -0600
Message-ID: <fa686aa40907030001r731d3d29h3873803d588cdf15@mail.gmail.com>
References: <20090618025030.12363.69402.stgit@localhost.localdomain>
	<20090618065814.GA12942@pengutronix.de> <fa686aa40906180635g45724119x99cd4d1e4ede59f9@mail.gmail.com>
	<20090618142610.GC10629@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linuxppc-dev@ozlabs.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, jonsmirl@gmail.com
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756409AbZGCHBu@vger.kernel.org>
In-Reply-To: <20090618142610.GC10629@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 18, 2009 at 8:26 AM, Wolfram Sang<w.sang@pengutronix.de> wr=
ote:
>> There used to be a sysfs interface for dumping these, but it was an
>> ugly misuse. =A0I'd like to leave these in. =A0I still have the sysf=
s bits
>> in a private patch and I'm going to rework them for debugfs.
>
> Okay. Maybe a comment stating the future use will be nice.

okay

>> > But I wonder more about the usage of the SS pin and if this chipse=
l is needed
>> > at all (sadly I cannot test as I don't have any board with SPI con=
nected to
>> > that device). You define the SS-pin as output, but do not set the =
SSOE-bit.
>> > More, you use the MODF-feature, so the SS-pin should be defined as=
 input?
>> > According to Table 17.3 in the PM, you have that pin defined as ge=
neric purpose
>> > output.
>>
>> That's right. =A0The SS handling by the SPI device is completely
>> useless, so this driver uses it as a GPIO and asserts it manually.
>
> That definately needs a comment :D (perhaps with some more details if=
 you know them).
>
>> The MODF irq is probably irrelevant, but I'd like to leave it in for
>> completeness.
>
> But it won't work if the pin is set to output, no?

yes

> Are you sure there are no side-effects?

I'm sure.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
