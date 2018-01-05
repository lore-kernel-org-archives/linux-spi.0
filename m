From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: spi-gpio: Rewrite to use GPIO descriptors
Date: Thu, 4 Jan 2018 23:34:18 -0800
Message-ID: <20180105073418.lxaaoxwlyxt7o2yh@localhost>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
        Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>,
        Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>,
        Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180101133749.29567-3-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jan 01, 2018 at 02:37:46PM +0100, Linus Walleij wrote:
> This converts the bit-banged GPIO SPI driver to looking up and
> using GPIO descriptors to get a handle on GPIO lines for SCK,
> MOSI, MISO and all CS lines.
> 
> All existing board files are converted in one go to keep it all
> consistent. With these conversions I rarely find any interrim
> steps that makes any sense.
> 
> Device tree probing and GPIO handling should work like before
> also after this patch.
> 
> For board files, we stop using controller data to pass the GPIO
> line for chip select, instead we pass this as a GPIO descriptor
> lookup like everything else.
> 
> In some s3c24xx machines the names of the SPI devices were set to
> "spi-gpio" rather than "spi_gpio" which can never have worked, I
> fixed it working (I guess) as part of this patch set. Sometimes
> I wonder how this code got upstream in the first place, it
> obviously is not tested.
> 
> mach-s3c64xx/mach-smartq.c has the same problem and additionally
> defines the *same* GPIO line for MOSI and MISO which is not going
> to be accepted by gpiolib. As the lines were number 1,2,2 I assumed
> it was a typo and use lines 1,2,3. A comment gives awat that line 0
> is chip select though no actual SPI device is provided for the LCD
> supposed to be on this bit-banged SPI bus. I left it intact instead
> of just deleting the bus though.
> 
> Kill off board file code that try to initialize the SPI lines
> to the same values that they will later be set by the spi_gpio
> driver anyways. Given the huge number of weird things in these
> board files I do not think this code is very tested or put in
> with much afterthought anyways.
> 
> Cc: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org # Request ACK
> Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> # Request ACK
> Cc: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> # S3C stuff
> Cc: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> # S3C stuff
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> # S3C Jive
> Cc: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org> # S3C qt2410
> Cc: Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> # MIPS db1000
> Cc: Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org> # JZ4740
> Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org> # EEPROM hack
> Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Acked-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
