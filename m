From: Vikram Narayanan <vikram186-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Configuration of MAX7301
Date: Thu, 3 Mar 2011 18:54:29 +0530
Message-ID: <AANLkTim36xzif-heRergREZuy+7BJz2=ap4zK-qUXPRX@mail.gmail.com>
References: <AANLkTi=y=5Xs1GJVsMjxH-js6pDTn37844NNAGK2oM1t@mail.gmail.com>
	<AANLkTimzhpAFgJTGtc3AZz_QKQ+Ps5iHU8ML9g8UO=9j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimzhpAFgJTGtc3AZz_QKQ+Ps5iHU8ML9g8UO=9j-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

These are the changes I have done in my board file to make the max7301 work
with S3C24xx spi driver.

static struct s3c2410_spi_info mini2440_spi0_platdata = {
    .pin_cs = S3C2410_GPG(2),
    .num_cs = 1,
    .bus_num = 0,
};

static struct max7301_platform_data max7301_info = {
    .base = -1,
};
// The base is set as -1 since from max7301.c there is a call to
gpiochip_add, which would return if there is no base set.
>From the comment in the drivers/gpio/gpiolib.c

 <http://lxr.linux.no/linux+*/drivers/gpio/gpiolib.c#L912>If
chip->base is negative, this requests dynamic assignment of
<http://lxr.linux.no/linux+*/drivers/gpio/gpiolib.c#L913>a range of
valid GPIOs.

static struct spi_board_info mini2440_spi_board_info[] __initdata = {
    {
        .modalias    = "max7301",
        .platform_data    = &max7301_info,
        .max_speed_hz    = 13000000,
        .bus_num    = 0,
        .chip_select    = 0,
        .mode        = SPI_MODE_0,
    },
};

And from board init I am configuring the pins for SPI

    s3c2410_gpio_cfgpin(S3C2410_GPE(11), S3C2410_GPE11_SPIMISO0);
    s3c2410_gpio_cfgpin(S3C2410_GPE(12), S3C2410_GPE12_SPIMOSI0);
    s3c2410_gpio_cfgpin(S3C2410_GPE(13), S3C2410_GPE13_SPICLK0);
    s3c2410_gpio_pullup(S3C2410_GPE(11), 0);
    s3c2410_gpio_pullup(S3C2410_GPE(13), 0);
    s3c2410_gpio_cfgpin(S3C2410_GPG(2), S3C2410_GPIO_OUTPUT);
    s3c_device_spi0.dev.platform_data = &mini2440_spi0_platdata;
    spi_register_board_info(mini2440_spi_board_info,
        ARRAY_SIZE(mini2440_spi_board_info));

And in the max7301.c I have changed the
spi->bits_per_word = 8;

as my SPI master driver would not initialize the value isn't equal to 8.

When I insert the max7301 module now, I am getting error which traces back
to the file drivers/gpio/gpiolib.c

    if (status)
        pr_err("gpiochip_add: gpios %d..%d (%s) not registered\n",
            chip->base, chip->base + chip->ngpio - 1,
            chip->label ? : "generic");

gpiochip add: gpios -1...26 (max7301) not registered.

I don't get a clear picture of what is wrong with the SPI configuration I
have done.
Can someone help me understanding what is wrong?

On Thu, Mar 3, 2011 at 4:37 PM, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Mar 3, 2011 at 2:57 AM, Vikram Narayanan <vikram186-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> wrote:
> > Hi,
> >
> > I am trying to interface the MAX7301 IC with my Samsung S3C2440
> processor.
> > The problem is the S3c supports only 8 bit word length for SPI transfer,
> > whereas my MAX requires 16 bit word length.
> > I couldn't find any info on the datasheet to use the IC on a 8 bit word
> > length. can i make the max7301_write function,
> >
> > static int max7301_write(struct spi_device *spi, unsigned int reg,
> unsigned
> > int val)
> > {
> >    u8 command = reg & 0x7F;
> >    u8 data = val & 0xFF;
> >    spi_write(spi, (const u8*)&command, sizeof(command));
> >    spi_write(spi, (const u8*)&data, sizeof(data));
> >    return 0;
> > }
> >
> > Will this make the IC work? Please share your ideas.
>
> If MAX7301 does require exactly 16bpw, typecasting wouldn't do.
>
> For simple control purposes, one option is to use the SPI pins with
> the common bit-banging driver.
>
> > --
> > Regards
> > Vikram
> >
> ------------------------------------------------------------------------------
> > Free Software Download: Index, Search & Analyze Logs and other IT data in
> > Real-Time with Splunk. Collect, index and harness all the fast moving IT
> data
> > generated by your applications, servers and devices whether physical,
> virtual
> > or in the cloud. Deliver compliance at lower cost and gain new business
> > insights. http://p.sf.net/sfu/splunk-dev2dev
> > _______________________________________________
> > spi-devel-general mailing list
> > spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> >
>
------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
