From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2, 1/1] mtd: devices: m25p80: Add PM suspend resume
 support
Date: Tue, 29 Nov 2016 14:11:39 +0100
Message-ID: <c9198202-29d1-5e67-f675-5a53d926ede9@atmel.com>
References: <1473710494-4084-1-git-send-email-kdasu.kdev@gmail.com>
 <4fe502a4-ee01-3fb8-6697-161de814596e@atmel.com>
 <CAKekbeubczM5NpQy-Umqx-SmDM+deMcgYciyST2Sgrh2_dOsAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "Florian Fainelli" <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "Brian Norris" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kamal.dasu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKekbeubczM5NpQy-Umqx-SmDM+deMcgYciyST2Sgrh2_dOsAw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Kamal,

+Marek

Le 24/10/2016 à 20:18, Kamal Dasu a écrit :
> 
> Cyrille,
> 
> On Mon, Oct 17, 2016 at 1:08 PM, Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org <mailto:cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>> wrote:
> 
>     Hi Kamal,
> 
>     Le 12/09/2016 à 22:01, Kamal Dasu a écrit :
>     > Adding PM support so as to be able to probe spi-nor flash
>     > on resume. There are vendor specific commands to setup
>     > the transfer mode and enable read/write as part of
>     > spi_nor_scan(), done on initial probe and needed on resume().
>     > The spi-nor structure is private to the m25p driver and hence
>     > is the only place this can be done without having to duplicate
>     > code in controller driver.
> 
>     Just to be sure I've understood the purpose of this patch: here we suppose
>     that the SPI NOR memory power supply was cut when the CPU entered its suspend
>     mode. So when the CPU is resumed, the SPI NOR memory power supply is enabled
>     again as well and the internal state of the memory is reset.
> 
> 
> Memory could be intact and in refresh state. But generally the spi nor part might be powered down. 
> 
> 
>     Depending on the manufacturer, we may need to send dedicated commands so the
>     memory is ready again (for instance, a Global Unlock Block command for SST
>     memories so we can perform Sector Erase and Page Program operations).
>     Those commands are sent from spi_nor_scan(). Hence you call spi_nor_scan()
>     once again from the resume callback.
> 
> 
> Yes there are are chain of calls that setup the state of the part from spi_nor_scan that are vendor specific based on the jdec id. So yes some of the unlock commands need to be sent before we can start using the part again.
>  
> 
>     If so, your patch does make sense but I wonder whether some operations done
>     inside spi_nor_scan() and not related to the memory itself but more to other
>     layers like mtd (struct mtd_info) could always be safely performed a second
>     time. I don't know if that issue already exists or would ever exist, if so
>     it might be interesting to find a mean to tell spi_nor_scan() whether it's
>     called for the first time on this memory (boot) or not (resume).
> 
> 
> I do see the mtd settings that could be done a second time but should not cause any issues IMHO.  I don't see a need to distinguish between a (re)boot or a resume  and complicate the code. Unless somebody can point out a specific issue in doing so.

OK, so I'm fine with leaving the patch as is for now but I would like Marek
review just to be sure we didn't miss something: Marek, any comments?

I just have one more comment below but it's only a detail.

> 
>  
> 
>     Best regards,
> 
>     Cyrille
> 
> 
> 
> Thanks
> Kamal
> 
>  
> 
> 
>     > Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>     > ---
>     >  drivers/mtd/devices/m25p80.c | 68 +++++++++++++++++++++++++++++++-------------
>     >  1 file changed, 48 insertions(+), 20 deletions(-)
>     >
>     > diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>     > index 9cf7fcd..48c3f64 100644
>     > --- a/drivers/mtd/devices/m25p80.c
>     > +++ b/drivers/mtd/devices/m25p80.c
>     > @@ -186,6 +186,39 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
>     >  }
>     >
>     >  /*
>     > + * scan for spi nor flash vendor parts and setup
>     > + * read/write mode
>     > + */
>     > +static int m25p_nor_flash_scan(struct device *dev)
>     > +{
>     > +     struct m25p *flash = dev_get_drvdata(dev);
>     > +     struct flash_platform_data      *data;
>     > +     char *flash_name = NULL;
>     > +     enum read_mode mode = SPI_NOR_NORMAL;
>     > +
>     > +     data = dev_get_platdata(dev);
>     > +
>     > +     /* For some (historical?) reason many platforms provide two different
>     > +      * names in flash_platform_data: "name" and "type". Quite often name is
>     > +      * set to "m25p80" and then "type" provides a real chip name.
>     > +      * If that's the case, respect "type" and ignore a "name".
>     > +      */
>     > +     if (data && data->type)
>     > +             flash_name = data->type;
>     > +     else if (!strcmp(flash->spi->modalias, "spi-nor"))
>     > +             flash_name = NULL; /* auto-detect */
>     > +     else
>     > +             flash_name = flash->spi->modalias;
>     > +
>     > +     if (flash->spi->mode & SPI_RX_QUAD)
>     > +             mode = SPI_NOR_QUAD;
>     > +     else if (flash->spi->mode & SPI_RX_DUAL)
>     > +             mode = SPI_NOR_DUAL;
>     > +
>     > +     return spi_nor_scan(&flash->spi_nor, flash_name, mode);
>     > +}
>     > +
>     > +/*
>     >   * board specific setup should have ensured the SPI clock used here
>     >   * matches what the READ command supports, at least until this driver
>     >   * understands FAST_READ (for clocks over 25 MHz).
>     > @@ -195,8 +228,6 @@ static int m25p_probe(struct spi_device *spi)
>     >       struct flash_platform_data      *data;
>     >       struct m25p *flash;
>     >       struct spi_nor *nor;
>     > -     enum read_mode mode = SPI_NOR_NORMAL;
>     > -     char *flash_name;
>     >       int ret;
>     >
>     >       data = dev_get_platdata(&spi->dev);
>     > @@ -220,27 +251,11 @@ static int m25p_probe(struct spi_device *spi)
>     >       spi_set_drvdata(spi, flash);
>     >       flash->spi = spi;
>     >
>     > -     if (spi->mode & SPI_RX_QUAD)
>     > -             mode = SPI_NOR_QUAD;
>     > -     else if (spi->mode & SPI_RX_DUAL)
>     > -             mode = SPI_NOR_DUAL;
>     > -
>     >       if (data && data->name)
>     >               nor->mtd.name <http://mtd.name> = data->name;
>     >
>     > -     /* For some (historical?) reason many platforms provide two different
>     > -      * names in flash_platform_data: "name" and "type". Quite often name is
>     > -      * set to "m25p80" and then "type" provides a real chip name.
>     > -      * If that's the case, respect "type" and ignore a "name".
>     > -      */
>     > -     if (data && data->type)
>     > -             flash_name = data->type;
>     > -     else if (!strcmp(spi->modalias, "spi-nor"))
>     > -             flash_name = NULL; /* auto-detect */
>     > -     else
>     > -             flash_name = spi->modalias;
>     > +     ret = m25p_nor_flash_scan(nor->dev);
>     >
>     > -     ret = spi_nor_scan(nor, flash_name, mode);
>     >       if (ret)
>     >               return ret;
>     >
>     > @@ -248,7 +263,6 @@ static int m25p_probe(struct spi_device *spi)
>     >                                  data ? data->nr_parts : 0);
>     >  }
>     >
>     > -
I know this just just a detail but this chunk should not be included in
your patch since this is a cosmetic change and it has nothing to do with
the suspend/resume feature.

>     >  static int m25p_remove(struct spi_device *spi)
>     >  {
>     >       struct m25p     *flash = spi_get_drvdata(spi);
>     > @@ -319,10 +333,24 @@ static const struct of_device_id m25p_of_table[] = {
>     >  };
>     >  MODULE_DEVICE_TABLE(of, m25p_of_table);
>     >
>     > +#ifdef CONFIG_PM_SLEEP
>     > +static int m25p_suspend(struct device *dev)
>     > +{
>     > +     return 0;
>     > +}
>     > +
>     > +static int m25p_resume(struct device *dev)
>     > +{
>     > +     return m25p_nor_flash_scan(dev);
>     > +}
>     > +#endif
>     > +static SIMPLE_DEV_PM_OPS(m25p_pm_ops, m25p_suspend, m25p_resume);
>     > +
>     >  static struct spi_driver m25p80_driver = {
>     >       .driver = {
>     >               .name   = "m25p80",
>     >               .of_match_table = m25p_of_table,
>     > +             .pm     = &m25p_pm_ops,
>     >       },
>     >       .id_table       = m25p_ids,
>     >       .probe  = m25p_probe,
>     >
> 
> 

Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
