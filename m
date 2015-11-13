From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: spi: OF module autoloading is still broken (was: Re: m25p80:
 Commit "allow arbitrary OF matching for "jedec,spi-nor"" breaks module
 autoloading)
Date: Fri, 13 Nov 2015 14:51:13 -0800
Message-ID: <20151113225113.GJ8456@google.com>
References: <56104E88.3040807@gmail.com>
 <20151112185926.GC8456@google.com>
 <20151113194031.GI8456@google.com>
 <20151113221228.GT12392@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-mtd@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151113221228.GT12392@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Fri, Nov 13, 2015 at 10:12:28PM +0000, Mark Brown wrote:
> On Fri, Nov 13, 2015 at 11:40:31AM -0800, Brian Norris wrote:
> 
> > (Changing subject line, because apparently some people ignore mail if it
> > doesn't have 'SPI' in the subject line)
> 
> Well, if you mean me I'm getting CCed on such a large number of large
> threads about MTD patches that only have relevance to SPI in that
> they're for a driver that uses SPI that I pretty delete a very large
> proportion of mail that looks like it's about MTD patch unread I'm
> afraid.  It's almost all completely irrelevant and uninteresting to me.

I understand, but I'm not sure how to fix that. In some cases, it's
somewhat unavoidable, since there are series that need (or at least,
think they need) upgrades to SPI infrastructure in order to support new
things in MTD. But that's rare, and most of the time, people are just
CC'ing anything and anyone that looks relevant.

Any suggestions are welcome. I'll try to discourage it when I notice.
I'm not sure documentation helps, unless we can find something people
actually read. And tooling doesn't exactly help, since
scripts/get_maintainer.pl already doesn't suggest you or linux-spi@ for
any of the drivers/mtd/spi-nor/ or drivers/mtd/devices/m25p80.c.

I feel bad for anyone on devicetree@vger.kernel.org for similar reasons,
BTW. But I guess that's a product of their own decisions. See #2 in
Documentation/devicetree/bindings/submitting-patches.txt.

> > > Is this [1] getting fixed in SPI any time soon? Looks like there was
> > > some progress [2], but AFAICT it's not completed.
> 
> Please include human readable descriptions of things like commits IDs
> and issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Sorry, I suppose I could have summarized a bit. But I didn't want to
copy-and-paste the whole thing, and Javier's work pretty clearly
explains the problem.

> > > I'd just like to know what the way forward here should be for m25p80.
> > > Really, "jedec,spi-nor" never autoloaded modules very reliably because
> > > of the SPI core constaints. So I'm not sure I'd consider this a
> > > regression, and I might be OK waiting around if it'll be fixed in a
> > > reasonable time frame.
> 
> Someone will need to tell me what the actual problem is for m25p80
> before I can understand what the way forward might be.  From a brief
> scan through of the thread it looks like if Javier's series solves the
> problem it needs a bit more analysis and/or a clearer presentation and
> probably a resubmit.

General problem:
================

The SPI core doesn't use the OF compatible property for generating
uevent/modalias, and therefore can't autoload modules based on the full
compatible property of a device. It *only* can use the 'modalias', which
is a castrated version of the compatible property -- it only includes
part of the 1st entry in 'compatible'.

This forces SPI device drivers to use spi_device_id tables even when
they might be better suited for of_match_tables.


Specifics for m25p80:
=====================

We support many flash devices and have traditionally been doing so by
simply adding more entries to the spi_device_id table. Recently, we have
tried to get away from adding new entries and aliases for every single
variation by instead supporting a common OF match: "jedec,spi-nor". So
we might expect to see nodes like this:

	flash@xxx {
		compatible = "vendor,shiny-new-device", "jedec,spi-nor";
		...
	};

We may or may not add "shiny-new-device" to the spi_device_id array. But
"jedec,spi-nor" should be sufficient to load the driver and check if the
READ ID string matches any known flash. If "shiny-new-device" isn't in
the spi_device_id array, then we don't get module autoloading.

There's also the case of omitting "vendor,shiny-new-device" entirely,
which is probably a little more dangerous, but still legal (and also
won't autoload modules):

	flash@xxx {
		compatible = "jedec,spi-nor";
		...
	};


Addendum:
=========

(This isn't the core problem I'm worried about, but I believe it serves
as commentary on Javier's patch:)

Cases like this are possible and should be considered:

	flash@xxx {
		compatible = "m25p80";
		...
	};

	flash@xxx {
		compatible = "st,m25p80";
		...
	};

	flash@xxx {
		compatible = "something-nonsensical,m25p80";
		...
	};

All three are supported by SPI's current modalias code, and so are part
of the ABI. Thus, m25p80.c will always contain both a spi_device_id
table and an of_match_table. But I think Javier's patch would break
these three cases.

Brian
