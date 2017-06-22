From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] ACPI / property: Support Apple _DSM properties
Date: Thu, 22 Jun 2017 16:18:11 +0200
Message-ID: <1651258.xZOMav1BfQ@aspire.rjw.lan>
References: <cover.1498044532.git.lukas@wunner.de> <2340666.WAr8RzfG0T@aspire.rjw.lan> <20170622085710.fmuftzt2soqpppyk@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170622085710.fmuftzt2soqpppyk@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thursday, June 22, 2017 10:57:10 AM Lukas Wunner wrote:
> On Thu, Jun 22, 2017 at 01:05:24AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, June 21, 2017 08:05:53 PM Lukas Wunner wrote:
> > > +/* Apple _DSM device properties GUID: a0b5b7c6-1318-441c-b0c9-fe695eaf949b */
> > > +static const u8 apple_prp_uuid[16] = {
> > > +	0xc6, 0xb7, 0xb5, 0xa0, 0x18, 0x13, 0x1c, 0x44,
> > > +	0xb0, 0xc9, 0xfe, 0x69, 0x5e, 0xaf, 0x94, 0x9b
> > > +};
> > > +
> > > +/**
> > > + * acpi_retrieve_apple_properties - retrieve and convert Apple _DSM properties
> > > + * @adev: ACPI device for which to retrieve the properties
> > > + *
> > > + * Invoke Apple's custom _DSM once to check the protocol version and once more
> > > + * to retrieve the properties.  They are marshalled up in a single package as
> > > + * alternating key/value elements, unlike _DSD which stores them as a package
> > > + * of 2-element packages.  Convert to _DSD format and make them available under
> > > + * the primary fwnode.
> > > + */
> > > +static void acpi_retrieve_apple_properties(struct acpi_device *adev)
> > > +{
> > > +	unsigned int i, j, version, newsize = 0, numprops, skipped = 0;
> > > +	union acpi_object *props, *newprops;
> > > +	void *free_space;
> > > +
> > > +	props = acpi_evaluate_dsm_typed(adev->handle, apple_prp_uuid, 1, 0,
> > > +					NULL, ACPI_TYPE_BUFFER);
> > 
> > The handling of UUIDs is going to change in 4.13, so this needs to be rebased.
> 
> Right.  The series is based on your "bleeding-edge" branch, which hasn't
> merged the "uuid-types" branch into it.  I'll base future revisions on
> "bleeding-edge" with "uuid-types" manually merged into it, but then you'll
> have to remember not to apply the series until the uuid-types branch
> has landed in Linus' tree and you've backmerged Linus' master branch.
> 
> Alternatively, you could merge the uuid-types branch.  There are no conflicts
> and Andy says it's to be considered immutable:
> 
> http://git.infradead.org/users/hch/uuid.git/shortlog/refs/heads/uuid-types

Yes, that's what I'm going to do.  I actually have other reasons to do that. :-)

Thanks,
Rafael

