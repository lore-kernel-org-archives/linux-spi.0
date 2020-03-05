From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
Date: Thu, 05 Mar 2020 08:38:20 -0800
Message-ID: <e31a520573d20552223a16cf18be0674972a3fb2.camel@perches.com>
References: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
         <e265e7df-fd8c-691f-389a-c0e0e377ed9e@huawei.com>
         <84f8504924380fc6380216d03d28a2285e3d106e.camel@perches.com>
         <55edba5c-78d6-12e2-eff6-f16c204badee@huawei.com>
         <15ad3c68-4e67-0c92-a0e1-c62861673561@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <15ad3c68-4e67-0c92-a0e1-c62861673561-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2020-03-05 at 08:21 -0800, Randy Dunlap wrote:
> On 3/5/20 8:20 AM, John Garry wrote:
> > On 05/03/2020 16:01, Joe Perches wrote:
> > > On Thu, 2020-03-05 at 15:53 +0000, John Garry wrote:
> > > > On 05/03/2020 15:15, Joe Perches wrote:
> > > > > commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
> > > > > controller driver") likely inadvertently used a select statement
> > > > > with a CONFIG_ prefix, remove the prefix.
> > > > > 
> > > > > Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
> > > > 
> > > > It's a pity checkpatch can't pick this stuff up...
> > > 
> > > You are free to write a rule and submit a patch.
> > > 
> > 
> > I'm not opposed to the idea...

It'd be better I think to update the grammar
verification in the tool that parses these files.

see: scripts/kconfig/...

> > > The grammar is pretty hard to verify from a patch
> > > fragment though.
> > > 
> > > There are 2 existing nominal false positives.
> > > 
> > > $ git grep 'select\b.*\bCONFIG_' -- '*/Kconfig*'
> > > drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
> > > drivers/edac/Kconfig:     select CONFIG_ACPI_NFIT.
> > 
> > Ah, that's in the help text. I guess that those can be ignored simply based on the indentation.

The grammar is per line whitespace independent, so not necessarily.

> > drivers/platform/chrome/Kconfig:        select CONFIG_MFD_CROS_EC_DEV
> > 
> > The 2nd looks like it's incorrect.
> 
> Yes, we just got a patch for that one today.

That's the reason I submitted this one.
