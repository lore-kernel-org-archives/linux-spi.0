From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/6] ACPI / x86: Consolidate Apple DMI checks
Date: Thu, 20 Jul 2017 17:30:23 +0300
Message-ID: <1500561023.29303.147.camel@linux.intel.com>
References: <cover.1499983092.git.lukas@wunner.de>
         <a0c795358306954294e7fe31ec974f3c51b56f4c.1499983092.git.lukas@wunner.de>
         <14565365.Cyeb0SINmK@aspire.rjw.lan> <20170720140353.GA4761@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170720140353.GA4761@wunner.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2017-07-20 at 16:03 +0200, Lukas Wunner wrote:
> On Sat, Jul 15, 2017 at 12:03:31AM +0200, Rafael J. Wysocki wrote:
> > On Friday, July 14, 2017 12:36:19 AM Lukas Wunner wrote:

> I guess I could introduce a new <linux/apple.h> but I hate the insane
> proliferation of additional files in include/linux/.  I could merge
> the contents of apple_bl.h and apple-gmux.h into that new header to
> reduce the number of files a bit.

Just a side comment:

include/platform_data/x86/apple.h in this case

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
