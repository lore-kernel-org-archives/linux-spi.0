From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: Unbalanced calls to spi_master_get in coldfire-qspi and s3c64xx
 SPI master drivers
Date: Thu, 16 Aug 2012 14:27:49 +0530
Message-ID: <CAJuYYwRKVOh91xmeD=FpShzJskwv5LhioUG88F=9vMysOBq4Kw@mail.gmail.com>
References: <20120813214425.GA19547@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	linux-samsung-soc@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
To: Guenter Roeck <linux@roeck-us.net>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20120813214425.GA19547@roeck-us.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 14 August 2012 03:14, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi all,
>
> looking through SPI master drivers, I noticed that the following drivers call
> spi_master_get() in their suspend and resume functions. Yet, there is no
> matching call to spi_master_put(), meaning the reference count will increase
> with each suspend/resume cycle.
>         spi-coldfire-qspi.c
>         spi-s3c64xx.c
> Other SPI master drivers also support suspend and resume, but do not call
> spi_master_get() in the suspend/resume functions. The spi-pl022 driver calls
> spi_master_suspend() and spi_master_resume() like the above, but does not
> call spi_master_get() either.
>
> This leads me to believe that the above drivers will hang on unload after a
> suspend/resume cycle due to the extra references.
>
> Can someone please have a look and confirm if my understanding is correct ?
> If so I'll send a set of patches to fix the problems.

For spi-s3c64xx.c, yes it does seem that the spi_master_get() and
spi_master_put() calls are not balanced.  The probable change could be

-  struct spi_master *master = spi_master_get(dev_get_drvdata(dev));
+ struct spi_master *master = dev_get_drvdata(dev);

Thanks,
Thomas.
