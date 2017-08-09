From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 0/5] Apple SPI properties
Date: Thu, 10 Aug 2017 00:42:38 +0200
Message-ID: <5125286.quh3iuZPLl@aspire.rjw.lan>
References: <cover.1501570421.git.lukas@wunner.de> <CAJZ5v0jzuVKzEeOG85LhANR0LWCavWmWMKL6JwxjhLqK_2RwRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-spi <linux-spi@v
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jzuVKzEeOG85LhANR0LWCavWmWMKL6JwxjhLqK_2RwRw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday, August 1, 2017 3:08:58 PM CEST Rafael J. Wysocki wrote:
> On Tue, Aug 1, 2017 at 2:10 PM, Lukas Wunner <lukas@wunner.de> wrote:
> > Retrieve device properties on Macs with an Apple-specific _DSM and
> > use them in lieu of _CRS data upon SPI slave initialization
> > in preparation of supporting the SPI keyboard on 2015+ MacBooks, v4.
> >
> > Please refer to the cover letter of v1 for further details:
> > http://www.spinics.net/lists/linux-acpi/msg75537.html
> >
> > Changes v3 -> v4:
> >
> > Patch 1:
> > - Extend consolidation of Apple DMI checks to the entire tree
> >   instead of just the ACPI core. (Rafael, Andy, Darren)
> >
> > Patches 2 - 5 are as before.
> 
> Since the majority of the material here has already been ACKed or
> reviewed by the most interested parties and it looks OK to me too, I'm
> going to take it as ACPI changes unless anyone in the CC has any
> strong opinions against that.

No objections I know of, so applied now.

Thanks,
Rafael

