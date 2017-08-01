From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/5] treewide: Consolidate Apple DMI checks
Date: Tue, 01 Aug 2017 15:42:44 +0300
Message-ID: <1501591364.29303.318.camel@linux.intel.com>
References: <cover.1501570421.git.lukas@wunner.de>
         <20f8b74b83ed45171583fe501182c93e5c6eb4d9.1501570421.git.lukas@wunner.de>
         <1501590904.29303.316.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Zheng <lv.zheng@intel.com>,
        Darren Hart <dvhart@infradead.org>
To: Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501590904.29303.316.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 2017-08-01 at 15:35 +0300, Andy Shevchenko wrote:
> On Tue, 2017-08-01 at 14:10 +0200, Lukas Wunner wrote:
> > We're about to amend ACPI bus scan with DMI checks whether we're
> > running
> > on a Mac to support Apple device properties in AML.  The DMI checks
> > are
> > performed for every single device, adding overhead for everything
> > x86
> > that isn't Apple, which is the majority.  Rafael and Andy therefore
> > request to perform the DMI match only once and cache the result.
> > 
> > Outside of ACPI various other Apple DMI checks exist and it seems
> > reasonable to use the cached value there as well.  Rafael, Andy and
> > Darren suggest performing the DMI check in arch code and making it
> > available with a header in include/linux/platform_data/x86/.
> > 
> > To this end, add early_platform_quirks() to arch/x86/kernel/quirks.c
> > to perform the DMI check and invoke it from setup_arch().  Switch
> > over
> > all existing Apple DMI checks, thereby fixing two deficiencies:
> > 
> > * They are now #defined to false on non-x86 arches and can thus be
> >   optimized away if they're located in cross-arch code.
> > 
> > * Some of them only match "Apple Inc." but not "Apple Computer,
> > Inc.",
> >   which is used by BIOSes released between January 2006 (when the
> > first
> >   x86 Macs started shipping) and January 2007 (when the company name
> >   changed upon introduction of the iPhone).
> 
> 
> I like the idea, though I can repeat what I commented on your Github
> page.
> 
> We might need to distinguish 2006 vs 2007 Apple hardware. Thus, my
> proposal was to use unsigned int (as bitwise flags) instead of bool
> and
> provide two definitions for the hardware. Set those bits accordingly.
> In case of most of the checks it will be the same as in this patch,
> but
> leaves a flexibility of a choice.

Okay, and you answered there.

TWIMC
https://github.com/l1k/linux/commit/20f8b74b83ed45171583fe501182c93e5c6e
b4d9


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
