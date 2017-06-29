From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 4/4] spi: Use Apple device properties in absence of
 ACPI resources
Date: Thu, 29 Jun 2017 10:54:18 +0300
Message-ID: <20170629075418.GB629@lahna.fi.intel.com>
References: <cover.1498636759.git.lukas@wunner.de>
 <bca7fb9e406bbfa9ee7e8457cacd34418ef689be.1498636759.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Ronald Tschalaer <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>,
        Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Daniel Roschka <danielroschka-d2qyoUQsf3ABe69/dCFm4g@public.gmane.org>,
        linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <bca7fb9e406bbfa9ee7e8457cacd34418ef689be.1498636759.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 28, 2017 at 07:20:19PM +0200, Lukas Wunner wrote:
> MacBooks and MacBook Pros introduced since 2015 return empty _CRS data
> for SPI slaves, causing device initialization to fail.  Most of the
> information that would normally be conveyed via _CRS is available
> through ACPI device properties instead, so take advantage of them.
> 
> The meaning and appropriate usage of the device properties was reverse
> engineered by Ronald Tschalär and carried over from these commits
> authored by him:
> 
> https://github.com/cb22/macbook12-spi-driver/commit/9a416d699ef4
> https://github.com/cb22/macbook12-spi-driver/commit/0c34936ed9a1
> 
> According to Ronald, the device properties have the following meaning:
> 
> spiSclkPeriod   /* period in ns */
> spiWordSize     /* in number of bits */
> spiBitOrder     /* 1 = MSB_FIRST, 0 = LSB_FIRST */
> spiSPO          /* clock polarity: 0 = low, 1 = high */
> spiSPH          /* clock phase: 0 = first, 1 = second */
> spiCSDelay      /* delay between cs and receive on reads in 10 us */
> resetA2RUsec    /* active-to-receive delay? */
> resetRecUsec    /* receive delay? */
> 
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Federico Lorenzi <florenzi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reported-by: Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Ronald Tschalär <ronald-Cgq6lnktLNMTaf21n8AfGQ@public.gmane.org>
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>

Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
