From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: kconfig: When possible, compile drivers with COMPILE_TEST
Date: Fri, 16 Oct 2015 09:27:29 +0200
Message-ID: <CAMuHMdV0LO=x+wpEQX-+24CcwX2pPwTDCtABjtG=dXgTj5FkfA@mail.gmail.com>
References: <1444844510-13035-1-git-send-email-luisbg@osg.samsung.com>
	<201510160839.g2UJ3AHE%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Luis de Bethencourt <luisbg-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	"kbuild-all-JC7UmRfGjtg@public.gmane.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
To: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201510160839.g2UJ3AHE%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Oct 16, 2015 at 2:30 AM, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> [auto build test WARNING on spi/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
>
> url:    https://github.com/0day-ci/linux/commits/Luis-de-Bethencourt/spi-kconfig-When-possible-compile-drivers-with-COMPILE_TEST/20151015-014349
> config: openrisc-allyesconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=openrisc
>
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>
> All warnings (new ones prefixed by >>):
>
>    drivers/spi/spi-davinci.c: In function 'davinci_spi_chipselect':
>>> drivers/spi/spi-davinci.c:219:6: warning: 'gpio' may be used uninitialized in this function

That's a false positive...

> vim +/gpio +219 drivers/spi/spi-davinci.c
>
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  203
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  204    v &= ~bits;
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  205    iowrite32(v, addr);
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  206  }
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  207
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  208  /*
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  209   * Interface to control the chip select signal
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  210   */
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  211  static void davinci_spi_chipselect(struct spi_device *spi, int value)
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  212  {
> 212d4b69 drivers/spi/davinci_spi.c Sekhar Nori       2010-10-11  213    struct davinci_spi *dspi;
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  214    struct davinci_spi_platform_data *pdata;
> 365a7bb3 drivers/spi/spi-davinci.c Murali Karicheri  2014-09-16  215    struct davinci_spi_config *spicfg = spi->controller_data;
> 7978b8c3 drivers/spi/davinci_spi.c Brian Niebuhr     2010-08-13  216    u8 chip_sel = spi->chip_select;
> 212d4b69 drivers/spi/davinci_spi.c Sekhar Nori       2010-10-11  217    u16 spidat1 = CS_DEFAULT;
> 23853973 drivers/spi/davinci_spi.c Brian Niebuhr     2010-08-13  218    bool gpio_chipsel = false;
> a88e34ea drivers/spi/spi-davinci.c Murali Karicheri  2014-08-01 @219    int gpio;
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  220
> 212d4b69 drivers/spi/davinci_spi.c Sekhar Nori       2010-10-11  221    dspi = spi_master_get_devdata(spi->master);
> aae7147d drivers/spi/spi-davinci.c Murali Karicheri  2012-12-11  222    pdata = &dspi->pdata;
> 358934a6 drivers/spi/davinci_spi.c Sandeep Paulraj   2009-12-16  223
> c0600140 drivers/spi/spi-davinci.c Grygorii Strashko 2014-08-01  224    if (spi->cs_gpio >= 0) {
> a88e34ea drivers/spi/spi-davinci.c Murali Karicheri  2014-08-01  225            /* SPI core parse and update master->cs_gpio */
> 23853973 drivers/spi/davinci_spi.c Brian Niebuhr     2010-08-13  226            gpio_chipsel = true;
> a88e34ea drivers/spi/spi-davinci.c Murali Karicheri  2014-08-01  227            gpio = spi->cs_gpio;

... which can be avoided by removing the variables gpio_chipsel and gpio,
and replacing gpio_chipsel by "spi->cs_gpio >= 0", and gpio by "spi->cs_gpio".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
