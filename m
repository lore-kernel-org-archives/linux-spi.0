From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 4/5] ACPI / scan: Recognize Apple SPI and I2C slaves
Date: Tue, 1 Aug 2017 16:12:22 +0300
Message-ID: <20170801131222.GN2369@lahna.fi.intel.com>
References: <cover.1501570421.git.lukas@wunner.de>
 <a113ce387bb9af7aaf804359561178d8f1499ef0.1501570421.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a113ce387bb9af7aaf804359561178d8f1499ef0.1501570421.git.lukas@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Aug 01, 2017 at 02:10:41PM +0200, Lukas Wunner wrote:
> SPI and I2C slaves are enumerated by their respective parents rather
> than the ACPI core.  They are recognized by presence of _CRS resources,
> which however are missing on Macs.  Check for presence of device
> properties instead.
> 
> Cc: Federico Lorenzi <florenzi@gmail.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
