From: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] mtd: devices: m25p80: Add PM suspend resume support
Date: Mon, 12 Sep 2016 16:06:50 -0400
Message-ID: <CAC=U0a3Pm=raVj0HnBjwiyf0eZNnCv4KP=uys31fk1UxtYdTqQ@mail.gmail.com>
References: <1473448438-13245-1-git-send-email-kdasu.kdev@gmail.com> <CAMuHMdUb6nhzzkPy4z1tFouM+FAsNKhh=EXYFTSL00ziSUcKqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list"
        <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdUb6nhzzkPy4z1tFouM+FAsNKhh=EXYFTSL00ziSUcKqw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Geert,

 I agree that scan code can be refactored into a common function to be
called by probe and resume. Will send a v2 patch with the changes.

Thanks
Kamal

On Sun, Sep 11, 2016 at 6:10 AM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> On Fri, Sep 9, 2016 at 9:13 PM, Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Adding PM support so as to be able to probe spi-nor flash
>> on resume. There are vendor specific commands to setup
>> the transfer mode and enable read/write as part of
>> spi_nor_scan(), done on intial probe and needed on resume().
>> The spi-nor stucture is private to the m25p driver and hence
>> is the only place this can be done without having to duplicate
>> code in controller driver.
>>
>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/mtd/devices/m25p80.c | 37 ++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>> index 9cf7fcd..f8294b4 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>
>> +static int m25p_resume(struct device *dev)
>> +{
>> +       struct m25p *flash = dev_get_drvdata(dev);
>> +       struct flash_platform_data      *data;
>> +       char *flash_name = NULL;
>> +       enum read_mode mode = SPI_NOR_NORMAL;
>> +       int ret;
>> +
>> +       data = dev_get_platdata(&flash->spi->dev);
>> +
>> +       if (data && data->type)
>> +               flash_name = data->type;
>> +       else if (!strcmp(flash->spi->modalias, "spi-nor"))
>> +               flash_name = NULL; /* auto-detect */
>> +       else
>> +               flash_name = flash->spi->modalias;
>> +
>> +       if (flash->spi->mode & SPI_RX_QUAD)
>> +               mode = SPI_NOR_QUAD;
>> +       else if (flash->spi->mode & SPI_RX_DUAL)
>> +               mode = SPI_NOR_DUAL;
>> +
>> +       ret = spi_nor_scan(&flash->spi_nor, flash_name, mode);
>
> All of the above is also done in m25p_probe(). Hence please factor out the
> commonalities into its own function.
>
>> +
>> +       return ret;
>> +}
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
