From: Christer Weinigel <christer@weinigel.se>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 13:20:04 +0200
Message-ID: <57458A64.2090901@weinigel.se>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej> <5744BC76.9090403@gmail.com>
 <20160525092034.GE1337@leverpostej> <20160525103810.GU8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525103810.GU8206@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/25/2016 12:38 PM, Mark Brown wrote:
> On Wed, May 25, 2016 at 10:20:34AM +0100, Mark Rutland wrote:
>> On Tue, May 24, 2016 at 01:41:26PM -0700, Frank Rowand wrote:
> 
>>> The code and behavior is in the Linux kernel. It should be
>>> visible in the documentation instead of being a big mystery of
>>> how it works.
> 
>> As above, I don't entirely agree. Mindlessly documenting existing
>> Linux behaviour can have the unfortuante effect of moving people
>> towards the wrong tool for the job.
> 
> Yes, this is exactly my concern - the articulated use case (which
> didn't suprise me at all) is for using spidev which is itself not
> just Linux specific but this particular version of Linux right now
> specific.  There are lots of things that happen to work but are in
> fact terrible ideas that leave messes for our future selves.  We
> need to distinguish between things that are real, meaningful system
> descriptions and things that are implementation details resulting
> from the rush to force everyone on to DT.

Oh, for *beep* *beep* sake.

It used to be very easy to use SPI devices on Linux with stable device
names.  Add a platform device entry and set bus_num.  Add spidev
entries specifying the chip select, mode, speed and other specifics
for the devices on the bus.  Then just use
/dev/spi$bus_num.$chip_select to talk to them.  Very simple to use and
understand.

Doing the same with devicetree ought to be just as simple, and since
Grant added that patch it actually is.  The behaviour is already in
the Linux kernel.  Nobody is going to rip out the of_alias_get_id
usage from the spi driver sice that will break existing userspace.
Nobody is going to rip out the spidev framework from the Linux kernel.
 The aliases mechanism which is specifically intended to provide
easy-to use names for userspace.  From "A Symphony of Flavours: Using
the device tree to describe embedded hardware" by Grant Likely and
Josh Boyer:

    In order to ease device lookup in client operating systems, it is
    often desirable to define an aliases node.  This allows one to
    provide a shorthand method for identifying a device without having
    to specify the full path on lookup.

What is so horrible about documenting the actual behaviour of the
Linux kernel?  How is documenting that serial0 = /amba@0/blah@blah"
which is ok, so markedly different from documenting spi0 =
"/amba@0/blah/blah"?
Does everything have to be so damn difficult?

Ignore the patch if you want to, I give up.  I just hope that someone
else that needs to do the same thing will find my patch with this
(ought to be) trivial documentation.

    /Christer (tired of bikeshedding)
